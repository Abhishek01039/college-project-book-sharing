import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  static SharedPreferences prefs;
  static String enrollmentNo;
  static String studentName;
  static String lastName;
  static void setPref(SharedPreferences prefs1) {
    prefs = prefs1;
    // SPHelper.setBool("DarkTheme", false);
  }

  static int getInt(String key) {
    return prefs.getInt(key) ?? 0;
  }

  static void setInt(String key, int value) {
    prefs.setInt(key, value);
    //prefs.commit();
  }

  static void setStringList(String key, List<String> lstCart) {
    prefs.setStringList(key, lstCart);
  }

  static List<String> getStringList(String key) {
    return (prefs.containsKey(key)) ? prefs.getString(key) : List<String>();
  }

  static String getString(String key) {
    return prefs.getString(key) ?? "";
  }

  static void setString(String key, String value) {
    prefs.setString(key, value);
    print(key.toString() + "" + value);
  }

  static bool getBool(String key) {
    return prefs.getBool(key);

    // print(key.toString() + "" + value.toString());
  }

  static void setBool(String key, bool value) {
    prefs.setBool(key, value);
    print(key.toString() + "" + value.toString());
  }

  static void logout() {
    // prefs.clear();
    // if (getBool("DarkTheme") == null) {
    //   setBool("DarkTheme", false);
    // }
    prefs.remove("ID");
    prefs.remove("enrollmentNo");
    prefs.remove("studentName");
    prefs.remove("studentPhoto");
  }
}
