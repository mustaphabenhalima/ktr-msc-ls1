import 'dart:async';

import 'package:ktr_msc_ls1/core/models/business_card.dart';
import 'package:ktr_msc_ls1/core/services/localstorage_service.dart';

class DataService {
  LocalStorageService localStorageService;

  DataService({this.localStorageService});

  Future<List<BusinessCard>> getCards() async {
    return localStorageService.getCards();
  }
}
