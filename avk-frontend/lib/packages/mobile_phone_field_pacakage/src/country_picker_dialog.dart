import 'package:avk/packages/mobile_phone_field_pacakage/src/countries.dart';
import 'package:avk/packages/mobile_phone_field_pacakage/src/helpers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A style configuration class for customizing the appearance
/// of the `CountryPickerDialog`.
///
/// This allows you to control colors, text styles, padding,
/// and whether certain elements (like flags) are displayed.
class PickerDialogStyle {
  /// Creates a [PickerDialogStyle] instance with optional customization.
  ///
  /// If not provided, default widget or theme values will be used.
  PickerDialogStyle({
    this.backgroundColor,
    this.countryCodeStyle,
    this.countryNameStyle,
    this.listTileDivider,
    this.listTilePadding,
    this.padding,
    this.searchFieldCursorColor,
    this.searchFieldInputDecoration,
    this.searchFieldPadding,
    this.width,
    this.height,
    this.showFlagIcon = true,
  });

  /// Background color of the dialog container.
  final Color? backgroundColor;

  /// Text style for the country dial code (e.g., `+1`, `+91`).
  final TextStyle? countryCodeStyle;

  /// Text style for the country name.
  final TextStyle? countryNameStyle;

  /// Divider widget between each country list tile.
  final Widget? listTileDivider;

  /// Padding inside each country list tile.
  final EdgeInsets? listTilePadding;

  /// Padding around the entire dialog content.
  final EdgeInsets? padding;

  /// Cursor color for the search text field.
  final Color? searchFieldCursorColor;

  /// Input decoration for the search text field.
  final InputDecoration? searchFieldInputDecoration;

  /// Padding around the search text field.
  final EdgeInsets? searchFieldPadding;

  /// Custom dialog width.
  final double? width;

  /// Custom dialog height.
  final double? height;

  /// Whether to show the flag icon next to each country.
  final bool showFlagIcon;
}

/// A dialog widget that allows users to pick a country from a list.
///
/// Displays a searchable list of countries and highlights the currently selected country.
/// Supports localization via [languageCode] and optional styling through [PickerDialogStyle].
class CountryPickerDialog extends StatefulWidget {
  /// Creates a [CountryPickerDialog].
  ///
  /// [countryList], [selectedCountry], [onCountryChanged],
  /// [searchText], [languageCode], and [filteredCountries] are required.
  const CountryPickerDialog({
    required this.searchText,
    required this.languageCode,
    required this.countryList,
    required this.onCountryChanged,
    required this.selectedCountry,
    required this.filteredCountries,
    super.key,
    this.style,
  });

  /// Full list of available countries to choose from.
  final List<Country> countryList;

  /// The country that is currently selected.
  final Country selectedCountry;

  /// Callback triggered when a user selects a different country.
  final ValueChanged<Country> onCountryChanged;

  /// Search query entered by the user to filter countries.
  final String searchText;

  /// List of countries filtered based on [searchText].
  final List<Country> filteredCountries;

  /// Optional style configuration for customizing the dialog's appearance.
  final PickerDialogStyle? style;

  /// Language code used for displaying localized country names.
  final String languageCode;

  @override
  State<CountryPickerDialog> createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<CountryPickerDialog> {
  late List<Country> _filteredCountries;
  late Country _selectedCountry;

  @override
  void initState() {
    _selectedCountry = widget.selectedCountry;
    _filteredCountries = widget.filteredCountries.toList()
      ..sort(
        (Country a, Country b) => a
            .localizedName(widget.languageCode)
            .compareTo(b.localizedName(widget.languageCode)),
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: widget.style?.backgroundColor ?? Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: widget.style?.width,
        height:
            widget.style?.height ?? MediaQuery.of(context).size.height * 0.9,
        padding: widget.style?.padding ?? const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  widget.style?.searchFieldPadding ?? EdgeInsets.zero,
              child: TextField(
                cursorColor: widget.style?.searchFieldCursorColor,
                decoration:
                    widget.style?.searchFieldInputDecoration ??
                    InputDecoration(
                      suffixIcon: const Icon(Icons.search),
                      labelText: widget.searchText,
                    ),
                onChanged: (String value) {
                  _filteredCountries = widget.countryList.stringSearch(value)
                    ..sort(
                      (Country a, Country b) => a
                          .localizedName(widget.languageCode)
                          .compareTo(b.localizedName(widget.languageCode)),
                    );
                  if (mounted) {
                    setState(() {});
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredCountries.length,
                itemBuilder: (BuildContext ctx, int index) => Column(
                  children: <Widget>[
                    ListTile(
                      leading: (widget.style?.showFlagIcon ?? true)
                          ? kIsWeb
                                ? Image.asset(
                                    'assets/flags/${_filteredCountries[index].code.toLowerCase()}.png',
                                    package: 'mws_phone_field',
                                    width: 32,
                                  )
                                : Text(
                                    _filteredCountries[index].flag,
                                    style: const TextStyle(fontSize: 18),
                                  )
                          : null,
                      contentPadding: widget.style?.listTilePadding,
                      title: Text(
                        _filteredCountries[index].localizedName(
                          widget.languageCode,
                        ),
                        style:
                            widget.style?.countryNameStyle ??
                            const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      trailing: Text(
                        '+${_filteredCountries[index].dialCode}',
                        style:
                            widget.style?.countryCodeStyle ??
                            const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      onTap: () {
                        _selectedCountry = _filteredCountries[index];
                        widget.onCountryChanged(_selectedCountry);
                        Navigator.of(context).pop();
                      },
                    ),
                    widget.style?.listTileDivider ??
                        const Divider(thickness: 1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
