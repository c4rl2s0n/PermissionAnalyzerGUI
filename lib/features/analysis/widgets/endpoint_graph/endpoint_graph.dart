// Copyright (c) 2023- All flutter_graph_view authors. All rights reserved.
//
// This source code is licensed under Apache 2.0 License.

import 'package:flutter/material.dart';
import 'package:flutter_graph_view/flutter_graph_view.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/common/keys.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';
import 'package:permission_analyzer_gui/features/analysis/models/models.dart';
import 'package:permission_analyzer_gui/features/analysis/colors.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/config_builder.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/endpoint_graph/widgets/widgets.dart';

import 'graph_utils/utils.dart';
import 'models/models.dart';

class EndpointGraph extends StatelessWidget {
  const EndpointGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return ConfigBuilder(
      buildWhenAnalysis: (oldState, state) =>
          oldState.enabledGroups != state.enabledGroups ||
          oldState.endpoints != state.endpoints ||
          oldState.visibleConnections != state.visibleConnections ||
          oldState.visibleTrafficGroups != state.visibleTrafficGroups,
      buildWhenAnalysisConfig: (oldState, state) =>
          oldState.groupConnections != state.groupConnections,
      builder: (context, analysisState, configState) =>
          _graphWidget(context, analysisState),
    );
  }

  Widget _graphWidget(BuildContext context, AnalysisState state) {
    if (state.endpoints.isEmpty) {
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
                        CoulombDecorator(k: 420, sameTagsFactor: 0.5),
                        HookeBorderDecorator(),
                        HookeDecorator(),
                        CoulombCenterDecorator(k: 60),
                        HookeCenterDecorator(k: 0.005),
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
          ..panelDelay = const Duration(milliseconds: 200)
          ..graphStyle = (CustomGraphStyle()
            ..vertexTextStyleGetter = ((vertex, vertexShape) =>
                _vertexTextStyleGetter(context, vertex, vertexShape))
            // tagColor is prior to tagColorByIndex. use vertex.tags to get color
            ..tagColor = graphTagColors
            ..tagColorByIndex = [])
          ..edgePanelBuilder = ((edge, viewfinder) =>
              GraphComponents.edgePanelBuilder(context, edge, viewfinder))
          ..vertexPanelBuilder = ((vertex, viewfinder) =>
              GraphComponents.vertexPanelBuilder(context, vertex, viewfinder))
          ..edgeShape = CustomEdgeLineShape() // default is EdgeLineShape.
          ..vertexShape = VertexCircleShape() // default is VertexCircleShape.
          ..textGetter = _vertexTextGetter,
      ),
    );
  }

  String _vertexTextGetter(Vertex vertex) {
    if (vertex.data is! GraphVertex) {
      return vertex.id;
    }
    if (vertex.data is EndpointVertex) {
      EndpointVertex ev = vertex.data as EndpointVertex;
      return ev.endpoint.displayName;
    }
    GraphVertex gv = vertex.data as GraphVertex;
    return gv.name;
  }

  TextStyle? _vertexTextStyleGetter(
    BuildContext context,
    Vertex<dynamic> vertex,
    VertexShape? vertexShape,
  ) =>
      context.textTheme.labelSmall?.copyWith(
          color: context.textTheme.labelSmall?.color?.withOpacity(
              vertex.data is TrafficGroupVertex || vertex.isHovered || vertex.neighborEdges.any((e) => e.isHovered)
                  ? 1
                  : vertex.neighbors.any((n) => n.isHovered)
                      ? 0.9
                      : 0.4));

  List<GraphVertex> _vertices(AnalysisState state) {
    List<INetworkEndpoint> endpoints = state.visibleEndpoints;
    List<TrafficGroup> trafficGroups = state.visibleTrafficGroups;
    List<GraphVertex> vertexes = [
      ...endpoints.map((e) => EndpointVertex(
          id: e.id,
          endpoint: e,
          name: state.config.groupConnections
              ? e.displayName
              : e.name)), //GraphVertex(endpoint: e, id: e.ip)),
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

  void _computeEndpointVertexAttributes(
    AnalysisState state,
    EndpointVertex vertex,
    int nTotalGroups,
    int nTotalEndpoints,
  ) {
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
        .sortedCopy((a, b) => state.config.trafficLoadInPackets
            ? a.countTotal.compareTo(b.countTotal)
            : a.bytesTotal.compareTo(b.bytesTotal))
        .last;
    int maxConnectionTrafficLoad = state.config.trafficLoadInPackets
        ? strongestConnection.countTotal
        : strongestConnection.bytesTotal;

    List<INetworkEndpoint> endpoints = state.endpoints;
    for (var group in state.visibleTrafficGroups) {
      List<INetworkConnection> groupConnections =
          TrafficAnalyzer.groupIConnectionsByEndpoint(group.connections);
      for (var connection in groupConnections) {
        if (!endpoints.any((e) => e.id == connection.endpoint.id)) {
          continue;
        }
        //int totalTrafficLoad = TrafficAnalyzer.getTrafficLoad(state.visibleConnections.where((c) => c.endpoint.id == connection.endpoint.id), inPackets: state.trafficLoadInPackets,);
        double trafficShare = TrafficAnalyzer.getTrafficLoad(
              [connection],
              inPackets: state.config.trafficLoadInPackets,
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


}
