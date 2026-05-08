import 'package:bloc/bloc.dart';
import 'package:blueprint_mobile_flutter/core/login/repository/login_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/services/storage/local_storage_service.dart';
import '../model/request/login_request.dart';
import '../model/response/login_response.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;

  LoginBloc({required this.repository}) : super(LoginInitState()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginIdleEvent) {
        emit(LoginIdleState());
      } else if (event is LoginFetched) {
        emit(LoginLoading());

        String lang = await LocalStorageService.readData("language");

        LoginResponse response = await repository.login(event.request);

        bool isError = false;
        if (response.response?.code != null) {
          if (response.response?.code?.toLowerCase() == "00") {
            emit(LoginLoaded(response: response.response?.data));
          } else {
            isError = true;
          }
        } else {
          isError = true;
        }

        if (isError) {
          if (lang == "en")
            emit(LoginError(
                textError: response.response?.messageEn?.toString() ??
                    "Server is not responding"));
          else
            emit(LoginError(
                textError: response.response?.messageId?.toString() ??
                    "Server is not responding"));
        }
      }
    });
  }
}
