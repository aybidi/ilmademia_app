// ignore_for_file: prefer_const_literals_to_create_immutables
// ignore_for_file: prefer_const_constructors
import 'package:firebase_cloud_interfaces/firebase_cloud_interfaces.dart';
import 'package:test/test.dart';

void main() {
  group('ActionResult', () {
    test('models is equatable', () {
      expect(ActionResult(), ActionResult());
    });
    test('create model fromJson is equatable', () {
      expect(
          ActionResult.fromJson(<String, dynamic>{
            'success': false,
            'msg': '',
            'data': null,
          }),
          ActionResult(success: false, msg: ''));
    });
    test('create a map with toJson is equal', () {
      expect(
        ActionResult.fromJson(<String, dynamic>{
          'success': false,
          'msg': '',
          'data': null,
        }).toJson(),
        {
          'success': false,
          'msg': '',
          'data': null,
        },
      );
    });

    test('props is equal', () {
      expect(
        ActionResult(success: false, msg: '').props,
        [
          false,
          '',
          null,
        ],
      );
    });
  });
}
