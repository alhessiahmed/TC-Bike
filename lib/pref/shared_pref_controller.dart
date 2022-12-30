import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcbike/model/user.dart';

enum UserInfo {
  id,
  name,
  phone,
  image,
  token,
  isLoggedIn,
  rememberMe,
  firstVisit,
  lang,
  suggestions,
  provider,
  email,
}

enum Providers {
  google,
  phone,
}

class SharedPrefController {
  static SharedPrefController? _instance;
  late SharedPreferences _sharedPreferences;

  SharedPrefController._();

  factory SharedPrefController() {
    return _instance ??= SharedPrefController._();
  }

  Future<void> initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> loginForFirstTime() async {
    await _sharedPreferences.setBool(UserInfo.firstVisit.name, true);
  }

  // Future<void> saveUser({required User user}) async {
  //   await _sharedPreferences.setBool(UserInfo.isLoggedIn.name, true);
  //   await _sharedPreferences.setInt(UserInfo.id.name, user.id);
  //   await _sharedPreferences.setString(UserInfo.phone.name, user.phone);
  //   await _sharedPreferences.setString(UserInfo.name.name, user.name);
  //   await _sharedPreferences.setString(
  //       UserInfo.token.name, 'Bearer ${user.token}');
  // }

  Future<void> saveUser({
    required User user,
    String provider = 'phone',
    String? email,
  }) async {
    await _sharedPreferences.setBool(UserInfo.isLoggedIn.name, true);
    await _sharedPreferences.setInt(UserInfo.id.name, user.id);
    await _sharedPreferences.setString(UserInfo.phone.name, user.phone);
    await _sharedPreferences.setString(UserInfo.name.name, user.name);
    await _sharedPreferences.setString(UserInfo.provider.name, provider);
    await _sharedPreferences.setString(UserInfo.email.name, email ?? '');
    await _sharedPreferences.setString(
        UserInfo.token.name, 'Bearer ${user.token}');
  }

  Future<void> changeName({required String newName}) async {
    await _sharedPreferences.setString(UserInfo.name.name, newName);
  }

  Future<void> changeImage({required String newImage}) async {
    await _sharedPreferences.setString(UserInfo.image.name, newImage);
  }

  Future<void> saveLang({required String lang}) async {
    await _sharedPreferences.setString(UserInfo.lang.name, lang);
  }

  Future<bool> clear() async => _sharedPreferences.clear();

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    await _sharedPreferences.setBool(UserInfo.isLoggedIn.name, false);
    await _sharedPreferences.setString(UserInfo.token.name, '');
    await _sharedPreferences.setInt(UserInfo.id.name, -1);
    await _sharedPreferences.setString(UserInfo.image.name, '');
    await _sharedPreferences.setBool(UserInfo.rememberMe.name, false);
    await _sharedPreferences.setBool(UserInfo.firstVisit.name, false);
  }

  Future<void> addToLatestSearchList(String text) async {
    List<String> list = readLatestSearchList();
    if (list.length == 5) {
      list.removeAt(0);
    }
    list.add(text);
    await _sharedPreferences.setStringList(UserInfo.suggestions.name, list);
  }

  List<String> readLatestSearchList() {
    return _sharedPreferences.getStringList(UserInfo.suggestions.name) ?? [];
  }

  Future<bool> setRememberMeStatus(bool rememberMe) async {
    return await _sharedPreferences.setBool(
        UserInfo.rememberMe.name, rememberMe);
  }

  T? getByKey<T>({required String key}) {
    if (_sharedPreferences.containsKey(key)) {
      return _sharedPreferences.get(key) as T;
    }
    return null;
  }

  bool get loggedIn =>
      _sharedPreferences.getBool(UserInfo.isLoggedIn.name) ?? false;

  bool get rememberMe =>
      _sharedPreferences.getBool(UserInfo.rememberMe.name) ?? false;

  bool get firstVisit =>
      _sharedPreferences.getBool(UserInfo.firstVisit.name) ?? true;

  String get token => _sharedPreferences.getString(UserInfo.token.name) ?? '';

  String get provider =>
      _sharedPreferences.getString(UserInfo.provider.name) ?? 'phone';

  String get lang =>
      _sharedPreferences.getString(UserInfo.lang.name) ??
      (Get.deviceLocale?.languageCode.substring(0, 2) == 'he' ? 'he' : 'ar');
}
