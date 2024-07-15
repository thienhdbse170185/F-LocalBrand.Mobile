import 'package:f_localbrand/features/product/bloc/product_cubit.dart';
import 'package:f_localbrand/features/product/dto/product_home_dto.dart';
import 'package:f_localbrand/screens/home/widgets/product_home.dart';
import 'package:f_localbrand/screens/widgets/list/category_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotProduct extends StatefulWidget {
  const HotProduct({super.key});

  @override
  State<HotProduct> createState() => _HotProductState();
}

class _HotProductState extends State<HotProduct> {
  String _selectedCategory = 'Newest';
  List<ProductHomeDto> _products = [
    ProductHomeDto(id: 1, name: "Home Shirt", price: 100),
    ProductHomeDto(id: 2, name: "Home Shirt", price: 100),
    ProductHomeDto(id: 3, name: "Home Shirt", price: 100),
    ProductHomeDto(id: 4, name: "Home Shirt", price: 100),
  ];

  void _onCategoryPressed(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final categories = ['Newest', 'Best-seller', 'Collection'];

    return Column(
      children: [
        Center(
          child: CategoryList(
              colorScheme: colorScheme,
              textTheme: textTheme,
              categories: categories,
              selectedCategory: _selectedCategory,
              onCategoryPressed: _onCategoryPressed),
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 30.0),
        //   child: Container(
        //     height: 500, // Fixed height
        //     child: GridView.builder(
        //       physics:
        //           NeverScrollableScrollPhysics(), // Disable GridView scrolling
        //       itemCount: _products.length,
        //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 2,
        //         crossAxisSpacing: 8.0,
        //         mainAxisSpacing: 8.0,
        //         childAspectRatio: 0.75,
        //       ),
        //       itemBuilder: (context, index) {
        //         final product = _products[index];
        //         return ProductHome(
        //           product: product,
        //         );
        //       },
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
