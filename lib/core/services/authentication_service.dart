
import 'localstorage_service.dart';

class AuthenticationService {
  final LocalStorageService _localStorageService;

  AuthenticationService({LocalStorageService localStorageService}) : _localStorageService = localStorageService;

  Future<bool> login(String phone, String password) async {
    return true;
  }

  Future<bool> signUp() async {
    return true;
  }


  Future<bool> logout() async {
    return true;
  }
}
