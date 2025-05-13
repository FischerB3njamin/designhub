class ValidationController {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length <= 5) {
      return 'Password must be at least 8 characters long';
    }

    return null;
  }

  static String? validateNotEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter value.';
    }
    return null;
  }

  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    final urlRegex =
        RegExp(r'^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$', caseSensitive: false);
    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid URL';
    }
    return null;
  }

  static String? validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter value.';
    }
    if (value.length > 500) {
      return "Maximum 500 chars for the title";
    }
    return null;
  }

  static String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter value.';
    }
    if (value.length > 2250) {
      return "Maximum 2250 chars for the description";
    }
    return null;
  }

  static String? validateHashtags(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter value.';
    }

    for (final item in value.trim().split(' ')) {
      if (!item.contains('#')) {
        return "Please for each hashstag a # and split it by a whitespace";
      }
    }

    return null;
  }
}
