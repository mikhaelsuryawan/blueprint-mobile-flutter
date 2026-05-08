import 'package:flutter/material.dart';

import '../../utils/services/storage/local_storage_service.dart';

class AppLanguageNotifier extends ChangeNotifier {
  Locale _locale = Locale('id', '');
  Locale _localeId = Locale('id', '');
  Locale _localeEn = Locale('en', '');

  AppLanguageNotifier() {
    _locale = _localeId;
    LocalStorageService.readData('language').then((value) {
      print('language read from storage: ' + value.toString());
      var language = value ?? 'en';
      if (language == 'en') {
        print('language en');
        _locale = _localeEn;
      } else {
        print('language id');
        _locale = _localeId;
      }
      notifyListeners();
    });
  }

  void setEn() async {
    _locale = _localeEn;
    LocalStorageService.saveData('language', 'en');
    notifyListeners();
  }

  void setId() async {
    _locale = _localeId;
    LocalStorageService.saveData('language', 'id');
    notifyListeners();
  }

  Locale getLanguage() {
    return _locale;
  }
}
