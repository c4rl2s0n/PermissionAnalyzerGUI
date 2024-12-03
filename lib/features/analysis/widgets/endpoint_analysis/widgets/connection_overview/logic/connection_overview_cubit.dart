import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_analyzer_gui/data/data.dart';

part 'connection_overview_cubit.freezed.dart';

class ConnectionOverviewCubit extends Cubit<ConnectionOverviewState> {
  ConnectionOverviewCubit(this.connections, this.packets)
      : super(ConnectionOverviewState(
          connections: connections,
          packets: packets,
        ));

  List<TrafficConnection> connections;
  List<NetworkPacket> packets;

  void updateSelection(TrafficConnection? entry) {
    emit(state.copyWith(
      selectedIndex: entry == null
          ? null
          : state.connections.indexWhere((c) => c.flow == entry.flow),
    ));
  }
}

@freezed
class ConnectionOverviewState with _$ConnectionOverviewState {
  const ConnectionOverviewState._();

  const factory ConnectionOverviewState({
    required List<TrafficConnection> connections,
    required List<NetworkPacket> packets,
    int? selectedIndex,
  }) = _ConnectionOverviewState;

  TrafficConnection? get selectedConnection => selectedIndex != null &&
          selectedIndex! >= 0 &&
          selectedIndex! < connections.length
      ? connections[selectedIndex!]
      : null;
  List<NetworkPacket> get selectedConnectionPackets =>
      selectedConnection?.packets ?? [];
  // selectedConnection == null || selectedConnection!.endpoint == null
  //     ? []
  //     : packets
  //         .where((p) =>
  // selectedConnection.packets
  //             p.ipSrc == selectedConnection!.endpoint!.ip ||
  //             p.ipDst == selectedConnection!.endpoint!.ip)
  //         .toList();
}
