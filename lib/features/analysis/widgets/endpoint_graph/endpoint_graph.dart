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
      builder: _graphWidget,
    );
  }

  Widget _graphWidget(BuildContext context, AnalysisState state) {
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
            ..vertexTextStyleGetter = ((_, __) => context.textTheme.labelSmall)
            // tagColor is prior to tagColorByIndex. use vertex.tags to get color
            ..tagColor = tagColors
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

  String _vertexTextGetter(Vertex vertex){
    if(vertex.data is! GraphVertex) return vertex.id;
    GraphVertex gv = vertex.data as GraphVertex;
    if(gv is EndpointVertex){
      return gv.endpoint.name;
    }else if(gv is TestGroupVertex){
      return gv.name;
    }
    return vertex.id;
  }

  List<GraphVertex> _vertices(AnalysisState state) {
    List<GraphVertex> vertexes = [
      ...state.endpoints.map((e) => EndpointVertex(id: e.id, endpoint: e)), //GraphVertex(endpoint: e, id: e.ip)),
      ...state.visibleTrafficGroups.map((g) => TestGroupVertex(id: g.id, group: g)),// GraphVertex(group: g, id: g.id))
    ];
    int totalGroups = state.visibleGroups.length;
    for (var vertex in vertexes) {
      dynamic data = vertex.data;
      if (data is INetworkEndpoint) {
        int connectedGroups = state.visibleTrafficGroups
            .where(
                (g) => g.connections.any((gc) => gc.endpoint.id == data.id))
            .length;
        if (connectedGroups == 1) vertex.unique = true;
        if (connectedGroups == totalGroups) vertex.common = true;
        vertex.size = connectedGroups / totalGroups;
        vertex.connectedGroups = connectedGroups;
      }
    }
    return vertexes;
  }

  List<GraphEdge> _edges(AnalysisState state) {
    List<GraphEdge> edges = [];

    for (var group in state.visibleTrafficGroups) {
      for (var connection in group.connections) {
        if (!state.endpoints
            .any((e) => e.id == connection.endpoint.id)) {
          continue;
        }
        edges.add(GraphEdge(
          src: group,
          dst: connection,
          common: state.testRunCount(connection) == group.testRuns,
        ));
      }
    }
    return edges;
  }

  Widget edgePanelBuilder(
      BuildContext context, Edge edge, Viewfinder viewfinder) {
    GraphEdge edgeData = edge.data as GraphEdge;
    return _infoPanel(
      context,
      viewfinder,
      edge.position,
      child: _infoPanelContent(
        context,
        "${edgeData.src.name} -> ${"${edgeData.dst.endpoint.name}:${edgeData.dst.ports}"}",
        "IN:\n\t\tPackets: ${edgeData.dst.inCount}\n\t\tBytes: ${edgeData.dst.inBytes}\nOUT:\n\t\tPackets: ${edgeData.dst.outCount}\n\t\tBytes: ${edgeData.dst.outBytes}\nProtocols: ${edgeData.dst.protocolsString}\nUsed in all tests: ${edgeData.common}",
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
          BuildContext context, String title, String content) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.titleMedium,
          ),
          Text(
            content,
            style: context.textTheme.bodyMedium,
          ),
        ],
      );

  Widget _endpointVertexPanelBuilder(BuildContext context, GraphVertex v) {
    INetworkEndpoint e = v.data as INetworkEndpoint;
    if(e is NetworkEndpoint) {
      return _infoPanelContent(
        context,
        e.name,
        'IP: ${e.ip}\n${e.hostname != null
            ? "Hostname: ${e.hostname}\n"
            : ""}# Connected Groups: ${v.connectedGroups}',
      );
    }else if(e is EndpointGroup){
      return _infoPanelContent(
        context,
        e.name,
        'IP: ${e.ip}\n'
            '${e.hasHostname
            ? "Domain: ${e.domain}\nEndpoints: \n\t${e.endpoints.map<String>((ep) => ep.hostname ?? ep.ip).toList().sortedCopy((String a,String b) => compareHostnames(a,b)).join("\n\t")}\n"
            : ""}# Connected Groups: ${v.connectedGroups}',
      );
    }
    return Text("Unknown");
  }

  Widget _groupVertexPanelBuilder(BuildContext context, TrafficGroup g) =>
      _infoPanelContent(
        context,
        'Name: ${g.name}',
        '# Connections: ${g.connections.length}${g.info != null ? "\n${g.info}" : ""}',
      );
}
