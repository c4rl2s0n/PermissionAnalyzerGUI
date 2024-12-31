import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';

class EndpointMap extends StatefulWidget {
  const EndpointMap({super.key});

  @override
  State<EndpointMap> createState() => _EndpointMapState();
}

class _EndpointMapState extends State<EndpointMap> {
  final MapController _mapController = MapController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalysisCubit, AnalysisState>(builder: (context, state) => _buildMap(context, state.connections.map((c) => c.endpoint).toList()));
  }

  Widget _buildMap(BuildContext context, List<INetworkEndpoint> endpoints){
    List<Marker> markers = [];
    for(var ep in endpoints){
      for(var location in ep.geolocations){
        if(location.lat == null || location.lon == null) continue;
        LatLng point = LatLng(location.lat!, location.lon!);
        markers.add(Marker(point: point, child: Tooltip(message: ep.name, child: Icon(context.icons.mapMarker, color: context.colors.highlight, size: 42,))));
      }
    }
    LatLngBounds bounds = LatLngBounds.fromPoints(markers.map((m) => m.point).toList());
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: bounds.center,
        initialZoom: 9.2,
        onMapReady: () => _mapController.fitCamera(CameraFit.bounds(bounds: bounds)),
      ),
      children: [
        TileLayer( // Bring your own tiles
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // For demonstration only
          userAgentPackageName: 'es.tma.analyzer', // Add your app identifier
          // And many more recommended properties!
        ),
        MarkerLayer(markers: markers),
        RichAttributionWidget( // Include a stylish prebuilt attribution widget that meets all requirments
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
}
