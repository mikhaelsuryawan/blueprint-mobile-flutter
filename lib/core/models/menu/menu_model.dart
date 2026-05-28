import '../../../constants/assets_path.dart';

class MenuModel {
  String urlImage;
  String name;
  int price;

  MenuModel({
    required this.urlImage,
    required this.name,
    required this.price,
  });

  static List<MenuModel> getData() {
    List<MenuModel> _data = [];

    _data.add(MenuModel(name: 'Button', price: 5000, urlImage: Assets.noImage));

    return _data;
  }
}
