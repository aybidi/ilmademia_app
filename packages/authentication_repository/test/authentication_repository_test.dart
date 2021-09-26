// ignore_for_file: must_be_immutable
import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_cloud_interfaces/firebase_cloud_interfaces.dart'
    as user_model;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class MockFirebaseAuth extends Mock implements firebase_auth.FirebaseAuth {}

class MockFirebaseUser extends Mock implements firebase_auth.User {}

class MockUserMetadata extends Mock implements firebase_auth.UserMetadata {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

@immutable
class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {
  @override
  bool operator ==(dynamic other) => identical(this, other);

  @override
  int get hashCode => 0;
}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

class MockAuthorizationCredentialAppleID extends Mock
    implements AuthorizationCredentialAppleID {}

class MockUserCredential extends Mock implements firebase_auth.UserCredential {}

class FakeAuthCredential extends Fake implements firebase_auth.AuthCredential {}

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

  const email = 'test@gmail.com';
  const password = 't0ps3cret42';
  const newUser = user_model.User(
    isAnonymous: false,
    email: email,
    firstName: 'John',
    lastName: 'Doe',
    zipCode: 'a1b2c3',
    dobDay: 1,
    dobMonth: 1,
    dobYear: 2000,
  );

  group('AuthenticationRepository', () {
    late firebase_auth.FirebaseAuth firebaseAuth;
    late GoogleSignIn googleSignIn;
    late AuthenticationRepository authenticationRepository;
    late AuthorizationCredentialAppleID authorizationCredentialAppleID;
    late GetAppleCredentials getAppleCredentials;
    late List<List<AppleIDAuthorizationScopes>> getAppleCredentialsCalls;

    setUpAll(() {
      registerFallbackValue<firebase_auth.AuthCredential>(FakeAuthCredential());
    });

    setUp(() {
      firebaseAuth = MockFirebaseAuth();
      googleSignIn = MockGoogleSignIn();
      authorizationCredentialAppleID = MockAuthorizationCredentialAppleID();
      getAppleCredentialsCalls = <List<AppleIDAuthorizationScopes>>[];
      getAppleCredentials = ({
        List<AppleIDAuthorizationScopes> scopes = const [],
        WebAuthenticationOptions? webAuthenticationOptions,
        String? nonce,
        String? state,
      }) async {
        getAppleCredentialsCalls.add(scopes);
        return authorizationCredentialAppleID;
      };
      authenticationRepository = AuthenticationRepository(
        firebaseAuth: firebaseAuth,
        googleSignIn: googleSignIn,
        getAppleCredentials: getAppleCredentials,
      );
    });

    test('creates FirebaseAuth instance internally when not injected', () {
      expect(() => AuthenticationRepository(), isNot(throwsException));
    });

    group('signUp', () {
      setUp(() {
        when(
          () => firebaseAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) => Future.value(MockUserCredential()));
      });

      test('calls createUserWithEmailAndPassword', () async {
        await authenticationRepository.signUp(
            newUser: newUser, password: password);
        verify(
          () => firebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).called(1);
      });

      test('succeeds when createUserWithEmailAndPassword succeeds', () async {
        expect(
          authenticationRepository.signUp(newUser: newUser, password: password),
          completes,
        );
      });

      test('throws SignUpFailure when createUserWithEmailAndPassword throws',
          () async {
        when(
          () => firebaseAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(Exception());
        expect(
          authenticationRepository.signUp(newUser: newUser, password: password),
          throwsA(isA<SignUpFailure>()),
        );
      });
    });

    group('logInWithApple', () {
      const email = 'mock@email.com';
      const authorizationCode = 'authorizationCode';
      setUp(() {
        when(() => authorizationCredentialAppleID.email).thenReturn(email);
        when(() => authorizationCredentialAppleID.authorizationCode)
            .thenReturn(authorizationCode);
        when(() => firebaseAuth.signInWithCredential(any()))
            .thenAnswer((_) => Future.value(MockUserCredential()));
      });

      test('succeeds when login with apple completes', () {
        expect(authenticationRepository.logInWithApple(), completes);
      });
      test('throws LogInWithAppleFailure when exception occur', () {
        when(() => firebaseAuth.signInWithCredential(any()))
            .thenThrow(Exception());
        expect(
          authenticationRepository.logInWithApple(),
          throwsA(isA<LogInWithAppleFailure>()),
        );
      });
    });
    group('loginWithGoogle', () {
      const accessToken = 'access-token';
      const idToken = 'id-token';

      setUp(() {
        final googleSignInAuthentication = MockGoogleSignInAuthentication();
        final googleSignInAccount = MockGoogleSignInAccount();
        when(() => googleSignInAuthentication.accessToken)
            .thenReturn(accessToken);
        when(() => googleSignInAuthentication.idToken).thenReturn(idToken);
        when(() => googleSignInAccount.authentication)
            .thenAnswer((_) async => googleSignInAuthentication);
        when(() => googleSignIn.signIn())
            .thenAnswer((_) async => googleSignInAccount);
        when(() => firebaseAuth.signInWithCredential(any()))
            .thenAnswer((_) => Future.value(MockUserCredential()));
      });

      test('calls signIn authentication, and signInWithCredential', () async {
        await authenticationRepository.logInWithGoogle();
        verify(() => googleSignIn.signIn()).called(1);
        verify(() => firebaseAuth.signInWithCredential(any())).called(1);
      });

      test('succeeds when signIn succeeds', () {
        expect(authenticationRepository.logInWithGoogle(), completes);
      });

      test('throws LogInWithGoogleFailure when exception occurs', () async {
        when(() => firebaseAuth.signInWithCredential(any()))
            .thenThrow(Exception());
        expect(
          authenticationRepository.logInWithGoogle(),
          throwsA(isA<LogInWithGoogleFailure>()),
        );
      });
    });

    group('logInWithEmailAndPassword', () {
      setUp(() {
        when(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) => Future.value(MockUserCredential()));
      });

      test('calls signInWithEmailAndPassword', () async {
        await authenticationRepository.logInWithEmailAndPassword(
          email: email,
          password: password,
        );
        verify(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).called(1);
      });

      test('succeeds when signInWithEmailAndPassword succeeds', () async {
        expect(
          authenticationRepository.logInWithEmailAndPassword(
            email: email,
            password: password,
          ),
          completes,
        );
      });

      test(
          'throws LogInWithEmailAndPasswordFailure '
          'when signInWithEmailAndPassword throws', () async {
        when(
          () => firebaseAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(Exception());
        expect(
          authenticationRepository.logInWithEmailAndPassword(
            email: email,
            password: password,
          ),
          throwsA(isA<LogInWithEmailAndPasswordFailure>()),
        );
      });
    });

    group('sendForgetPasswordEmail', () {
      test('calls sendPasswordResetEmail', () async {
        when(() => firebaseAuth.sendPasswordResetEmail(email: email))
            .thenAnswer((_) async {});
        await authenticationRepository.sendForgotPasswordEmail(email: email);
        verify(() => firebaseAuth.sendPasswordResetEmail(email: email))
            .called(1);
      });

      test(
          'throws SendForgetPasswordEmailFailure when '
          'sendPasswordResetEmail throws', () async {
        when(() => firebaseAuth.sendPasswordResetEmail(email: email))
            .thenThrow(Exception());
        expect(
          authenticationRepository.sendForgotPasswordEmail(email: email),
          throwsA(isA<SendForgetPasswordEmailFailure>()),
        );
      });
    });

    group('logOut', () {
      test('calls signOut', () async {
        when(() => firebaseAuth.signOut()).thenAnswer((_) async {});
        await authenticationRepository.logOut();
        verify(() => firebaseAuth.signOut()).called(1);
      });

      test('throws LogOutFailure when signOut throws', () async {
        when(() => firebaseAuth.signOut()).thenThrow(Exception());
        expect(
          authenticationRepository.logOut(),
          throwsA(isA<LogOutFailure>()),
        );
      });
    });

    group('changePassword', () {
      late firebase_auth.User currentUser;
      setUp(() {
        currentUser = MockFirebaseUser();
        when(() => firebaseAuth.currentUser).thenAnswer((_) => currentUser);
        when(() => firebaseAuth.signOut()).thenAnswer((_) async {});
        when(() => currentUser.updatePassword(password))
            .thenAnswer((_) async {});
      });
      test('calls changePassword', () async {
        await authenticationRepository.changePassword(newPassword: password);
        verify(() => currentUser.updatePassword(password)).called(1);
        verify(() => firebaseAuth.signOut()).called(1);
      });

      test('throws ChangePasswordFailure when changePassword fails', () async {
        when(() => firebaseAuth.signOut()).thenThrow(Exception());
        expect(
          authenticationRepository.changePassword(newPassword: password),
          throwsA(isA<ChangePasswordFailure>()),
        );
      });
    });

    group('user', () {
      const userId = 'mock-uid';
      const email = 'mock-email';
      const newUser = User(id: userId, email: email);
      const returningUser = User(id: userId, email: email, isNewUser: false);
      test('emits User.anonymous when firebase user is null', () async {
        when(() => firebaseAuth.authStateChanges()).thenAnswer(
          (_) => Stream.value(null),
        );
        await expectLater(
          authenticationRepository.user,
          emitsInOrder(const <User>[User.anonymous]),
        );
      });

      test('emits new user when firebase user is not null', () async {
        final firebaseUser = MockFirebaseUser();
        final userMetadata = MockUserMetadata();
        final creationTime = DateTime(2020);
        when(() => firebaseUser.uid).thenReturn(userId);
        when(() => firebaseUser.email).thenReturn(email);
        when(() => userMetadata.creationTime).thenReturn(creationTime);
        when(() => userMetadata.lastSignInTime).thenReturn(creationTime);
        when(() => firebaseUser.photoURL).thenReturn(null);
        when(() => firebaseUser.metadata).thenReturn(userMetadata);
        when(() => firebaseAuth.authStateChanges()).thenAnswer(
          (_) => Stream.value(firebaseUser),
        );
        await expectLater(
          authenticationRepository.user,
          emitsInOrder(const <User>[newUser]),
        );
      });

      test('emits new user when firebase user is not null', () async {
        final firebaseUser = MockFirebaseUser();
        final userMetadata = MockUserMetadata();
        final creationTime = DateTime(2020);
        final lastSignInTime = DateTime(2019);
        when(() => firebaseUser.uid).thenReturn(userId);
        when(() => firebaseUser.email).thenReturn(email);
        when(() => userMetadata.creationTime).thenReturn(creationTime);
        when(() => userMetadata.lastSignInTime).thenReturn(lastSignInTime);
        when(() => firebaseUser.photoURL).thenReturn(null);
        when(() => firebaseUser.metadata).thenReturn(userMetadata);
        when(() => firebaseAuth.authStateChanges()).thenAnswer(
          (_) => Stream.value(firebaseUser),
        );
        await expectLater(
          authenticationRepository.user,
          emitsInOrder(const <User>[returningUser]),
        );
      });
    });
  });
}
