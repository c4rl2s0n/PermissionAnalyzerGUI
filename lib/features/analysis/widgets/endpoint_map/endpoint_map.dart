import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';
import 'package:permission_analyzer_gui/features/analysis/values.dart';

const double maxClusterRadius = 120;
const double minClusterRadius = 42;

const double _markerIconSize = 15;

List<Color> get opaqueColors => trafficGroupColors.map((c) => c.withOpacity(0.95)).toList();

class EndpointMap extends StatefulWidget {
  const EndpointMap({super.key});

  @override
  State<EndpointMap> createState() => _EndpointMapState();
}

class _EndpointMapState extends State<EndpointMap> {
  final MapController _mapController = MapController();
  int overallTrafficLoad = 0;
  bool showColors = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalysisCubit, AnalysisState>(builder: _buildMap);
  }

  Map<Marker, NetworkConnection> _getMarkers(
    List<INetworkConnection> connections,
  ) {
    Map<Marker, NetworkConnection> markers = {};
    List<NetworkConnection> allConnections =
        TrafficAnalyzer.flattenConnections(connections);

    for (var con in allConnections) {
      Geolocation? location = con.endpoint.geolocation;
      if (location == null || location.lat == null || location.lon == null) {
        continue;
      }
      LatLng point = LatLng(location.lat!, location.lon!);
      Marker marker = Marker(
        point: point,
        child: _buildMarkerVisible(context, [con], 1),
      );
      markers[marker] = con;
    }
    return markers;
  }

  Widget _buildMap(BuildContext context, AnalysisState state) {
    // only show colors if there are not too many groups
    showColors = state.visibleGroups.length <= trafficGroupColors.length;

    // get markers from connections
    List<INetworkConnection> connections =
        TrafficAnalyzer.getConnectionsFromTrafficGroups(
      state.visibleTrafficGroups
    );
    Map<Marker, NetworkConnection> markerMap = _getMarkers(connections);
    List<Marker> markers = markerMap.keys.toList();

    // compute traffic load
    overallTrafficLoad = TrafficAnalyzer.getTrafficLoad(
      connections,
      inPackets: state.trafficLoadInPackets,
    );
    return Optional(
      buildOptional: (child) => Stack(
        children: [
          child,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: _buildLegend(context),
            ),
          )
        ],
      ),
      useOptional: showColors,
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          //initialCenter: bounds.center,
          initialZoom: 9.2,
          onMapReady: () {
            if (markers.isEmpty) return;
            LatLngBounds bounds =
                LatLngBounds.fromPoints(markers.map((m) => m.point).toList());
            _mapController.fitCamera(CameraFit.bounds(
              bounds: bounds,
              padding: const EdgeInsets.all(25),
            ));
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'es.tma.analyzer',
          ),
          _buildMarkerClusterLayer(markers, markerMap),
        ],
      ),
    );
  }

  Widget _buildLegend(BuildContext context) {
    assert(showColors);
    List<Row> rows = [];
    List<AnalysisTrafficGroupCubit> trafficGroups =
        context.analysisCubit.state.visibleGroups;

    for (int i = 0; i < trafficGroups.length; i++) {
      rows.add(
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              context.icons.mapMarker,
              size: _markerIconSize,
              color: trafficGroupColors[i],
            ),
            Margin.horizontal(context.constants.spacing),
            Text(
              trafficGroups[i].fullName,
              style: context.textTheme.labelMedium,
            ),
          ],
        ),
      );
    }
    return Container(
      padding: EdgeInsets.all(context.constants.spacing),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(context.constants.mediumColorOpacity),
        borderRadius: BorderRadius.all(context.constants.roundedCornerRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Legend:",
            style: context.textTheme.headlineSmall,
          ),
          ...rows,
        ],
      ),
    );
  }

  Widget _buildMarkerClusterLayer(
    List<Marker> markers,
    Map<Marker, NetworkConnection> markerMap,
  ) {
    return MarkerClusterLayerWidget(
      options: MarkerClusterLayerOptions(
        maxClusterRadius: 45,
        size: const Size(40, 40),
        computeSize: (markers) => _computeClusterSize(
          context,
          markers.map((m) => markerMap[m]).nonNulls.toList(),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(50),
        markers: markers,
        builder: (context, markers) =>
            _buildCluster(context, markers, markerMap),
      ),
    );
  }

  Size _computeClusterSize(
    BuildContext context,
    List<NetworkConnection> connections,
  ) {
    int trafficLoad = TrafficAnalyzer.getTrafficLoad(
      connections,
      inPackets: context.analysisCubit.state.trafficLoadInPackets,
    );
    double trafficShare = trafficLoad / overallTrafficLoad;
    double size =
        minClusterRadius + (maxClusterRadius - minClusterRadius) * trafficShare;
    return Size(size, size);
  }

  Widget _buildCluster(
    BuildContext context,
    List<Marker> markers,
    Map<Marker, NetworkConnection> markerMap,
  ) {
    List<NetworkConnection> connections =
        markers.map((m) => markerMap[m]).nonNulls.toList();
    return _buildMarkerVisible(context, connections, markers.length);
  }

  Widget _buildMarkerVisible(
    BuildContext context,
    List<NetworkConnection> connections,
    int markerCount,
  ) {
    AnalysisState state = context.analysisCubit.state;
    List<AnalysisTrafficGroupCubit> trafficGroups = state.visibleGroups;
    return Tooltip(
      richMessage: _getTooltip(context, trafficGroups, connections),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2000),
          color: context.colors.highlight
              .withOpacity(context.constants.lightColorOpacity),
          gradient: _computeGradient(
            context,
            trafficGroups,
            TrafficAnalyzer.getTrafficLoad(connections,
                inPackets: state.trafficLoadInPackets),
            connections,
          ),
        ),
        child: Center(
          child: Text(
            markerCount.toString(),
            style: TextStyle(color: context.colors.onHighlight),
          ),
        ),
      ),
    );
  }

  InlineSpan _getTooltip(
    BuildContext context,
    List<AnalysisTrafficGroupCubit> trafficGroups,
    List<NetworkConnection> connections,
  ) {
    Row getConnectionEntry(NetworkConnection connection) {
      List<Icon> icons = [];
      Text text = Text(connection.endpoint.hostname ?? connection.endpoint.ip);

      for (int i = 0; i < trafficGroups.length; i++) {
        var group = trafficGroups[i].group;
        // group has connection
        if (group.networkConnections.any((nc) => nc.ip == connection.ip)) {
          icons.add(Icon(
            context.icons.mapMarker,
            size: _markerIconSize,
            color: trafficGroupColors[i],
          ));
        } else {
          // group does not have connection
          icons.add(Icon(
            context.icons.mapMarker,
            size: _markerIconSize,
            color: Colors.transparent,
          ));
        }
      }
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...icons,
          Margin.horizontal(context.constants.spacing),
          text,
        ],
      );
    }

    return WidgetSpan(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 220),
        child: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: connections.map(getConnectionEntry).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Gradient? _computeGradient(
    BuildContext context,
    List<AnalysisTrafficGroupCubit> trafficGroups,
    int markerTrafficLoad,
    List<NetworkConnection> connections,
  ) {
    if (!showColors) return null;
    bool loadInPackets = context.analysisCubit.state.trafficLoadInPackets;

    List<Color> gradientColors = [];
    List<double> colorStops = [];
    double previousStop = 0;
    Map<AnalysisTrafficGroupCubit, int> loadByGroup = TrafficAnalyzer.getTrafficLoadByGroup(trafficGroups, connections, loadInPackets);
    for (int i = 0; i < trafficGroups.length; i++) {
      int groupTrafficLoad = loadByGroup[trafficGroups[i]] ?? 0;
      double stop = groupTrafficLoad / markerTrafficLoad;
      if (stop == 0) continue;
      // add values twice with little space to get clear edge
      Color c = opaqueColors[i];
      gradientColors.add(c);
      gradientColors.add(c);
      colorStops.add(previousStop + 0.0001);
      colorStops.add(min(1, previousStop + stop));
      previousStop += stop;
    }
    return SweepGradient(colors: gradientColors, stops: colorStops);
    return LinearGradient(colors: gradientColors, stops: colorStops,
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,);
  }
}
