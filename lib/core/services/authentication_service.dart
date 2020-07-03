
import 'package:ktr_msc_ls1/core/models/user.dart';

import 'localstorage_service.dart';

class AuthenticationService {
  final LocalStorageService _localStorageService;

  AuthenticationService({LocalStorageService localStorageService}) : _localStorageService = localStorageService;

  Future<bool> login(String phone, String password) async {
    return true;
  }

  Future<bool> signUp(String name,String companyName,String email,String phone) async {
    await _localStorageService.setUser(User(
      name:name,
      companyName: companyName,
      email: email,
      phone: phone
    ));
    return true;
  }


  Future<bool> logout() async {
    return true;
  }
}
