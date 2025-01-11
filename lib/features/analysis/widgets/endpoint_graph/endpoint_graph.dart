// Copyright (c) 2023- All flutter_graph_view authors. All rights reserved.
//
// This source code is licensed under Apache 2.0 License.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graph_view/flutter_graph_view.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/common/keys.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';
import 'package:permission_analyzer_gui/features/analysis/models/models.dart';
import 'package:permission_analyzer_gui/features/analysis/values.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/endpoint_graph/widgets/widgets.dart';

import 'graph_utils/utils.dart';
import 'models/models.dart';

class EndpointGraph extends StatelessWidget {
  const EndpointGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalysisCubit, AnalysisState>(
      buildWhen: (oldState, state) =>
          oldState.connectionsGrouped != state.connectionsGrouped ||
          oldState.enabledGroups != state.enabledGroups ||
          oldState.endpoints != state.endpoints ||
          oldState.visibleConnections != state.visibleConnections ||
          oldState.visibleTrafficGroups != state.visibleTrafficGroups,
      builder: _graphWidget,
    );
  }

  Widget _graphWidget(BuildContext context, AnalysisState state) {
    if(state.endpoints.isEmpty){
      return const Center(child: Text("No Endpoints to show."));
    }
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(shape: BoxShape.rectangle),
      child: FlutterGraphWidget(
        data: GraphData(_vertices(state), _edges(state)),
        algorithm: TagCircleLayout(
          tag: tGroup,
          decorators: [
            PauseDecorator(),
            LegendDecorator(handleOverlay: legendOverlayBuilder(), decorators: [
              TagDecorator(
                taggedDecorators: {
                  tGroup: [CircleLayout(decorators: [])],
                  tEndpoint: [
                    RandomLayout(
                      decorators: [
                        CoulombDecorator(k: 70, sameTagsFactor: 1),
                        HookeBorderDecorator(),
                        HookeDecorator(),
                        CoulombCenterDecorator(k: 100),
                        HookeCenterDecorator(k: 0.01),
                        ForceDecorator(),
                        ForceMotionDecorator(),
                        TimeCounterDecorator(),
                      ],
                    ),
                  ],
                },
              ),
            ]),
          ],
        ),
        convertor: EndpointAnalysisConverter(), // MapConvertor(),
        options: Options()
          ..useLegend = false
          ..enableHit = false
          ..panelDelay = const Duration(milliseconds: 500)
          ..graphStyle = (GraphStyle()
            ..vertexTextStyleGetter = ((vertex, vertexShape) =>
                _vertexTextStyleGetter(context, vertex, vertexShape))
            // tagColor is prior to tagColorByIndex. use vertex.tags to get color
            ..tagColor = graphTagColors
            ..tagColorByIndex = [])
          ..edgePanelBuilder = ((edge, viewfinder) =>
              edgePanelBuilder(context, edge, viewfinder))
          ..vertexPanelBuilder = ((vertex, viewfinder) =>
              vertexPanelBuilder(context, vertex, viewfinder))
          ..edgeShape = CustomEdgeLineShape() // default is EdgeLineShape.
          ..vertexShape = VertexCircleShape() // default is VertexCircleShape.
          ..textGetter = _vertexTextGetter,
      ),
    );
  }

  String _vertexTextGetter(Vertex vertex) {
    if (vertex.data is! GraphVertex) return vertex.id;
    GraphVertex gv = vertex.data as GraphVertex;
    return gv.name;
  }

  TextStyle? _vertexTextStyleGetter(BuildContext context,
          Vertex<dynamic> vertex, VertexShape? vertexShape) =>
      context.textTheme.labelSmall?.copyWith(
          color:
              context.textTheme.labelSmall?.color?.withOpacity(vertex.isHovered
                  ? 1
                  : vertex.neighbors.any((n) => n.isHovered)
                      ? 0.9
                      : 0.4));

  List<GraphVertex> _vertices(AnalysisState state) {
    List<INetworkEndpoint> endpoints = state.endpoints;
    List<TrafficGroup> trafficGroups = state.visibleTrafficGroups;
    List<GraphVertex> vertexes = [
      ...endpoints.map((e) => EndpointVertex(
          id: e.id,
          endpoint: e,
          name: state.connectionsGrouped
              ? e.displayName
              : e.hostname ?? e.ip)), //GraphVertex(endpoint: e, id: e.ip)),
      ...trafficGroups.map((g) => TrafficGroupVertex(
          id: g.id, group: g)), // GraphVertex(group: g, id: g.id))
    ];
    int nTotalEndpoints = endpoints.length;
    int nTotalGroups = trafficGroups.length;
    for (var vertex in vertexes) {
      if (vertex is EndpointVertex) {
        _computeEndpointVertexAttributes(
          state,
          vertex,
          nTotalGroups,
          nTotalEndpoints,
        );
      } else if (vertex is TrafficGroupVertex) {
        _computeTrafficGroupVertexAttributes(state, vertex, nTotalEndpoints);
      }
    }
    return vertexes;
  }

  void _computeEndpointVertexAttributes(AnalysisState state,
      EndpointVertex vertex, int nTotalGroups, int nTotalEndpoints) {
    INetworkEndpoint endpoint = vertex.endpoint;
    int connectedGroups = state.visibleTrafficGroups
        .where((g) => g.connections.any((gc) => gc.endpoint.id == endpoint.id))
        .length;
    if (nTotalGroups != 1) {
      vertex.unique = connectedGroups == 1;
      vertex.common = connectedGroups == nTotalGroups;
    }
    if (endpoint is EndpointGroup) {
      vertex.size = endpoint.endpoints.length / nTotalEndpoints;
    } else {
      // if connections are not grouped, vertex size represents the number of connected groups
      vertex.size = connectedGroups / nTotalGroups;
    }
    vertex.connectedGroups = connectedGroups;
  }

  void _computeTrafficGroupVertexAttributes(
      AnalysisState state, TrafficGroupVertex vertex, int nTotalEndpoints) {
    TrafficGroup group = vertex.group;
    int nEndpoints = group.endpoints.length;
    vertex.size = nEndpoints / nTotalEndpoints;
  }

  List<GraphEdge> _edges(AnalysisState state) {
    List<GraphEdge> edges = [];
    INetworkConnection strongestConnection = state.visibleConnections
        .sortedCopy((a, b) => state.trafficLoadInPackets
            ? a.countTotal.compareTo(b.countTotal)
            : a.bytesTotal.compareTo(b.bytesTotal))
        .last;
    int maxConnectionTrafficLoad = state.trafficLoadInPackets
        ? strongestConnection.countTotal
        : strongestConnection.bytesTotal;

    List<INetworkEndpoint> endpoints = state.endpoints;
    for (var group in state.visibleTrafficGroups) {
      for (var connection in group.connections) {
        if (!endpoints.any((e) => e.id == connection.endpoint.id)) {
          continue;
        }
        //int totalTrafficLoad = TrafficAnalyzer.getTrafficLoad(state.visibleConnections.where((c) => c.endpoint.id == connection.endpoint.id), inPackets: state.trafficLoadInPackets,);
        double trafficShare = TrafficAnalyzer.getTrafficLoad(
              [connection],
              inPackets: state.trafficLoadInPackets,
            ) /
            maxConnectionTrafficLoad;
        edges.add(GraphEdge(
          src: group,
          dst: connection,
          size: trafficShare,
          common: state.testRunCount(connection) == group.testRuns,
        ));
      }
    }
    return edges;
  }

  Widget edgePanelBuilder(
      BuildContext context, Edge edge, Viewfinder viewfinder) {
    AnalysisState state = context.analysisCubit.state;
    GraphEdge edgeData = edge.data as GraphEdge;
    String trafficLoadIn = "";
    String trafficLoadOut = "";
    if (state.trafficLoadInPackets) {
      trafficLoadIn = "Count: ${edgeData.dst.inCount}";
      trafficLoadOut = "Count: ${edgeData.dst.outCount}";
    } else {
      trafficLoadIn = "Volume: ${edgeData.dst.inBytes.readableFileSize()}";
      trafficLoadOut = "Volume: ${edgeData.dst.outBytes.readableFileSize()}";
    }
    List<List<String>> entries = [
      ["IN", trafficLoadIn],
      ["Out", trafficLoadOut],
      [
        "Protocols",
        ...edgeData.dst.protocols
            .map((p) => p.replaceAll("sll:ethertype:ip:", ""))
      ],
      if (edgeData.common) ["Used in all tests"],
    ];
    return _infoPanel(
      context,
      viewfinder,
      edge.position,
      child: _infoPanelContent(
        context,
        "${edgeData.src.name} -> ${"${edgeData.dst.endpoint.displayName}:${edgeData.dst.ports}"}",
        entries, //"IN:\n$tab$trafficLoadIn\nOUT:\n$tab$trafficLoadOut\nProtocols:\n$protocols${edgeData.common ? "\nUsed in all tests" : ""}",
      ),
    );
  }

  Widget vertexPanelBuilder(
    BuildContext context,
    hoverVertex,
    Viewfinder viewfinder,
  ) {
    return _infoPanel(
      context,
      viewfinder,
      hoverVertex.cpn!.position,
      offsetLeft: hoverVertex.radius,
      offsetTop: -20,
      child: _buildVertexPanel(context, hoverVertex.data),
    );
  }

  Widget _infoPanel(
    BuildContext context,
    Viewfinder vf,
    Vector2 position, {
    double offsetLeft = 0,
    double offsetTop = 0,
    required Widget child,
  }) {
    var c = vf.localToGlobal(position);
    return Stack(
      children: [
        Positioned(
          left: c.x + 5 + offsetLeft,
          top: c.y - offsetTop,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Container(
              //width: 340,
              padding: EdgeInsets.all(context.constants.smallSpacing),
              decoration: BoxDecoration(
                color: Colors.grey.shade900.withAlpha(200),
                border: Border.all(color: Colors.white70),
                borderRadius:
                    BorderRadius.all(context.constants.roundedCornerRadius),
              ),
              child: child,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVertexPanel(BuildContext context, GraphVertex vertex) {
    if (vertex.data is INetworkEndpoint) {
      return _endpointVertexPanelBuilder(context, vertex);
    } else if (vertex.data is TrafficGroup) {
      return _groupVertexPanelBuilder(context, vertex.data);
    }
    return const Text("???");
  }

  Widget _infoPanelContent(
          BuildContext context, String title, List<List<String>> entries) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.titleMedium,
          ),
          Margin.vertical(context.constants.largeSpacing),
          ...entries
              .map<Widget>(
                (entry) => Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        "${entry[0]}:",
                        style: context.textTheme.labelMedium,
                      ),
                    ),
                    if (entry.length > 1) ...[
                      Margin.horizontal(context.constants.spacing),
                      Text(
                        entry.sublist(1).join("\n"),
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ],
                ),
              )
              .toList()
              .insertBetweenItems(
                  () => Margin.vertical(context.constants.smallSpacing)),
        ],
      );

  Widget _endpointVertexPanelBuilder(BuildContext context, GraphVertex v) {
    INetworkEndpoint e = v.data as INetworkEndpoint;
    AnalysisState state = context.analysisCubit.state;
    if (e is NetworkEndpoint) {
      List<List<String>> entries = [
        ["IP", e.ip],
        if (e.hasHostname) ["Hostname", e.hostname!],
        ["# Connected Groups", v.connectedGroups.toString()],
      ];
      return _infoPanelContent(
        context,
        state.connectionsGrouped ? e.displayName : e.hostname ?? e.ip,
        entries, //'IP: ${e.ip}\n${e.hostname != null ? "Hostname: ${e.hostname}\n" : ""}# Connected Groups: ${v.connectedGroups}',
      );
    } else if (e is EndpointGroup) {
      List<List<String>> entries = [
        ["IP", e.ip],
        if (e.hasHostname) ["Domain", e.domain!],
        [
          "Endpoints",
          ...e.endpoints
              .map((ep) => ep.hostname ?? ep.ip)
              .toList()
              .sortedCopy((String a, String b) => compareHostnames(a, b))
        ],
        ["# Connected Groups", v.connectedGroups.toString()],
      ];
      return _infoPanelContent(
        context,
        e.displayName,
        entries,
      );
    }
    return const Text("Unknown");
  }

  Widget _groupVertexPanelBuilder(BuildContext context, TrafficGroup g) =>
      _infoPanelContent(
        context,
        'Name: ${g.name}',
        [
          ["# Connections", g.connections.length.toString()],
          if (g.info != null && g.info!.isNotEmpty) ["Info", g.info!],
        ], //'# Connections: ${g.connections.length}${g.info != null ? "\n${g.info}" : ""}',
      );
}
