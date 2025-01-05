import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

class ConnectionTrafficOverview extends StatelessWidget {
  const ConnectionTrafficOverview(this.connection, {super.key});

  final INetworkConnection connection;

  @override
  Widget build(BuildContext context) {
    return InfoContainer(
      title: "Connection Packets (${connection.packets.length})",
      child: DataGrid<NetworkPacket>(
        columns: _columns(context),
        data: connection.packets,
      ),
    );
  }

  List<DataGridColumn<NetworkPacket, Object?>> _columns(BuildContext context) {
    bool incoming(NetworkPacket p) => p.ipSrc == connection.endpoint.ip;
    return [
      DataGridColumn<NetworkPacket, bool>(
        name: "Direction",
        width: 75,
        getValue: (p) => incoming(p),
        getCell: (p) => incoming(p)
            ? Icon(
                context.icons.connectionIn,
                color: context.colors.positive,
              )
            : Icon(
                context.icons.connectionOut,
                color: context.colors.negative,
              ),
      ),
      DataGridColumn<NetworkPacket, DateTime?>(
        name: "Time",
        width: 75,
        getValue: (p) => p.timestamp,
      ),
      DataGridColumn<NetworkPacket, int>(
        name: "Bytes",
        width: 75,
        getValue: (p) => p.size,
      ),
    ];
  }
}
