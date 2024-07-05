import 'dart:math';

import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  const CategoryList(
      {super.key,
      required this.colorScheme,
      required this.textTheme,
      required this.categories,
      required this.selectedCategory,
      required this.onCategoryPressed});

  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategoryPressed;

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverList(
              key: UniqueKey(),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final category = widget.categories[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: OutlinedButton(
                      onPressed: () => widget.onCategoryPressed(category),
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: widget.selectedCategory == category
                                ? widget.colorScheme.primary
                                : Colors.grey,
                          ),
                          backgroundColor: widget.selectedCategory == category
                              ? widget.colorScheme.primary.withOpacity(0.1)
                              : Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100))),
                      child: Text(
                        category,
                        style: widget.textTheme.displayMedium?.copyWith(
                          color: widget.selectedCategory == category
                              ? widget.colorScheme.primary
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
                childCount: widget.categories.length,
              ))
        ],
      ),
    );
  }
}
