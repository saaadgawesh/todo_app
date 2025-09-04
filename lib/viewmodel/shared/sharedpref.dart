import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/model/user_model.dart';

/// 📌 كلاس مساعد لحفظ/قراءة بيانات المستخدم
class UserPrefs {
  static Future<void> saveUser({
    required String id,
    required String name,
    required String email,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", id);
    await prefs.setString("userName", name);
    await prefs.setString("userEmail", email);
  }

  static Future<Map<String, String?>> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      "id": prefs.getString("userId"),
      "name": prefs.getString("userName"),
      "email": prefs.getString("userEmail"),
    };
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

/// 📌 provider مسؤول عن المستخدم
class UserProvider extends ChangeNotifier {
  UserModel? currentUser;

  /// تحميل المستخدم من SharedPreferences
  Future<void> loadUser() async {
    final data = await UserPrefs.getUser();
    if (data["id"] != null) {
      currentUser = UserModel(
        id: data["id"]!,
        name: data["name"] ?? "",
        email: data["email"] ?? "",
      );
      notifyListeners();
    }
  }

  /// حفظ المستخدم في SharedPreferences وتحديث الـ provider
  Future<void> setUser(UserModel user) async {
    currentUser = user;
    await UserPrefs.saveUser(
      id: user.id,
      name: user.name,
      email: user.email,
    );
    notifyListeners();
  }

  /// تسجيل الخروج
  Future<void> logout() async {
    currentUser = null;
    await UserPrefs.clearUser();
    notifyListeners();
  }
}
