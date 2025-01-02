import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';
import 'package:permission_analyzer_gui/features/analysis/models/connection_group.dart';

const double maxClusterRadius = 100;
const double minClusterRadius = 25;

class EndpointMap extends StatefulWidget {
  const EndpointMap({super.key});

  @override
  State<EndpointMap> createState() => _EndpointMapState();
}

class _EndpointMapState extends State<EndpointMap> {
  final MapController _mapController = MapController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalysisCubit, AnalysisState>(
        builder: (context, state) => _buildMap(
            context, state.connections));
  }

  Map<Marker, NetworkConnection> _getMarkers(List<INetworkConnection> connections){
    Map<Marker, NetworkConnection> markers = {};
    List<NetworkConnection> allConnections = [];
    for(var con in connections){
      if(con is ConnectionGroup) {
        allConnections.addAll(con.connections);
      } else if (con is NetworkConnection){
        allConnections.add(con);
      }
    }
    for (var con in allConnections) {
        Geolocation? location = con.endpoint.geolocation;
        if (location == null || location.lat == null || location.lon == null) continue;
        LatLng point = LatLng(location.lat!, location.lon!);
        Marker marker = Marker(
            point: point,
            child: Tooltip(
                message: con.endpoint.hostname ?? con.endpoint.ip,
                child: Icon(
                  context.icons.mapMarker,
                  color: context.colors.highlight,
                  size: 42,
                )));
        markers[marker] = con;
    }
    return markers;
  }

  Widget _buildMap(BuildContext context, List<INetworkConnection> connections) {
    Map<Marker, NetworkConnection> markerMap = _getMarkers(connections);
    List<Marker> markers = markerMap.keys.toList();
    int overallTrafficLoad = connections.fold(0, (all, con) => all + con.bytesTotal);
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        //initialCenter: bounds.center,
        initialZoom: 9.2,
        onMapReady: () {
          if(markers.isEmpty) return;
          LatLngBounds bounds = LatLngBounds.fromPoints(markers.map((m) => m.point).toList());
          _mapController.fitCamera(CameraFit.bounds(
            bounds: bounds,
            padding: const EdgeInsets.all(25),
          ));
        },
      ),
      children: [
        TileLayer(
          // Bring your own tiles
          urlTemplate:
              'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
          userAgentPackageName: 'es.tma.analyzer', // Add your app identifier
          // And many more recommended properties!
        ),
        MarkerClusterLayerWidget(
            options: MarkerClusterLayerOptions(
                maxClusterRadius: 45,
                size: const Size(40, 40),
                computeSize: (markers) => _computeClusterSize(markers, markerMap, overallTrafficLoad),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(50),
                markers: markers,
                builder: (context, markers) => _buildCluster(context, markers, markerMap),
            )),
        //MarkerLayer(markers: markers),
        RichAttributionWidget(
          // Include a stylish prebuilt attribution widget that meets all requirments
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              //onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')), // (external)
            ),
            // Also add images...
          ],
        ),
      ],
    );
  }
  Size _computeClusterSize(List<Marker> markers, Map<Marker, NetworkConnection> markerMap, int overallTrafficLoad){
    int trafficLoad = markers.fold(0, (all, marker) => all += markerMap[marker]?.bytesTotal ?? 0);
    double trafficShare = trafficLoad / overallTrafficLoad;
    double size = minClusterRadius + (maxClusterRadius-minClusterRadius)*trafficShare;
    return Size(size, size);
  }
  Widget _buildCluster(BuildContext context, List<Marker> markers, Map<Marker, NetworkConnection> markerMap){
    return Tooltip(
      message: markers.map((m) => markerMap[m]?.endpoint.hostname ?? markerMap[m]?.endpoint.ip).nonNulls.toList().sorted.join("\n"),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2000),
          color: context.colors.highlight.withOpacity(context.constants.subtleColorOpacity),
        ),
        child: Center(
          child: Text(
            markers.length.toString(),
            style: TextStyle(color: context.colors.onHighlight),
          ),
        ),
      ),
    );
  }
}
