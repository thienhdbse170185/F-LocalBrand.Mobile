import 'package:f_localbrand/features/product/dto/product_home_dto.dart';
import 'package:f_localbrand/screens/home/widgets/product_home.dart';
import 'package:f_localbrand/screens/widgets/list/vertical_grid_list.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.category});
  final String category;
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<ProductHomeDto> _products = [];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(
          widget.category,
          style: textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          VerticalGridList(
            delegate: SliverChildBuilderDelegate((context, index) {
              ProductHomeDto product = _products[index];
              return ProductHome(product: product);
            }),
            key: UniqueKey(),
          )
        ],
      ),
    );
  }
}
