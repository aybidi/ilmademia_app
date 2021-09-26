import 'package:app_config_repository/app_config_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

// ignore: subtype_of_sealed_class
class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

// ignore: subtype_of_sealed_class
class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

// ignore: subtype_of_sealed_class
class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  MethodChannelFirebase.channel.setMockMethodCallHandler((call) async {
    if (call.method == 'Firebase#initializeCore') {
      return [
        {
          'name': defaultFirebaseAppName,
          'options': {
            'apiKey': '123',
            'appId': '123',
            'messagingSenderId': '123',
            'projectId': '123',
          },
          'pluginConstants': const <String, String>{},
        }
      ];
    }

    if (call.method == 'Firebase#initializeApp') {
      final arguments = call.arguments as Map<String, dynamic>;
      return <String, dynamic>{
        'name': arguments['appName'],
        'options': arguments['options'],
        'pluginConstants': const <String, String>{},
      };
    }

    return null;
  });

  TestWidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  const buildNumber1 = 1;
  const buildNumber2 = 2;
  const platformAndroid = Platform.android;
  const platformIos = Platform.iOS;

  group('AppConfigRepository', () {
    late FirebaseFirestore firestore;
    late AppConfigRepository appConfigRepository;

    setUp(() {
      firestore = MockFirestore();
      appConfigRepository = AppConfigRepository(
        firestore: firestore,
        buildNumber: buildNumber1,
        platform: platformAndroid,
      );
    });

    test('throws AssertionError when build number is less than 1', () {
      expect(
        () => AppConfigRepository(buildNumber: 0, platform: platformAndroid),
        throwsAssertionError,
      );
    });

    test('does not require an injected Firestore instance', () {
      expect(() {
        AppConfigRepository(
          buildNumber: buildNumber1,
          platform: platformAndroid,
        );
      }, isNot(throwsException));
    });

    group('isDownForMaintenance', () {
      test('returns nothing when stream is empty', () async {
        final document = MockDocumentReference();
        when(() => firestore.doc('global/app_config')).thenReturn(document);
        when(document.snapshots).thenAnswer((_) =>
            const Stream<DocumentSnapshot<Map<String, dynamic>>>.empty());
        await expectLater(
          appConfigRepository.isDownForMaintenance(),
          emitsInOrder(<bool>[]),
        );
      });

      test('returns false when stream throws error', () async {
        final document = MockDocumentReference();
        when(() => firestore.doc('global/app_config')).thenReturn(document);
        when(document.snapshots).thenAnswer((_) =>
            Stream<DocumentSnapshot<Map<String, dynamic>>>.error('oops'));
        await expectLater(
          appConfigRepository.isDownForMaintenance(),
          emitsInOrder(<bool>[false]),
        );
      });

      test('returns false when AppConfig is incomplete', () async {
        final document = MockDocumentReference();
        when(() => firestore.doc('global/app_config')).thenReturn(document);
        final snapshot = MockDocumentSnapshot();
        when(snapshot.data).thenReturn(
          <String, dynamic>{'down_for_maintenance': true},
        );
        when(document.snapshots).thenAnswer((_) => Stream.value(snapshot));
        await expectLater(
          appConfigRepository.isForceUpgradeRequired(),
          emitsInOrder(
            const <ForceUpgrade>[ForceUpgrade(isUpgradeRequired: false)],
          ),
        );
      });

      test('returns false when down_for_maintenance is false', () async {
        final document = MockDocumentReference();
        when(() => firestore.doc('global/app_config')).thenReturn(document);
        final snapshot = MockDocumentSnapshot();
        when(snapshot.data).thenReturn(<String, dynamic>{
          'down_for_maintenance': false,
          'min_android_build_number': 1,
          'min_ios_build_number': 1,
          'android_upgrade_url': 'mock-android-upgrade-url',
          'ios_upgrade_url': 'mock-ios-upgrade-url',
        });
        when(document.snapshots).thenAnswer((_) => Stream.value(snapshot));
        await expectLater(
          appConfigRepository.isDownForMaintenance(),
          emitsInOrder(<bool>[false]),
        );
      });

      test('returns true when down_for_maintenance is true', () async {
        final document = MockDocumentReference();
        when(() => firestore.doc('global/app_config')).thenReturn(document);
        final snapshot = MockDocumentSnapshot();
        when(snapshot.data).thenReturn(<String, dynamic>{
          'down_for_maintenance': true,
          'min_android_build_number': 1,
          'min_ios_build_number': 1,
          'android_upgrade_url': 'mock-android-upgrade-url',
          'ios_upgrade_url': 'mock-ios-upgrade-url',
        });
        when(document.snapshots).thenAnswer((_) => Stream.value(snapshot));
        await expectLater(
          appConfigRepository.isDownForMaintenance(),
          emitsInOrder(<bool>[true]),
        );
      });
    });

    group('isForceUpgradeRequired', () {
      test('returns nothing when stream is empty', () async {
        final document = MockDocumentReference();
        when(() => firestore.doc('global/app_config')).thenReturn(document);
        when(document.snapshots).thenAnswer((_) =>
            const Stream<DocumentSnapshot<Map<String, dynamic>>>.empty());
        await expectLater(
          appConfigRepository.isForceUpgradeRequired(),
          emitsInOrder(<bool>[]),
        );
      });

      test('returns false when stream throws error', () async {
        final document = MockDocumentReference();
        when(() => firestore.doc('global/app_config')).thenReturn(document);
        when(document.snapshots).thenAnswer((_) =>
            Stream<DocumentSnapshot<Map<String, dynamic>>>.error('oops'));
        await expectLater(
          appConfigRepository.isForceUpgradeRequired(),
          emitsInOrder(
            const <ForceUpgrade>[ForceUpgrade(isUpgradeRequired: false)],
          ),
        );
      });

      test('returns false when AppConfig is incomplete', () async {
        final document = MockDocumentReference();
        when(() => firestore.doc('global/app_config')).thenReturn(document);
        final snapshot = MockDocumentSnapshot();
        when(snapshot.data).thenReturn(
          <String, dynamic>{'down_for_maintenance': true},
        );
        when(document.snapshots).thenAnswer((_) => Stream.value(snapshot));
        await expectLater(
          appConfigRepository.isDownForMaintenance(),
          emitsInOrder(<bool>[false]),
        );
      });

      test('returns false when build number is greater than min', () async {
        final document = MockDocumentReference();
        when(() => firestore.doc('global/app_config')).thenReturn(document);
        final snapshot = MockDocumentSnapshot();
        when(snapshot.data).thenReturn(<String, dynamic>{
          'down_for_maintenance': false,
          'min_android_build_number': 1,
          'min_ios_build_number': 1,
          'android_upgrade_url': 'mock-android-upgrade-url',
          'ios_upgrade_url': 'mock-ios-upgrade-url',
        });
        when(document.snapshots).thenAnswer((_) => Stream.value(snapshot));
        await expectLater(
          AppConfigRepository(
            firestore: firestore,
            buildNumber: buildNumber2,
            platform: platformAndroid,
          ).isForceUpgradeRequired(),
          emitsInOrder(
            const <ForceUpgrade>[
              ForceUpgrade(
                isUpgradeRequired: false,
                upgradeUrl: 'mock-android-upgrade-url',
              )
            ],
          ),
        );
      });

      test('returns false when build number is equal to min', () async {
        final document = MockDocumentReference();
        when(() => firestore.doc('global/app_config')).thenReturn(document);
        final snapshot = MockDocumentSnapshot();
        when(snapshot.data).thenReturn(<String, dynamic>{
          'down_for_maintenance': false,
          'min_android_build_number': 1,
          'min_ios_build_number': 1,
          'android_upgrade_url': 'mock-android-upgrade-url',
          'ios_upgrade_url': 'mock-ios-upgrade-url',
        });
        when(document.snapshots).thenAnswer((_) => Stream.value(snapshot));
        await expectLater(
          appConfigRepository.isForceUpgradeRequired(),
          emitsInOrder(
            const <ForceUpgrade>[
              ForceUpgrade(
                isUpgradeRequired: false,
                upgradeUrl: 'mock-android-upgrade-url',
              )
            ],
          ),
        );
      });

      test('returns true when build number is less than min (android)',
          () async {
        final document = MockDocumentReference();
        when(() => firestore.doc('global/app_config')).thenReturn(document);
        final snapshot = MockDocumentSnapshot();
        when(snapshot.data).thenReturn(<String, dynamic>{
          'down_for_maintenance': false,
          'min_android_build_number': 2,
          'min_ios_build_number': 1,
          'android_upgrade_url': 'mock-android-upgrade-url',
          'ios_upgrade_url': 'mock-ios-upgrade-url',
        });
        when(document.snapshots).thenAnswer((_) => Stream.value(snapshot));
        await expectLater(
          appConfigRepository.isForceUpgradeRequired(),
          emitsInOrder(
            const <ForceUpgrade>[
              ForceUpgrade(
                isUpgradeRequired: true,
                upgradeUrl: 'mock-android-upgrade-url',
              )
            ],
          ),
        );
      });

      test('returns true when build number is less than min (iOS)', () async {
        final document = MockDocumentReference();
        when(() => firestore.doc('global/app_config')).thenReturn(document);
        final snapshot = MockDocumentSnapshot();
        when(snapshot.data).thenReturn(<String, dynamic>{
          'down_for_maintenance': false,
          'min_android_build_number': 1,
          'min_ios_build_number': 2,
          'android_upgrade_url': 'mock-android-upgrade-url',
          'ios_upgrade_url': 'mock-ios-upgrade-url',
        });
        when(document.snapshots).thenAnswer((_) => Stream.value(snapshot));
        await expectLater(
          AppConfigRepository(
            firestore: firestore,
            buildNumber: buildNumber1,
            platform: platformIos,
          ).isForceUpgradeRequired(),
          emitsInOrder(
            const <ForceUpgrade>[
              ForceUpgrade(
                isUpgradeRequired: true,
                upgradeUrl: 'mock-ios-upgrade-url',
              )
            ],
          ),
        );
      });
    });
  });
}
