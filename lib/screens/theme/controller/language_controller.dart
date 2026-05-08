import 'package:flutter/material.dart';

import '../../../../config/language/language_manager.dart';
import '../../../../core/models/language/language_model.dart';

/// Controller for managing language selection operations
///
/// Handles:
/// - Language list management
/// - Language selection state
/// - Language switching via AppLanguageNotifier
/// - Synchronizing selection state with current language
class LanguageController extends ChangeNotifier {
  final AppLanguageNotifier languageNotifier;
  List<LanguageModel> _languageList = [];

  LanguageController({
    required this.languageNotifier,
    BuildContext? context,
  }) {
    // Initialize language list
    if (context != null) {
      _languageList = LanguageModel.getData(context);
      _updateSelectionFromNotifier();
    }

    // Listen to language changes to update selection
    languageNotifier.addListener(_updateSelectionFromNotifier);
  }

  /// Getter for language list
  List<LanguageModel> get languageList => _languageList;

  /// Get currently selected language index
  int? get selectedLanguageIndex {
    for (int i = 0; i < _languageList.length; i++) {
      if (_languageList[i].isSelected) {
        return i;
      }
    }
    return null;
  }

  /// Get currently selected language
  LanguageModel? get selectedLanguage {
    for (var language in _languageList) {
      if (language.isSelected) {
        return language;
      }
    }
    return null;
  }

  /// Initialize language list from context
  void initializeLanguageList(BuildContext context) {
    _languageList = LanguageModel.getData(context);
    _updateSelectionFromNotifier();
    notifyListeners();
  }

  /// Update selection state based on current language from notifier
  void _updateSelectionFromNotifier() {
    final currentLanguageCode = languageNotifier.getLanguage().languageCode;

    for (int i = 0; i < _languageList.length; i++) {
      _languageList[i].isSelected = _languageList[i].id == currentLanguageCode;
    }

    notifyListeners();
  }

  /// Select language by index
  ///
  /// [index] - Index of the language in the list
  void selectLanguage(int index) {
    if (index < 0 || index >= _languageList.length) {
      return;
    }

    // Update selection state
    for (int i = 0; i < _languageList.length; i++) {
      _languageList[i].isSelected = (i == index);
    }

    // Update language in notifier
    final selectedLanguage = _languageList[index];
    if (selectedLanguage.id == 'en') {
      languageNotifier.setEn();
    } else if (selectedLanguage.id == 'id') {
      languageNotifier.setId();
    }

    notifyListeners();
  }

  /// Select language by ID
  ///
  /// [languageId] - Language ID ('en' or 'id')
  void selectLanguageById(String languageId) {
    for (int i = 0; i < _languageList.length; i++) {
      if (_languageList[i].id == languageId) {
        selectLanguage(i);
        return;
      }
    }
  }

  /// Check if language is selected
  ///
  /// [index] - Index of the language
  bool isLanguageSelected(int index) {
    if (index < 0 || index >= _languageList.length) {
      return false;
    }
    return _languageList[index].isSelected;
  }

  /// Get current language code
  String get currentLanguageCode {
    return languageNotifier.getLanguage().languageCode;
  }

  @override
  void dispose() {
    languageNotifier.removeListener(_updateSelectionFromNotifier);
    super.dispose();
  }
}
