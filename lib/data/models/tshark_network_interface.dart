import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'tshark_network_interface.g.dart';

@Embedded(ignore: {"props"})
class TsharkNetworkInterface extends Equatable {
  const TsharkNetworkInterface({this.id = 1, this.name = "", this.info});
  final int id;
  final String name;
  final String? info;

  @override
  List<Object?> get props => [id, name, info];

  TsharkNetworkInterface copyWith({
    int? id,
    String? name,
    String? info,
  }) {
    return TsharkNetworkInterface(
      id: id ?? this.id,
      name: name ?? this.name,
      info: info ?? this.info,
    );
  }
}
