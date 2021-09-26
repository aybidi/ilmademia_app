// ignore_for_file: prefer_const_constructors,
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:firebase_cloud_interfaces/firebase_cloud_interfaces.dart';
import 'package:test/test.dart';

void main() {
  group('User', () {
    test('check equatable between objects', () {
      expect(
        User(
          id: 'id',
          isAnonymous: true,
        ),
        User(
          id: 'id',
          isAnonymous: true,
        ),
      );
    });
    test('check equatable for copyWith objects', () {
      expect(
        User(
          id: 'id',
          isAnonymous: true,
        ).copyWith(),
        User(
          id: 'id',
          isAnonymous: true,
        ),
      );
    });
    test('when User.anonymous equatable', () {
      expect(
        User.anonymous(),
        User(id: '', isAnonymous: true),
      );
    });
    test('when User.nullObject return anonymous object', () {
      expect(
        // ignore: deprecated_member_use_from_same_package
        User.nullObject,
        User(id: '', isAnonymous: true),
      );
    });

    test('create User from Map and check its equal to the User specified', () {
      expect(
        User.fromJson(<String, dynamic>{
          'id': 'id',
          'is_anonymous': true,
        }),
        User(
          id: 'id',
          isAnonymous: true,
        ),
      );
    });

    test('create User Map and check its equal to the Map', () {
      expect(
        User.fromJson(<String, dynamic>{
          'id': 'id',
          'is_anonymous': true,
        }).toJson(),
        User(
          id: 'id',
          isAnonymous: true,
        ).toJson(),
      );
    });

    test('create User Map and check its equal to the Map', () {
      expect(
        User.fromJson(<String, dynamic>{
          'id': 'id',
          'is_anonymous': true,
        }).toJson(),
        User(
          id: 'id',
          isAnonymous: true,
        ).toJson(),
      );
    });

    test('default value for ', () {
      expect(
        User(
          id: 'id',
          isAnonymous: true,
        ).createdAt,
        isNull,
      );
    });

    test('check props are equal', () {
      expect(
        User(
          id: 'id',
          isAnonymous: true,
        ).props,
        [
          'id',
          true,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
        ],
      );
    });
  });
}
