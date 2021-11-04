import 'dart:convert';

import 'package:chatim/models/person_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  static late SharedPreferences _pref;

  static const String _personData = 'person';
  static const String _isLogin = '_isLogin';

  static Future<void> savePersonSession(PersonModel person) async {
    final String data = jsonEncode(person);
    _pref = await SharedPreferences.getInstance();

    await _pref.setString(_personData, data);
    debugPrint(">>> Session saved to person ");
  }

  static Future<void> setLoginSession(bool status) async {
    _pref = await SharedPreferences.getInstance();

    await _pref.setBool(_isLogin, status);
    debugPrint(">>> Session login status saved to : " + status.toString());
  }

  static Future<PersonModel> getPersonFromSession() async {
    _pref = await SharedPreferences.getInstance();

    final String data = _pref.getString(_personData)!;

    Map<String, dynamic> p = jsonDecode(data);
    return PersonModel.fromJson(p);
  }

  static Future<bool> getLoginStatus() async {
    _pref = await SharedPreferences.getInstance();
    final bool status = _pref.getBool(_isLogin) ?? false;
    return status;
  }

  static Future<void> clearPrefs() async {
    _pref = await SharedPreferences.getInstance();
    await _pref.clear();
  }
}
