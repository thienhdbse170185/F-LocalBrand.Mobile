import 'package:f_localbrand/features/cart/cubit/cart_cubit.dart';
import 'package:f_localbrand/features/cart/dto/cart_product_dto.dart';
import 'package:f_localbrand/features/order/bloc/cubit/order_cubit.dart';
import 'package:f_localbrand/screens/checkout/components/checkout_info.dart';
import 'package:f_localbrand/screens/checkout/components/checkout_item.dart';
import 'package:f_localbrand/screens/widgets/appbars/custom_appbar.dart';
import 'package:f_localbrand/screens/widgets/buttons/back_button.dart';
import 'package:f_localbrand/screens/widgets/list/vertical_sliver_list.dart';
import 'package:f_localbrand/util/price_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CheckoutScreen(),
    );
  }
}

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List<ProductCartDto> _cartItems = [];

  @override
  void initState() {
    super.initState();
    // Load the cart items when the screen is initialized
    context.read<CartCubit>().fetchCart();
  }

  void _onPressedPayment() {
    context.read<OrderCubit>().addOrder(_cartItems);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Column(
        children: [
          CustomAppbar(title: 'Checkout', textTheme: textTheme),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckoutInformation(
                    title: 'Shipping Address',
                    headline: 'Home',
                    description: '1901 Thornridge Cir. Shiloh, Hawaii 81063'),
                Divider(height: 48.0),
                Text(
                  'Order List',
                  style: textTheme.headlineMedium,
                ),
                BlocListener<CartCubit, CartState>(
                  listener: (context, state) {
                    if (state is CartLoaded) {
                      setState(() {
                        _cartItems = state.cart?.items ?? [];
                      });
                    }
                  },
                  child: _cartItems.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : VerticalSliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final item = _cartItems[index];
                              return Column(
                                children: [
                                  OrderItem(
                                    imageUrl: 'assets/images/shirt_demo.png',
                                    title: item.name,
                                    size: 'XL',
                                    price: PriceUtil.formatPrice(
                                        item.price.toInt()),
                                  ),
                                  Divider(
                                    height: 20,
                                    thickness: 1,
                                  ),
                                ],
                              );
                            },
                            childCount: _cartItems.length,
                          ),
                          height: 700,
                        ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            _onPressedPayment();
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
          ),
          child: Text(
            'Continue to Payment',
            style: textTheme.headlineSmall?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
