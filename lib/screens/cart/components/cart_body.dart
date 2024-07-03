import 'package:flutter/material.dart';
import 'package:f_localbrand/screens/cart/components/cart_summary.dart';
import 'package:f_localbrand/screens/cart/widgets/cart_item.dart';

class CartBody extends StatefulWidget {
  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  List<Map<String, dynamic>> items = [];
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMoreItems();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoading) {
        _loadMoreItems();
      }
    });
  }

  Future<void> _loadMoreItems() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2)); // Simulate network delay

    List<Map<String, dynamic>> newItems = List.generate(
        2,
        (index) => {
              'imageUrl': 'https://via.placeholder.com/150',
              'title': 'Brown Jacket',
              'size': 'XL',
              'price': 83.97,
              'quantity': 1,
            });

    setState(() {
      items.addAll(newItems);
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 410,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == items.length) {
                  return _buildLoadingIndicator();
                }
                final item = items[index];
                return CartItem(
                    imageUrl: item['imageUrl'],
                    title: item['title'],
                    size: item['size'],
                    price: item['price'],
                    quantity: item['quantity']);
              },
              childCount: items.length + (isLoading ? 1 : 0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
