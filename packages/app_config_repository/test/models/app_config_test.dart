// ignore_for_file: prefer_const_constructors
import 'package:app_config_repository/src/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppConfig', () {
    const androidUpgradeUrl = 'mock-android-upgrade-url';
    const downForMaintenance = false;
    const iosUpgradeUrl = 'mock-ios-upgrade-url';
    const minAndroidBuildNumber = 1;
    const minIosBuildNumber = 1;

    group('equatable props', () {
      test('are correct', () {
        expect(
          AppConfig(
            androidUpgradeUrl: androidUpgradeUrl,
            downForMaintenance: downForMaintenance,
            iosUpgradeUrl: iosUpgradeUrl,
            minAndroidBuildNumber: minAndroidBuildNumber,
            minIosBuildNumber: minIosBuildNumber,
          ).props,
          [
            androidUpgradeUrl,
            downForMaintenance,
            iosUpgradeUrl,
            minAndroidBuildNumber,
            minIosBuildNumber,
          ],
        );
      });
    });
  });
}
