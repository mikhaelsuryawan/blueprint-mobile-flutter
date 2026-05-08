import 'package:bloc/bloc.dart';
import 'package:blueprint_mobile_flutter/core/auth_token/repository/auth_token_repository.dart';
import 'package:blueprint_mobile_flutter/core/refresh_token/repository/refresh_token_repository.dart';
import 'package:equatable/equatable.dart';

import '../model/request/auth_token_request.dart';
import '../model/response/auth_token_response.dart';

part 'refresh_token_event.dart';
part 'refresh_token_state.dart';

class RefreshTokenBloc extends Bloc<RefreshTokenEvent, RefreshTokenState> {
  final RefreshTokenRepository refreshTokenRepository;
  final AuthTokenRepository authTokenRepository;

  RefreshTokenBloc(
      {required this.authTokenRepository, required this.refreshTokenRepository})
      : super(RefreshTokenInitState()) {
    on<RefreshTokenEvent>((event, emit) async {
      if (event is RefreshTokenIdleEvent) {
        emit(RefreshTokenIdleState());
      } else if (event is RefreshTokenFetched) {
        emit(RefreshTokenLoading());
        AuthTokenResponse response =
            await refreshTokenRepository.refreshToken(event.request);

        if (response.response?.messageEn?.toLowerCase() == "success")
          emit(RefreshTokenLoaded(response: response));
        else
          emit(RefreshTokenError(textError: response.response?.messageEn ?? ""));
      } else if (event is AuthTokenFetched) {
        emit(RefreshTokenLoading());
        AuthTokenResponse response =
            await authTokenRepository.authToken(event.request);

        if (response.response?.messageEn?.toLowerCase() == "success")
          emit(RefreshTokenLoaded(response: response));
        else
          emit(RefreshTokenError(textError: response.response?.messageEn ?? ""));
      }
    });
  }
}
