import 'package:f_localbrand/features/product/dto/product_home_dto.dart';
import 'package:f_localbrand/screens/home/widgets/product_home.dart';
import 'package:f_localbrand/screens/widgets/list/category_list.dart';
import 'package:f_localbrand/screens/widgets/list/vertical_grid_list.dart';
import 'package:f_localbrand/screens/widgets/screens/empty_screen.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen(
      {super.key, required this.textTheme, required this.colorScheme});

  final TextTheme textTheme;
  final ColorScheme colorScheme;

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final categories = ['Newest', 'Best-seller', 'Collection'];
  String _selectedCategory = 'Newest';

  List<ProductHomeDto> _productFavourites = [
    // ProductHomeDto(id: 1, name: "Home Shirt", price: 100),
    // ProductHomeDto(id: 2, name: "Home Shirt", price: 100),
    // ProductHomeDto(id: 3, name: "Home Shirt", price: 100),
    // ProductHomeDto(id: 4, name: "Home Shirt", price: 100),
    // ProductHomeDto(id: 5, name: "Home Shirt", price: 100),
    // ProductHomeDto(id: 6, name: "Home Shirt", price: 100),
    // ProductHomeDto(id: 7, name: "Home Shirt", price: 100),
    // ProductHomeDto(id: 8, name: "Home Shirt", price: 100),
  ];

  void _onCategoryPressed(String category) {
    setState(() {
      _selectedCategory = category;
      // context.read<ProductCubit>().fetchProducts(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('My Favourite', style: widget.textTheme?.headlineSmall),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.only(top: 20, left: 15, right: 15),
          child: Column(
            children: [
              if (_productFavourites.isNotEmpty) ...[
                CategoryList(
                  colorScheme: widget.colorScheme,
                  textTheme: widget.textTheme,
                  categories: categories,
                  selectedCategory: _selectedCategory,
                  onCategoryPressed: _onCategoryPressed,
                ),
                // VerticalGridList(
                //     height: 800,
                //     delegate: SliverChildBuilderDelegate(
                //       (context, index) {
                //         final product = _productFavourites[index];
                //         return ProductHome(product: product);
                //       },
                //       childCount: _productFavourites.length,
                //     ))
              ] else
                EmptyScreen(
                  asset: 'assets/images/empty_favourite.png',
                  title: 'Your favourite list is empty',
                )
            ],
          ),
        ));
  }
}
