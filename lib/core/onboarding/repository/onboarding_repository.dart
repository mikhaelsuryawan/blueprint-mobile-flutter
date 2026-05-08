import '../model/onboarding_model.dart';

abstract class OnboardingRepository {
  Future<List<OnBoardingModel>> getOnBoardingList();
}

class OnboardingService implements OnboardingRepository {
  @override
  Future<List<OnBoardingModel>> getOnBoardingList() async {
    List<OnBoardingModel> _onBoardingList = [];

    _onBoardingList.addAll(OnBoardingModel.getData());

    return _onBoardingList;
  }
}
