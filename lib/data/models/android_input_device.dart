import 'package:equatable/equatable.dart';
import 'package:isar/isar.dart';

part 'android_input_device.g.dart';

@Embedded(ignore: {"props"})
class AndroidInputDevice extends Equatable {
  const AndroidInputDevice({
    this.name = "",
    this.info = "",
    this.path = "",
  });
  final String name;
  final String info;
  final String path;

  @override
  List<Object?> get props => [name, info, path];

  AndroidInputDevice copyWith({
    String? name,
    String? info,
    String? path,
  }) {
    return AndroidInputDevice(
      name: name ?? this.name,
      info: info ?? this.info,
      path: path ?? this.path,
    );
  }
}
