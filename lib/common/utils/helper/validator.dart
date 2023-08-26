String? nameValidator(String? input) {
  if (input == null || input.trim().length < 2) {
    return 'Name must be 2 characters long';
  } else {
    return null;
  }
}

String? emailValidator(String? input) {
  RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  if (input == null || !emailRegex.hasMatch(input)) {
    return 'Enter valid email Address';
  } else {
    return null;
  }
}

String? passValidator(String? input) {
  if (input == null || input.trim().length < 8) {
    return 'Password must be 8 characters long';
  } else {
    return null;
  }
}
