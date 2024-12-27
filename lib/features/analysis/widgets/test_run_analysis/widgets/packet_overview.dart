import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

class PacketOverview extends StatelessWidget {
  const PacketOverview(this.packet, {super.key});

  final NetworkPacket packet;

  @override
  Widget build(BuildContext context) {
    return InfoContainer(
        title: "Packet Inspection",
        child: Text("${packet.src} -> ${packet.dst}"),
    );
  }
}
