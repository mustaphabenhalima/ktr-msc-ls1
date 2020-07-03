import 'package:flutter/cupertino.dart';
import 'package:ktr_msc_ls1/core/models/business_card.dart';
import 'package:ktr_msc_ls1/core/models/user.dart';
import 'package:ktr_msc_ls1/core/services/data_service.dart';
import 'package:ktr_msc_ls1/core/services/localstorage_service.dart';

class LibraryViewModel extends ChangeNotifier {
  DataService _dataService;
  LocalStorageService _localStorageService;

  LibraryViewModel({
    @required DataService dataService,
    @required LocalStorageService localStorageService,
  })  : _dataService = dataService,
        _localStorageService = localStorageService;

  User user;
  List<BusinessCard> cards = [];

  Future<void> addCard(
      String name, String companyName, String email, String phone) async {
    cards.add(BusinessCard(
      name: name,
      companyName: companyName,
      email: email,
      phone: phone,
    ));
    await _localStorageService.setCards(cards);
    notifyListeners();
  }

  bool isLoading = false;

  Future<void> init() async {
    isLoading = true;
    notifyListeners();
    try {
      cards = await _dataService.getCards();
    } on Exception catch (e) {
      print(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> logout()async{
    await _localStorageService.clearLocalData();
  }
}
