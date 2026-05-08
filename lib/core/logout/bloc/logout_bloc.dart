import 'package:bloc/bloc.dart';
import 'package:blueprint_mobile_flutter/core/logout/model/response/logout_response.dart';
import 'package:blueprint_mobile_flutter/core/logout/repository/logout_repository.dart';
import 'package:blueprint_mobile_flutter/utils/services/storage/local_storage_service.dart';
import 'package:equatable/equatable.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LogoutRepository repository;

  LogoutBloc({required this.repository}) : super(LogoutInitState()) {
    on<LogoutEvent>((event, emit) async {
      if (event is LogoutIdleEvent) {
        emit(LogoutIdleState());
      } else if (event is LogoutFetched) {
        emit(LogoutLoading());

        String lang = await LocalStorageService.readData("language");

        LogoutResponse response = await repository.logout();

        bool isError = false;
        if (response.response!.code != null) {
          if (response.response!.code!.toLowerCase() == "00") {
            emit(LogoutLoaded(response: response.response!));
          } else {
            isError = true;
          }
        } else {
          isError = true;
        }

        if (isError) {
          if (lang == "en")
            emit(LogoutError(
                textError: response.response!.messageEn.toString()));
          else
            emit(LogoutError(
                textError: response.response!.messageId.toString()));
        }
      }
    });
  }
}
