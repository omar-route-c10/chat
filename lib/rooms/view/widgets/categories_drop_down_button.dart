import 'package:chat/rooms/data/models/category_model.dart';
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
  String? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    final bodySmallStyle = Theme.of(context).textTheme.bodySmall;
    return DropdownButtonFormField(
      value: selectedCategoryId,
      hint: Text(
        'Select Room Category',
        style: bodySmallStyle?.copyWith(
          color: AppTheme.greyColor,
          fontWeight: FontWeight.w400,
        ),
      ),
      items: CategoryModel.categories
          .map(
            (category) => DropdownMenuItem(
              value: category.id,
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/${category.imageName}.png',
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    category.name,
                    style: bodySmallStyle?.copyWith(fontSize: 20),
                  ),
                ],
              ),
            ),
          )
          .toList(),
      onChanged: (categoryId) => setState(
        () {
          selectedCategoryId = categoryId;
          widget.onCategorySelected(selectedCategoryId);
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
