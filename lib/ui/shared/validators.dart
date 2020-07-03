class Validators {
  static String required(String value) {
    if (value == null || value.isEmpty) {
      return "Field required";
    }
    return null;
  }

  static String validatePassword(String password) {
    if (password == null || password.isEmpty) {
      return "Champs obligatoire";
    }
    if (password.length < 6) {
      return "Au moins 6 caractères";
    }
    return null;
  }

  static String validateEmail(String email) {
    if (email == null || email.isEmpty) {
      return "Field required";
    }
    if (email.length < 3 || email.length >= 20) {
      return "Email non valide";
    }

    RegExp regExp = RegExp(
        "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$");
    if (!regExp.hasMatch(email)) {
      return "Email non valide";
    }
    return null;
  }
}
