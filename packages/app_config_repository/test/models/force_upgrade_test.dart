// ignore_for_file: prefer_const_constructors
import 'package:app_config_repository/app_config_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ForceUpgrade', () {
    test('supports value equality', () {
      expect(
        ForceUpgrade(isUpgradeRequired: false),
        ForceUpgrade(isUpgradeRequired: false),
      );
      expect(
        ForceUpgrade(isUpgradeRequired: true),
        isNot(ForceUpgrade(isUpgradeRequired: false)),
      );
    });

    group('ForceUpgradeX', () {
      test('is correct for Platform.android', () {
        expect(Platform.android.isAndroid, isTrue);
        expect(Platform.android.isIos, isFalse);
      });

      test('is correct for Platform.iOS', () {
        expect(Platform.iOS.isAndroid, isFalse);
        expect(Platform.iOS.isIos, isTrue);
      });
    });
  });
}
