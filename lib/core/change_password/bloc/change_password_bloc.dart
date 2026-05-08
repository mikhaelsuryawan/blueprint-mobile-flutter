import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/services/storage/local_storage_service.dart';
import '../model/request/change_password_request.dart';
import '../model/response/change_password_response.dart';
import '../repository/change_password_repository.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePasswordRepository repository;

  ChangePasswordBloc({required this.repository})
      : super(ChangePasswordInitState()) {
    on<ChangePasswordEvent>((event, emit) async {
      if (event is ChangePasswordIdleEvent) {
        emit(ChangePasswordIdleState());
      } else if (event is ChangePasswordFetched) {
        emit(ChangePasswordLoading());

        String lang = await LocalStorageService.readData("language");

        ChangePasswordResponse response =
            await repository.changePassword(event.request);

        bool isError = false;
        if (response.response?.code != null) {
          if (response.response?.code?.toLowerCase() == "00") {
            emit(ChangePasswordLoaded(
                response: response.response ?? ChangePasswordResponseData()));
          } else {
            isError = true;
          }
        } else {
          isError = true;
        }

        if (isError) {
          if (lang == "en")
            emit(ChangePasswordError(
                textError: response.response?.messageEn?.toString() ??
                    "Server is not responding"));
          else
            emit(ChangePasswordError(
                textError: response.response?.messageId?.toString() ??
                    "Server is not responding"));
        }
      }
    });
  }
}
