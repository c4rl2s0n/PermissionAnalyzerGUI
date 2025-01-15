import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_graph_view/flutter_graph_view.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';
import 'package:permission_analyzer_gui/features/analysis/models/models.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/endpoint_graph/models/models.dart';

class GraphComponents {

  static Widget vertexPanelBuilder(
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
      child: buildVertexPanel(context, hoverVertex.data),
    );
  }

  static Widget buildVertexPanel(BuildContext context, GraphVertex vertex) {
    if (vertex.data is INetworkEndpoint) {
      return endpointVertexPanelBuilder(context, vertex);
    } else if (vertex.data is TrafficGroup) {
      return groupVertexPanelBuilder(context, vertex.data);
    }
    return const Text("???");
  }

  static Widget endpointVertexPanelBuilder(
      BuildContext context, GraphVertex v) {
    INetworkEndpoint e = v.data as INetworkEndpoint;
    AnalysisState state = context.analysisCubit.state;
    if (e is NetworkEndpoint) {
      List<List<String>> entries = [
        ["IP", e.ip],
        if (e.hasServerName) ["Server Names", ...e.serverNames],
        if (e.hasHostname) ["Hostname", e.hostname!],
        ["# Connected Groups", v.connectedGroups.toString()],
        ["Tags", ...v.tags],
      ];
      return _infoPanelContent(
        context,
        state.config.groupConnections
            ? e.displayName
            : e.name,
        entries, //'IP: ${e.ip}\n${e.hostname != null ? "Hostname: ${e.hostname}\n" : ""}# Connected Groups: ${v.connectedGroups}',
      );
    } else if (e is EndpointGroup) {
      List<List<String>> entries = [
        ["IP", e.ip],
        if (e.hasHostname) ["Domain", e.domainString!],
        [
          "Endpoints",
          ...e.endpoints
              .map((ep) => ep.hostname ?? ep.ip)
              .toList()
              .sortedCopy((String a, String b) => compareHostnames(a, b))
        ],
        if (e.hasServerName && e is!  SniEndpoint) ["Server Names", ...e.serverNames],
        ["# Connected Groups", v.connectedGroups.toString()],
        ["Tags", ...v.tags],
      ];
      return _infoPanelContent(
        context,
        e.displayName,
        entries,
      );
    }
    return const Text("Unknown");
  }

  static Widget groupVertexPanelBuilder(BuildContext context, TrafficGroup g) {
    List<List<String>> entries = [
      ["# Connections", g.connections.length.toString()],
      ["# Connected Endpoints", g.endpoints.length.toString()],
      if (g.info != null && g.info!.isNotEmpty) ["Info", g.info!],
      if (g.permissions != null && g.permissions!.isNotEmpty) [
        "Permissions",
        ...g.permissions!
      ],
    ];
    if(g.data is TestConstellation){
      TestConstellation tc = g.data as TestConstellation;
      if(tc.hasBlockedEndpoints){
        entries.add(["Blocked Endpoints", ...tc.blockedEndpoints!.map((e) => e.name)]);
      }
    }
    return _infoPanelContent(
      context,
      'Name: ${g.name} (${g.graphTags.join(", ")})',
      entries,
    );
  }

  static Widget edgePanelBuilder(
      BuildContext context, Edge edge, Viewfinder viewfinder) {
    AnalysisState state = context.analysisCubit.state;
    GraphEdge edgeData = edge.data as GraphEdge;
    String trafficLoadIn = "";
    String trafficLoadOut = "";
    String trafficLoadTotal = "";
    if (state.config.trafficLoadInPackets) {
      trafficLoadIn = "${edgeData.dst.inCount}";
      trafficLoadOut = "${edgeData.dst.outCount}";
      trafficLoadTotal = "${edgeData.dst.countTotal}";
    } else {
      trafficLoadIn = edgeData.dst.inBytes.readableFileSize(base1024: false);
      trafficLoadOut = edgeData.dst.outBytes.readableFileSize(base1024: false);
      trafficLoadTotal =
          edgeData.dst.bytesTotal.readableFileSize(base1024: false);
    }
    List<List<String>> entries = [
      [
        "Traffic Load ${state.config.trafficLoadInPackets ? "(Count)" : "(Volume)"}"
      ],
      ["IN", trafficLoadIn],
      ["Out", trafficLoadOut],
      ["Total", trafficLoadTotal],
      [
        "Protocols",
        ...edgeData.dst.protocols.map((p) {
          int indexIp = p.indexOf("ip:");
          if (indexIp >= 0) indexIp += 3;
          return p.substring(max(0, indexIp));
        })
      ],
      if (edgeData.common) ["Connection in all tests", "Yes"],
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

  static Widget _infoPanel(
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

  static Widget _infoPanelContent(
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
                    Text(
                      "${entry[0]}:",
                      style: context.textTheme.labelMedium,
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

}
