import 'dart:developer';

import 'package:crypto_portfolio_tracker/core/export_file.dart';

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static SharedPreferences? _preferences;

  static Future<SharedPreferencesService?> getInstance() async {
    _instance ??= SharedPreferencesService();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance;
  }

  //user Id
  static String get getCoinList {
    return _preferences?.getString(SharedPreferenceEnum.coinList.key) ?? '';
  }

  Future<void> saveCoinList(String value) async {
    try {
      await _preferences?.setString(SharedPreferenceEnum.coinList.key, value);
    } catch (e) {
      log('coin list $e');
    }
  }

  static Future<void> clearAll() async {
    await _preferences?.clear();
  }
}

enum SharedPreferenceEnum {
  coinList('coinList');

  const SharedPreferenceEnum(this.key);

  final String key;
}
