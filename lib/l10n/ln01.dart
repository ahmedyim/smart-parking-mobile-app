import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('am'),
    const Locale('en'),
  ];
  static String getName(String code) {
    switch (code) {
      case 'am':
        return 'አማርኛ';

      case 'en':
      default:
        return 'English';
    }
  }
}
