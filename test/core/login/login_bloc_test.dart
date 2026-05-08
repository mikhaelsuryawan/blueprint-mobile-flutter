import 'package:bloc_test/bloc_test.dart';
import 'package:blueprint_mobile_flutter/core/login/bloc/login_bloc.dart';
import 'package:blueprint_mobile_flutter/core/login/model/request/login_request.dart';
import 'package:blueprint_mobile_flutter/core/login/model/response/login_response.dart';
import 'package:blueprint_mobile_flutter/core/login/repository/login_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/mocks.dart';

void main() {
  late LoginRepository repository;

  setUpAll(() {
    // Initialize Flutter bindings for SharedPreferences
    TestWidgetsFlutterBinding.ensureInitialized();
    registerFallbackValue(FakeLoginRequest());
  });

  setUp(() {
    repository = MockLoginRepository();
    // Clear SharedPreferences before each test
    SharedPreferences.setMockInitialValues({});
  });

  group('LoginBloc', () {
    test('initial state is LoginInitState', () {
      final bloc = LoginBloc(
        repository: repository,
      );
      expect(bloc.state, isA<LoginInitState>());
      bloc.close();
    });

    test('emits LoginIdleState when LoginIdleEvent is added', () {
      final bloc = LoginBloc(
        repository: repository,
      );
      expect(bloc.state, isA<LoginInitState>());

      bloc.add(LoginIdleEvent());
      expect(bloc.state, isA<LoginIdleState>());

      bloc.close();
    });

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginLoaded] when code == "00"',
      setUp: () async {
        // Set up mock SharedPreferences with language value
        SharedPreferences.setMockInitialValues({
          'language': 'en',
        });
      },
      build: () {
        // Build a success response matching your parsing: response.code == "00"
        final success = LoginResponse(
          response: LoginResponseData(
            code: "00",
            data: LoginData(),
            messageEn: "OK",
            messageId: "OK",
          ),
        );

        when(() => repository.login(any())).thenAnswer((_) async => success);

        return LoginBloc(
          repository: repository,
        );
      },
      act: (bloc) => bloc.add(LoginFetched(
          request: LoginRequest()
            ..username = "demo.account@mail.com"
            ..password = "01012000")),
      expect: () => [
        isA<LoginLoading>(),
        isA<LoginLoaded>(),
      ],
      verify: (_) {
        verify(() => repository.login(any())).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginError] with EN message when code != "00" and lang == "en"',
      setUp: () async {
        // Set up mock SharedPreferences with English language
        SharedPreferences.setMockInitialValues({
          'language': 'en',
        });
      },
      build: () {
        final error = LoginResponse(
          response: LoginResponseData(
            code: "99",
            data: null,
            messageEn: "Invalid username or password",
            messageId: "Username atau password salah",
          ),
        );

        when(() => repository.login(any())).thenAnswer((_) async => error);

        return LoginBloc(
          repository: repository,
        );
      },
      act: (bloc) => bloc.add(LoginFetched(
          request: LoginRequest()
            ..username = "wrong"
            ..password = "wrong")),
      expect: () => [
        isA<LoginLoading>(),
        predicate<LoginState>((state) =>
            state is LoginError &&
            state.textError == 'Invalid username or password'),
      ],
      verify: (_) {
        verify(() => repository.login(any())).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginError] with ID message when code != "00" and lang != "en"',
      setUp: () async {
        // Set up mock SharedPreferences with Indonesian language
        SharedPreferences.setMockInitialValues({
          'language': 'id',
        });
      },
      build: () {
        final error = LoginResponse(
          response: LoginResponseData(
            code: "99",
            data: null,
            messageEn: "Invalid username or password",
            messageId: "Username atau password salah",
          ),
        );

        when(() => repository.login(any())).thenAnswer((_) async => error);

        return LoginBloc(
          repository: repository,
        );
      },
      act: (bloc) => bloc.add(LoginFetched(
          request: LoginRequest()
            ..username = "wrong"
            ..password = "wrong")),
      expect: () => [
        isA<LoginLoading>(),
        predicate<LoginState>((state) =>
            state is LoginError &&
            state.textError == 'Username atau password salah'),
      ],
      verify: (_) {
        verify(() => repository.login(any())).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginError] with EN message when code != "00" and language is null',
      setUp: () async {
        // Set up mock SharedPreferences without language (defaults to null)
        SharedPreferences.setMockInitialValues({});
      },
      build: () {
        final error = LoginResponse(
          response: LoginResponseData(
            code: "99",
            data: null,
            messageEn: "Invalid username or password",
            messageId: "Username atau password salah",
          ),
        );

        when(() => repository.login(any())).thenAnswer((_) async => error);

        return LoginBloc(
          repository: repository,
        );
      },
      act: (bloc) => bloc.add(LoginFetched(
          request: LoginRequest()
            ..username = "wrong"
            ..password = "wrong")),
      expect: () => [
        isA<LoginLoading>(),
        predicate<LoginState>((state) =>
            state is LoginError &&
            state.textError == 'Username atau password salah'),
      ],
      verify: (_) {
        verify(() => repository.login(any())).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoading, LoginError] when response code is null',
      setUp: () async {
        SharedPreferences.setMockInitialValues({
          'language': 'en',
        });
      },
      build: () {
        final error = LoginResponse(
          response: LoginResponseData(
            code: null,
            data: null,
            messageEn: "Unexpected error",
            messageId: "Kesalahan tidak terduga",
          ),
        );

        when(() => repository.login(any())).thenAnswer((_) async => error);

        return LoginBloc(
          repository: repository,
        );
      },
      act: (bloc) => bloc.add(LoginFetched(
          request: LoginRequest()
            ..username = "test"
            ..password = "test")),
      expect: () => [
        isA<LoginLoading>(),
        predicate<LoginState>((state) =>
            state is LoginError && state.textError == 'Unexpected error'),
      ],
      verify: (_) {
        verify(() => repository.login(any())).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'throws error when response.response is null',
      setUp: () async {
        SharedPreferences.setMockInitialValues({
          'language': 'en',
        });
      },
      build: () {
        final error = LoginResponse(
          response: null,
        );

        when(() => repository.login(any())).thenAnswer((_) async => error);

        return LoginBloc(
          repository: repository,
        );
      },
      act: (bloc) => bloc.add(LoginFetched(
          request: LoginRequest()
            ..username = "test"
            ..password = "test")),
      expect: () => [
        isA<LoginLoading>(),
      ],
      errors: () => [
        isA<TypeError>(),
      ],
      verify: (_) {
        verify(() => repository.login(any())).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'handles repository exception gracefully',
      setUp: () async {
        SharedPreferences.setMockInitialValues({
          'language': 'en',
        });
      },
      build: () {
        when(() => repository.login(any()))
            .thenThrow(Exception('Network error'));

        return LoginBloc(
          repository: repository,
        );
      },
      act: (bloc) => bloc.add(LoginFetched(
          request: LoginRequest()
            ..username = "test"
            ..password = "test")),
      expect: () => [
        isA<LoginLoading>(),
      ],
      errors: () => [
        isA<Exception>(),
      ],
      verify: (_) {
        verify(() => repository.login(any())).called(1);
      },
    );
  });
}
