import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:blueprint_mobile_flutter/core/onboarding/model/onboarding_model.dart';
import 'package:blueprint_mobile_flutter/core/onboarding/repository/onboarding_repository.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  final OnboardingRepository repository;

  OnboardingBloc({required this.repository}) : super(OnBoardingInitState()) {
    on<OnBoardingEvent>((event, emit) async {
      if (event is FetchOnBoarding) {
        emit(OnBoardingLoading());

        try {
          List<OnBoardingModel> onBoardingList =
              await repository.getOnBoardingList();
          emit(OnBoardingLoaded(onBoardingList: onBoardingList));
        } on SocketException {
          emit(OnBoardingError(error: "Tidak ada koneksi internet"));
        } on HttpException {
          emit(OnBoardingError(error: "Service tidak ditemukan"));
        } on FormatException {
          emit(OnBoardingError(error: "Invalid response format"));
        } catch (e) {
          emit(OnBoardingError(
              error:
                  "Terjadi masalah dalam aplikasi. Mohon tunggu beberapa saat lagi."));
          print("Error request:" + e.toString());
        }
      }
    });
  }
}
