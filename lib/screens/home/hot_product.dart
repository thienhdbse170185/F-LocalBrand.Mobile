import 'package:f_localbrand/features/product/bloc/product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotProduct extends StatefulWidget {
  const HotProduct({super.key});

  @override
  State<HotProduct> createState() => _HotProductState();
}

class _HotProductState extends State<HotProduct> {
  String _selectedCategory = 'Newest';

  void _onCategoryPressed(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductCubit>().fetchProducts(_selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final categories = ['Newest', 'Popular', 'Collection'];
    return Center(
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: OutlinedButton(
                onPressed: () => _onCategoryPressed(category),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: _selectedCategory == category
                        ? colorScheme.primary
                        : Colors.grey,
                  ),
                  backgroundColor: _selectedCategory == category
                      ? colorScheme.primary.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: Text(
                  category,
                  style: textTheme.displayMedium?.copyWith(
                    color: _selectedCategory == category
                        ? colorScheme.primary
                        : Colors.black,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
