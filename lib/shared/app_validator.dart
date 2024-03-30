class AppValidator {
  static bool isEmail(String value) => RegExp(
          r'^[a-zA-Z0-9]+(?:\.[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(?:\.[a-zA-Z0-9]+)*$')
      .hasMatch(value);
}
