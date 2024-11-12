import 'package:isar/isar.dart';

part 'permission_setting.g.dart';

enum PermissionState {
  granted,
  revoked,
  test,
}

extension PermissionStateExtension on PermissionState {
  PermissionState get next =>
      PermissionState.values[(PermissionState.values.indexOf(this) + 1) %
          PermissionState.values.length];
}

@embedded
class PermissionSetting {
  PermissionSetting({
    this.permission = "",
    this.state = PermissionState.revoked,
  });
  String permission;

  @Enumerated(EnumType.name)
  PermissionState state;
}
