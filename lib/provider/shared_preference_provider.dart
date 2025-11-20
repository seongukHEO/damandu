import 'package:shared_preferences/shared_preferences.dart';

import '../common/shared_preference_keys.dart';

class SharedPreferenceProvider{
  static SharedPreferences? _prefs;

  static Future<void>init()async{
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void>saveUid(String uid)async{
    await _prefs?.setString(SharedPreferenceKeys.userUid, uid);
  }

  static Future<String?> getUid()async{
    return _prefs?.getString(SharedPreferenceKeys.userUid);
  }

  static Future<void>deleteUid()async{
    await _prefs?.remove(SharedPreferenceKeys.userUid);
  }


  // ✅ 추가: 어디서든 즉시 접근 가능한 전역 getter
  static String? get currentUid {
    return _prefs?.getString(SharedPreferenceKeys.userUid);
  }


}