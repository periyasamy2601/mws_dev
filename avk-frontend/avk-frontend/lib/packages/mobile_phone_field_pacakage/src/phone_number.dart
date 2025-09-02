import 'package:avk/packages/mobile_phone_field_pacakage/src/countries.dart';

/// Exception thrown when the phone number is longer than the allowed maximum length.
class NumberTooLongException implements Exception {}

/// Exception thrown when the phone number is shorter than the allowed minimum length.
class NumberTooShortException implements Exception {}

/// Exception thrown when the phone number contains invalid characters (non-numeric, except '+').
class InvalidCharactersException implements Exception {}

/// Represents a phone number with its country information.
class PhoneNumber {

  /// constructor
  PhoneNumber({
    required this.countryISOCode,
    required this.countryCode,
    required this.number,
  });

  /// Factory constructor to create a [PhoneNumber] object from a complete phone number string.
  /// Example: `+919876543210` → country code: "+91", number: "9876543210".
  factory PhoneNumber.fromCompleteNumber({required String completeNumber}) {
    if (completeNumber == '') {
      // Empty input → return an empty PhoneNumber instance
      return PhoneNumber(countryISOCode: '', countryCode: '', number: '');
    }

    try {
      // Determine the country from the complete number
      Country country = getCountry(completeNumber);

      String number;

      // Remove '+' if present and extract only the local number part
      if (completeNumber.startsWith('+')) {
        number = completeNumber.substring(
          1 + country.dialCode.length + country.regionCode.length,
        );
      } else {
        number = completeNumber.substring(
          country.dialCode.length + country.regionCode.length,
        );
      }

      return PhoneNumber(
        countryISOCode: country.code,
        countryCode: country.dialCode + country.regionCode,
        number: number,
      );
    } on InvalidCharactersException {
      // Re-throw if characters are invalid
      rethrow;
    } on Exception {
      // Any other error → return empty PhoneNumber
      return PhoneNumber(countryISOCode: '', countryCode: '', number: '');
    }
  }
  /// ISO country code (e.g., "US", "IN")
  String countryISOCode;

  /// Country dialing code (including region code if applicable), e.g., "+91", "+1 876"
  String countryCode;

  /// Local phone number (without the country/region code)
  String number;

  /// Validates the number length based on the country rules.
  /// Throws:
  /// - [NumberTooShortException] if number is too short
  /// - [NumberTooLongException] if number is too long
  bool isValidNumber() {
    Country country = getCountry(completeNumber);

    if (number.length < country.minLength) {
      throw NumberTooShortException();
    }
    if (number.length > country.maxLength) {
      throw NumberTooLongException();
    }
    return true;
  }

  /// Returns the complete number (country code + local number).
  String get completeNumber {
    return countryCode + number;
  }

  /// Determines the [Country] object based on the given phone number.
  /// Throws:
  /// - [NumberTooShortException] if input is empty
  /// - [InvalidCharactersException] if input contains invalid characters
  static Country getCountry(String phoneNumber) {
    if (phoneNumber == '') {
      throw NumberTooShortException();
    }

    // Allow only digits and '+' at the start
    final RegExp validPhoneNumber = RegExp(r'^[+0-9]*[0-9]*$');

    if (!validPhoneNumber.hasMatch(phoneNumber)) {
      throw InvalidCharactersException();
    }

    // If number starts with '+', match against country codes without '+'
    if (phoneNumber.startsWith('+')) {
      return countries.firstWhere(
            (Country country) =>
            phoneNumber.substring(1).startsWith(
              country.dialCode + country.regionCode,
            ),
      );
    }

    // If no '+', match directly
    return countries.firstWhere(
          (Country country) =>
          phoneNumber.startsWith(country.dialCode + country.regionCode),
    );
  }

  /// Returns a string representation for debugging.
  @override
  String toString() =>
      'PhoneNumber(countryISOCode: $countryISOCode, countryCode: $countryCode, number: $number)';
}
