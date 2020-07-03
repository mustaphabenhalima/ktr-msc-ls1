import 'dart:convert';

import 'package:ktr_msc_ls1/core/models/business_card.dart';
import 'package:ktr_msc_ls1/core/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static SharedPreferences _preferences;

  Future<SharedPreferences> getInstance() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _preferences;
  }

  static const String UserKey = 'user';
  static const String CardsKey = 'cards';

  Future<User> getUser() async {
    var userJson = await _getFromDisk(UserKey);
    if (userJson != null) {
      return User.fromJson(json.decode(userJson));
    }

    return null;
  }

  Future<void> setUser(User userToSave) async {
    await saveStringToDisk(UserKey, json.encode(userToSave.toJson()));
  }

  Future<List<BusinessCard>> getCards() async {
    var cardsJson = await _getFromDisk(CardsKey);
    List<BusinessCard> cards = [];
    if (cardsJson != null) {
      cards = List<dynamic>.from(json.decode(cardsJson))
          .map((card) => BusinessCard.fromJson(card))
          .toList();
    }

    return cards;
  }

  Future<void> setCards(List<BusinessCard> cardsToSave) async {
    var tmp = cardsToSave.map((card) => card.toJson()).toList();
    await saveStringToDisk(CardsKey, json.encode(tmp));
  }

  Future<bool> clearLocalData() async {
    if (_preferences == null) {
      await getInstance();
    }
    return await _preferences.clear();
  }

  dynamic _getFromDisk(String key) async {
    if (_preferences == null) {
      await getInstance();
    }
    var value = _preferences.get(key);
    print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  Future<void> saveStringToDisk(String key, String content) async {
    print(
        '(TRACE) LocalStorageService:_saveStringToDisk. key: $key value: $content');

    if (_preferences == null) {
      await getInstance();
    }
    _preferences.setString(key, content);
  }
}
