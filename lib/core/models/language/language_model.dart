import '../../../constants/assets_path.dart';

class LanguageModel {
  String assetPath;
  String name;
  String id;
  bool isSelected;

  LanguageModel({
    required this.assetPath,
    required this.name,
    required this.id,
    required this.isSelected,
  });

  static List<LanguageModel> getData(context) {
    List<LanguageModel> _data = [];

    _data.add(LanguageModel(
        name: 'English',
        id: 'en',
        assetPath: Assets.english,
        isSelected: false));
    _data.add(LanguageModel(
        name: 'Bahasa Indonesia',
        id: 'id',
        assetPath: Assets.indonesia,
        isSelected: false));

    return _data;
  }
}
