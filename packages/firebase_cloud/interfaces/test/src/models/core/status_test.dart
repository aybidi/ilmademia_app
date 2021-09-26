// ignore_for_file: prefer_const_constructors
import 'package:firebase_cloud_interfaces/firebase_cloud_interfaces.dart';
import 'package:test/test.dart';

void main() {
  group('Status', () {
    test('check equatable between objects', () {
      expect(
        Status(),
        Status(),
      );
    });

    test(
        'create active Status fromJson '
        'and check its equal to the Status specified', () {
      expect(
        Status.fromJson('active'),
        Status(
          active: true,
        ),
      );
    });
    test(
        'create nonactive Status fromJson '
        'and check its equal to the Status specified', () {
      expect(
        Status.fromJson('inactive'),
        Status(
          active: false,
        ),
      );
    });
    test('create json object from toJson', () {
      expect(
        Status(
          active: false,
        ).toJson(),
        {'status': 'inactive'},
      );
    });
  });
}
