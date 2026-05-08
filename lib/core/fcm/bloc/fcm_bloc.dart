import 'package:bloc/bloc.dart';
import 'package:blueprint_mobile_flutter/core/fcm/model/request/update_fcm_request.dart';
import 'package:blueprint_mobile_flutter/core/fcm/model/response/update_fcm_response.dart';
import 'package:blueprint_mobile_flutter/core/fcm/repository/fcm_repository.dart';
import 'package:blueprint_mobile_flutter/utils/services/storage/local_storage_service.dart';
import 'package:equatable/equatable.dart';

part 'fcm_event.dart';
part 'fcm_state.dart';

class FcmBloc extends Bloc<FcmEvent, FcmState> {
  final FcmRepository repository;

  FcmBloc({required this.repository}) : super(FcmInitState()) {
    on<FcmEvent>((event, emit) async {
      if (event is FcmIdleEvent) {
        emit(FcmIdleState());
      } else if (event is FcmFetched) {
        emit(FcmLoading());

        String lang = await LocalStorageService.readData("language");

        UpdateFcmResponse response = await repository.updateFcm(event.request);

        bool isError = false;
        if (response.response!.code != null) {
          if (response.response!.code!.toLowerCase() == "00") {
            emit(FcmLoaded(response: response.response!));
          } else {
            isError = true;
          }
        } else {
          isError = true;
        }

        if (isError) {
          if (lang == "en")
            emit(FcmError(textError: response.response!.messageEn.toString()));
          else
            emit(FcmError(textError: response.response!.messageId.toString()));
        }
      }
    });
  }
}
