import 'package:flutter/foundation.dart';
import 'package:ktr_msc_ls1/core/models/user.dart';
import 'package:ktr_msc_ls1/core/services/authentication_service.dart';
import 'package:ktr_msc_ls1/core/services/localstorage_service.dart';


class LoginViewModel extends ChangeNotifier {
  AuthenticationService _authenticationService;
  LocalStorageService _localStorageService;

  LoginViewModel(
      {@required AuthenticationService authenticationService,
      @required LocalStorageService localStorageService})
      : _authenticationService = authenticationService,
        _localStorageService = localStorageService;

  Future<bool> login(String phone, String password) async {
    try {
      bool success = await _authenticationService.login(phone, password);
      if (success) {
        await _localStorageService.setUser(User());
        return true;
      }
    } on Exception catch (e) {
      print(e.toString());
    }

    return false;
  }
}
