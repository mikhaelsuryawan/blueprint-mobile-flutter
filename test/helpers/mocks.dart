import 'package:blueprint_mobile_flutter/core/login/bloc/login_bloc.dart';
import 'package:blueprint_mobile_flutter/core/login/model/request/login_request.dart';
import 'package:blueprint_mobile_flutter/core/login/repository/login_repository.dart';
import 'package:mocktail/mocktail.dart';

// Repository mock
class MockLoginRepository extends Mock implements LoginRepository {}

// Fallback for LoginRequest (mocktail requires this for "any()")
class FakeLoginRequest extends Fake implements LoginRequest {}

// (Optional for widget test)
class MockLoginBloc extends Mock implements LoginBloc {}
