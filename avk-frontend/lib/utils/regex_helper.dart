import 'package:flutter/services.dart';

/// instance for regex helper class
RegexHelper regexHelper = RegexHelper();

/// regex helper class
class RegexHelper {
  /// Checks if a given string field is empty.
  /// Returns true if the string is null or empty, otherwise false.
  bool checkFieldIsEmpty(String? text) => text == null || text.trim().isEmpty;

  /// Checks if a given string field is empty.
  /// Returns true if the string is null or empty, otherwise false.
  bool checkMinLength(String? text, int minLength) =>
      (text?.trim().length ?? 0) < minLength;

  /// Checks if a given string field is empty.
  /// Returns true if the string is null or empty, otherwise false.
  bool checkLengthIsEqual(String? text, int length) => text?.length == length;

  /// Validates an email address using a regular expression.
  /// Returns true if the email matches the format, otherwise false.
  bool emailValid(String mail) => RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  ).hasMatch(mail.trim());

  /// project settings Pressure min max formatter
  List<TextInputFormatter>? projectSettingsPressureMinMaxFormatters =
      <TextInputFormatter>[
        DecimalRangeInputFormatter(min: 0.0, max: 25.0),
      ];

  /// project settings min max formatter
  List<TextInputFormatter>? projectSettingsMinMaxFormatters({int? maxValue}) =>
      <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
        RangeInputFormatter(min: 0, max:maxValue?? 9),
      ];

  /// project name formatter
  List<TextInputFormatter>? zoneSiteNameFormatters = <TextInputFormatter>[
    ///restrict emoji's
    EmojiFilteringTextInputFormatter(),

    /// Restrict leading white space only
    LeadingSpaceTextInputFormatter(),

    /// allow only alphabets
    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9 _-]')),
  ];

  /// project name formatter
  List<TextInputFormatter>? roleNameFormatters = <TextInputFormatter>[
    ///restrict emoji's
    EmojiFilteringTextInputFormatter(),

    /// Restrict leading white space only
    LeadingSpaceTextInputFormatter(),

    /// allow only alphabets
    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z _-]')),
  ];
  /// project name formatter
  List<TextInputFormatter>? projectNameFormatters = <TextInputFormatter>[
    ///restrict emoji's
    EmojiFilteringTextInputFormatter(),

    /// Restrict leading white space only
    LeadingSpaceTextInputFormatter(),

    /// allow only alphabets
    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9 _-]')),
  ];

  /// email field validator
  List<TextInputFormatter>? inputEmailFormatters = <TextInputFormatter>[
    ///restrict emoji's
    EmojiFilteringTextInputFormatter(),

    /// restrict white spaces
    FilteringTextInputFormatter.deny(RegExp(r'\s')),

    /// allow only alphabets
    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9.@ ]')),
  ];

  /// common field validator
  List<TextInputFormatter>? organizationTextFormatters = <TextInputFormatter>[
    ///restrict emoji's
    EmojiFilteringTextInputFormatter(),

    /// Restrict leading white space only
    LeadingSpaceTextInputFormatter(),

    /// allow  alphabets, numbers and all
    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z1-9-&'.]")),
  ];

  /// common field validator
  List<TextInputFormatter>? inputTextFormatters = <TextInputFormatter>[
    ///restrict emoji's
    EmojiFilteringTextInputFormatter(),

    /// Restrict leading white space only
    LeadingSpaceTextInputFormatter(),

    /// allow only alphabets
    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
  ];

  /// password field validator
  List<TextInputFormatter>? inputPasswordFormatters = <TextInputFormatter>[
    ///restrict emoji's
    EmojiFilteringTextInputFormatter(),

    /// Restrict leading white space only
    LeadingSpaceTextInputFormatter(),
  ];

  /// mobile number field validator
  List<TextInputFormatter>? inputMobileNumberFormatters = <TextInputFormatter>[
    ///restrict emoji's
    EmojiFilteringTextInputFormatter(),

    /// Restrict leading white space only
    LeadingSpaceTextInputFormatter(),

    /// allow only numbers
    FilteringTextInputFormatter.allow(RegExp('[1-9]')),
  ];
}

/// Only matches emojis and emoji symbols, not all non-ASCII
class EmojiFilteringTextInputFormatter extends TextInputFormatter {
  /// Only matches emojis and emoji symbols, not all non-ASCII
  static final RegExp _emojiRegExp = RegExp(
    r'[\u{1F1E6}-\u{1F1FF}]|' // Flags
    r'[\u{1F300}-\u{1F5FF}]|' // Misc Symbols and Pictographs
    r'[\u{1F600}-\u{1F64F}]|' // Emoticons
    r'[\u{1F680}-\u{1F6FF}]|' // Transport and Map
    r'[\u{1F700}-\u{1F77F}]|' // Alchemical Symbols
    r'[\u{1F780}-\u{1F7FF}]|' // Geometric Shapes Extended
    r'[\u{1F800}-\u{1F8FF}]|' // Supplemental Arrows-C
    r'[\u{1F900}-\u{1F9FF}]|' // Supplemental Symbols and Pictographs
    r'[\u{1FA00}-\u{1FAFF}]|' // Chess Symbols + Extended-A (🫷🫸 here!)
    r'[\u{2600}-\u{26FF}]|' // Misc symbols
    r'[\u{2700}-\u{27BF}]|' // Dingbats
    r'[\u{FE00}-\u{FE0F}]|' // Variation Selectors
    // r'[`'"”’“‘]',
    r'[\u00a9\u00ae]', // © ®
    unicode: true,
  );

  @override
  /// Overrides the method to modify the text input during editing.
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    /// Checks if the new input text contains any emoji or non-ASCII character.
    /// If yes, revert to the previous valid input (oldValue).
    if (_emojiRegExp.hasMatch(newValue.text)) {
      return oldValue;
    }

    /// If no emoji found, allow the new input text as it is.
    return newValue;
  }
}

/// leading text input clas
class LeadingSpaceTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // If the first character is a space, remove it
    if (newValue.text.startsWith(' ')) {
      final String newText = newValue.text.replaceFirst(RegExp('^ +'), '');
      final int offset =
          newValue.selection.baseOffset -
          (newValue.text.length - newText.length);
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: offset.clamp(0, newText.length),
        ),
      );
    }
    return newValue;
  }
}

class RangeInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  RangeInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;

    // Allow empty string to let user delete input
    if (text.isEmpty) {
      return newValue;
    }

    final value = int.tryParse(text);

    if (value == null || value < min || value > max) {
      return oldValue;
    }

    return newValue;
  }
}


class DecimalRangeInputFormatter extends TextInputFormatter {
  final double min;
  final double max;

  DecimalRangeInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String text = newValue.text;

    // Allow empty input for deletion
    if (text.isEmpty) return newValue;

    // Normalize input: if starts with '.', prefix with '0'
    if (text.startsWith('.')) {
      text = '0$text';
    }

    // Regex: up to 2 digits before decimal, optional 1 digit after
    final regex = RegExp(r'^\d{0,2}(\.\d{0,1})?$');
    if (!regex.hasMatch(text)) {
      return oldValue;
    }

    final value = double.tryParse(text);
    if (value == null || value < min || value > max) {
      return oldValue;
    }

    // Return updated text with cursor at the end
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
