import 'package:flutter/foundation.dart';
import 'package:ktr_msc_ls1/core/models/user.dart';
import 'package:ktr_msc_ls1/core/services/authentication_service.dart';
import 'package:ktr_msc_ls1/core/services/localstorage_service.dart';

class ProfileViewModel extends ChangeNotifier {
  AuthenticationService _authenticationService;
  LocalStorageService _localStorageService;

  ProfileViewModel(
      {@required AuthenticationService authenticationService,
      @required LocalStorageService localStorageService})
      : _authenticationService = authenticationService,
        _localStorageService = localStorageService;

  Future<bool> signUp() async {
    try {
      bool success = await _authenticationService.signUp();

      if (success) {
      } else {
        await _localStorageService.setUser(User());
        return true;
      }
    } on Exception catch (e) {
      print(e.toString());
    }

    return false;
  }
}
