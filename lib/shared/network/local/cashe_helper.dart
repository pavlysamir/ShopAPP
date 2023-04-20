import 'package:shared_preferences/shared_preferences.dart';

class CasheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<dynamic> SaveData({
    required String key,
    required dynamic value,
  }) async
  {
    if(value is String)
    {
      return await sharedPreferences!.setString(key, value);
    }
    else if(value is int)
    {
      return await sharedPreferences!.setInt(key, value);
    }
    else if(value is bool)
    {
      return await sharedPreferences!.setBool(key, value);
    }
    else return await sharedPreferences!.setDouble(key, value);

  }

  static dynamic getData({
  required String key,
})
  {
    return sharedPreferences?.get(key);
  }

  static Future<dynamic> removeData({
    required dynamic key,
  })async
  {
    return await sharedPreferences?.remove(key);
  }
}



