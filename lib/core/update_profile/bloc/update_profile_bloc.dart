import 'package:bloc/bloc.dart';
import 'package:blueprint_mobile_flutter/core/update_profile/model/request/update_profile_request.dart';
import 'package:blueprint_mobile_flutter/core/update_profile/model/response/update_profile_response.dart';
import 'package:blueprint_mobile_flutter/core/update_profile/repository/update_profile_repository.dart';
import 'package:blueprint_mobile_flutter/utils/services/storage/local_storage_service.dart';
import 'package:equatable/equatable.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final UpdateProfileRepository repository;

  UpdateProfileBloc({required this.repository})
      : super(UpdateProfileInitState()) {
    on<UpdateProfileEvent>((event, emit) async {
      if (event is UpdateProfileIdleEvent) {
        emit(UpdateProfileIdleState());
      } else if (event is UpdateProfileFetched) {
        emit(UpdateProfileLoading());

        String lang = await LocalStorageService.readData("language");

        UpdateProfileResponse response =
            await repository.updateProfile(event.request);

        bool isError = false;
        if (response.response!.code != null) {
          if (response.response!.code!.toLowerCase() == "00") {
            emit(UpdateProfileLoaded(response: response.response!.data!));
          } else {
            isError = true;
          }
        } else {
          isError = true;
        }

        if (isError) {
          if (lang == "en")
            emit(UpdateProfileError(
                textError: response.response!.messageEn.toString()));
          else
            emit(UpdateProfileError(
                textError: response.response!.messageId.toString()));
        }
      }
    });
  }
}
