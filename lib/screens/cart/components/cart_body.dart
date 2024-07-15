import 'package:f_localbrand/features/cart/dto/cart_dto.dart';
import 'package:f_localbrand/features/cart/dto/cart_product_dto.dart';
import 'package:flutter/material.dart';
import 'package:f_localbrand/screens/cart/components/cart_summary.dart';
import 'package:f_localbrand/screens/cart/widgets/cart_item.dart';

class CartBody extends StatefulWidget {
  List<ProductCartDto> items;
  CartBody({required this.items});
  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 480,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = widget.items[index];
                return CartItem(
                    imageUrl: 'https://via.placeholder.com/150',
                    title: item.name,
                    size: 'XL',
                    price: item.price,
                    quantity: item.quantity);
              },
              childCount: widget.items.length,
            ),
          ),
        ],
      ),
    );
  }
}
