import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../utils/services/storage/local_storage_service.dart';
import '../model/response/profile_response.dart';
import '../repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc({required this.repository}) : super(ProfileInitState()) {
    on<ProfileEvent>((event, emit) async {
      if (event is ProfileIdleEvent) {
        emit(ProfileIdleState());
      } else if (event is ProfileFetched) {
        emit(ProfileLoading());

        String lang = await LocalStorageService.readData("language");

        ProfileResponse response = await repository.profile();

        bool isError = false;
        if (response.response!.code != null) {
          if (response.response!.code!.toLowerCase() == "00") {
            emit(ProfileLoaded(response: response.response!.data!.detailData!));
          } else {
            isError = true;
          }
        } else {
          isError = true;
        }

        if (isError) {
          if (lang == "en")
            emit(ProfileError(
                textError: response.response!.messageEn.toString()));
          else
            emit(ProfileError(
                textError: response.response!.messageId.toString()));
        }
      }
    });
  }
}
