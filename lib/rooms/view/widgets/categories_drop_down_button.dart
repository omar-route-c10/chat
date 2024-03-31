import 'package:chat/shared/app_theme.dart';
import 'package:flutter/material.dart';

class CategoriesDropDownButton extends StatefulWidget {
  final void Function(String?) onCategorySelected;

  CategoriesDropDownButton({required this.onCategorySelected});

  @override
  State<CategoriesDropDownButton> createState() =>
      _CategoriesDropDownButtonState();
}

class _CategoriesDropDownButtonState extends State<CategoriesDropDownButton> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final bodySmallStyle = Theme.of(context).textTheme.bodySmall;
    return DropdownButtonFormField(
      value: selectedCategory,
      hint: Text(
        'Select Room Category',
        style: bodySmallStyle?.copyWith(
          color: AppTheme.greyColor,
          fontWeight: FontWeight.w400,
        ),
      ),
      items: ['Sports', 'Movies', 'Music']
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(
                category,
                style: bodySmallStyle?.copyWith(fontSize: 20),
              ),
            ),
          )
          .toList(),
      onChanged: (category) => setState(
        () {
          selectedCategory = category;
          widget.onCategorySelected(selectedCategory);
        },
      ),
      isExpanded: true,
      validator: (value) {
        if (value == null) {
          return 'Category is required';
        }
        return null;
      },
    );
  }
}
