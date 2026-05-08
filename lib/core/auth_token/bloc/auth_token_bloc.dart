import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/services/storage/local_storage_service.dart';
import '../../refresh_token/model/request/auth_token_request.dart';
import '../../refresh_token/model/response/auth_token_response.dart';
import '../repository/auth_token_repository.dart';

part 'auth_token_event.dart';
part 'auth_token_state.dart';

class AuthTokenBloc extends Bloc<AuthTokenEvent, AuthTokenState> {
  final AuthTokenRepository authRepository;

  AuthTokenBloc({required this.authRepository}) : super(AuthTokenInitState()) {
    on<AuthTokenEvent>((event, emit) async {
      if (event is AuthTokenIdleEvent) {
        emit(AuthTokenIdleState());
      } else if (event is AuthTokenFetched) {
        emit(AuthTokenLoading());

        String lang = await LocalStorageService.readData("language");

        AuthTokenResponse response =
            await authRepository.authToken(event.request);

        bool isError = false;
        if (response.response?.code != null) {
          if (response.response?.code?.toLowerCase() == "00") {
            emit(AuthTokenLoaded(
                response: response.response?.data ?? AuthTokenData()));
          } else {
            isError = true;
          }
        } else {
          isError = true;
        }

        if (isError) {
          if (lang == "en")
            emit(AuthTokenError(
                textError: response.response?.messageEn?.toString() ?? ""));
          else
            emit(AuthTokenError(
                textError: response.response?.messageId?.toString() ?? ""));
        }
      }
    });
  }
}
