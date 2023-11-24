import 'package:flutter/material.dart';
import 'package:flutter_challenge/src/pages/dashboard_page/view/widgets/fade_in_from_left_widget.dart';

/// A custom widget that combines a text field with a dropdown menu.
class TextFieldWithDropdown extends StatelessWidget {
  /// The hint text displayed in the text field and dropdown.
  final String hintText;

  /// The current value of the dropdown.
  final String? currentValue;

  /// List of items for the dropdown menu.
  final List<String> items;

  /// Callback function triggered when the dropdown value changes.
  final void Function(String?) onChanged;

  /// Determines the visibility of the widget. Defaults to true.
  final bool visible;

  /// Constructs a [TextFieldWithDropdown] widget.
  const TextFieldWithDropdown({
    super.key,
    required this.hintText,
    required this.currentValue,
    required this.items,
    required this.onChanged,
    this.visible = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) return Container();
    return SlideInFromLeft(
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: hintText,
          labelText: hintText,
        ),
        isEmpty: currentValue == null || currentValue!.isEmpty,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: currentValue,
            isDense: true,
            isExpanded: true,
            onChanged: onChanged,
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
