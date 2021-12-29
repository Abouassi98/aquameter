// ignore_for_file: file_names

import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';

class CustomCountryCodePicker extends StatelessWidget {
  final void Function(Country) onChange;

  const CustomCountryCodePicker({Key? key, required this.onChange})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CountryPickerDropdown(
      iconSize: 5,
      itemFilter: (c) => [
        'EG',
      ].contains(c.isoCode),
      initialValue: 'EG',
      itemBuilder: _buildDropdownItem,
      sortComparator: (Country a, Country b) => a.isoCode.compareTo(b.isoCode),
      onValuePicked: onChange,
    );
  }

  Widget _buildDropdownItem(Country country) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: <Widget>[
            const VerticalDivider(
              thickness: 2,
            ),
            Text(
              '+${country.phoneCode}(${country.isoCode})',
              style: const TextStyle(fontSize: 10),
            ),
            const SizedBox(
              width: 4.0,
            ),
            CountryPickerUtils.getDefaultFlagImage(country),
          ],
        ),
      );
}
