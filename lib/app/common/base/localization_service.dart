import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'lang/en_US.dart';
import 'lang/fa_IR.dart';



class LocalizationService extends Translations {
  //static final locale = Locale('en', 'US');
  static const fallBackLocale = Locale('en', 'US');
  // static final fallBackLocale = Locale('fa', 'IR');

  static final langs = ['English', 'Farsi'];
  static final locales = [const Locale('en', 'US'), const Locale('fa', 'IR')];

  @override
  Map<String, Map<String, String>> get keys => {'en_US': enUS, 'fa_IR': faIR};

  void changeLocale(String lang) {
    final locale = getLocaleFromLanguage(lang);
    final box = GetStorage();
    box.write('lng', lang);

    Get.updateLocale(locale!);
  }

  Locale? getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }

  Locale? getCurrentLocale() {
    final box = GetStorage();
    Locale? defaultLocale;

    if (box.read('lng') != null) {
      final Locale? a = getLocaleFromLanguage(box.read('lng'));
      defaultLocale = a;
    } else {
      defaultLocale = fallBackLocale;
    }
    return defaultLocale;
  }

  String getCurrentLang() {
    final box = GetStorage();

    return box.read('lng') ?? 'Farsi';
  }
}
