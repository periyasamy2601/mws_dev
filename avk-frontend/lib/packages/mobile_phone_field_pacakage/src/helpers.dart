import 'package:avk/packages/mobile_phone_field_pacakage/src/countries.dart';

/// check is numeric
bool isNumeric(String s) => s.isNotEmpty && int.tryParse(s.replaceAll('+', '')) != null;

/// remove diacritics
String removeDiacritics(String str) {
  String withDia = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
  String withoutDia = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';
  String newStr = str;
  for (int i = 0; i < withDia.length; i++) {
    newStr = newStr.replaceAll(withDia[i], withoutDia[i]);
  }

  return newStr;
}

/// country extension
extension CountryExtensions on List<Country> {
  /// search extension
  List<Country> stringSearch(String search) {
    String cleanSearch = removeDiacritics(search.toLowerCase());
    return where(
          (Country country) => isNumeric(cleanSearch) || cleanSearch.startsWith('+')
          ? country.dialCode.contains(cleanSearch)
          : removeDiacritics(country.name.replaceAll('+', '').toLowerCase()).contains(cleanSearch) ||
          country.nameTranslations.values
              .any((String element) => removeDiacritics(element.toLowerCase()).contains(cleanSearch)),
    ).toList();
  }
}
