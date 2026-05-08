import '../../../constants/assets_path.dart';

class OnBoardingModel {
  String urlImage;
  String introTitle;
  String introSubtitle;

  OnBoardingModel({
    required this.urlImage,
    required this.introTitle,
    required this.introSubtitle,
  });

  static List<OnBoardingModel> getData() {
    List<OnBoardingModel> _data = [];

    _data.add(OnBoardingModel(
        introTitle: 'Watch and Learn',
        introSubtitle:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam, purus sit',
        urlImage: Assets.onboardingLottie));
    _data.add(OnBoardingModel(
        introTitle: 'Watch and Learn',
        introSubtitle:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam, purus sit',
        urlImage: Assets.onboardingLottie));
    _data.add(OnBoardingModel(
        introTitle: 'Watch and Learn',
        introSubtitle:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit ut aliquam, purus sit',
        urlImage: Assets.onboardingLottie));

    return _data;
  }
}
