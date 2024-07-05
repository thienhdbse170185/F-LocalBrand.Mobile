import 'package:f_localbrand/screens/widgets/list/category_list.dart';
import 'package:flutter/material.dart';

class FilterHorizontalItem extends StatelessWidget {
  const FilterHorizontalItem({
    super.key,
    required this.title,
    required this.categories,
    required this.selectedCategory,
    required this.onCategoryPressed,
  });

  final String title;
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategoryPressed;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textTheme.headlineSmall?.copyWith(fontSize: 16)),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: CategoryList(
              colorScheme: colorScheme,
              textTheme: textTheme,
              categories: categories,
              selectedCategory: selectedCategory,
              onCategoryPressed: onCategoryPressed,
            ),
          ),
        ],
      ),
    );
  }
}
