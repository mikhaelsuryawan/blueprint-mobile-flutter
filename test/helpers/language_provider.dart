import 'package:blueprint_mobile_flutter/utils/services/storage/local_storage_service.dart';

abstract class LanguageProvider {
  Future<String> readLanguage();
}

class LocalLanguageProvider implements LanguageProvider {
  @override
  Future<String> readLanguage() async =>
      await LocalStorageService.readData("language");
}
