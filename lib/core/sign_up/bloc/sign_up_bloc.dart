import 'package:bloc/bloc.dart';
import 'package:blueprint_mobile_flutter/core/sign_up/repository/sign_up_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/services/storage/local_storage_service.dart';
import '../model/request/sign_up_request.dart';
import '../model/response/sign_up_response.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpRepository repository;

  SignUpBloc({required this.repository}) : super(SignUpInitState()) {
    on<SignUpEvent>((event, emit) async {
      if (event is SignUpIdleEvent) {
        emit(SignUpIdleState());
      } else if (event is SignUpFetched) {
        emit(SignUpLoading());

        String lang = await LocalStorageService.readData("language") ?? "en";

        try {
          SignUpResponse response = await repository.signUp(event.request);

          bool isError = false;
          if (response.response?.code != null) {
            if (response.response!.code!.toLowerCase() == "00") {
              emit(SignUpLoaded());
              return;
            }
            isError = true;
          } else {
            isError = true;
          }

          if (isError) {
            final message = lang == "en"
                ? (response.response?.messageEn ?? "Registration failed")
                : (response.response?.messageId ?? "Registrasi gagal");
            emit(SignUpError(textError: message));
          }
        } catch (e) {
          emit(SignUpError(textError: e.toString()));
        }
      }
    });
  }
}
