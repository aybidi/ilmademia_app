// ignore_for_file: prefer_const_constructors
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User', () {
    const id = 'mock-id';
    const email = 'mock-email';
    const name = 'mock-name';
    const photo = 'mock-photo';

    test('uses value equality', () {
      expect(
        User(email: email, id: id, name: name, photo: photo),
        User(email: email, id: id, name: name, photo: photo),
      );
    });
  });
}
