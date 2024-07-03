import 'package:f_localbrand/features/cart/bloc/cubit/cart_cubit.dart';
import 'package:f_localbrand/screens/cart/components/cart_body.dart';
import 'package:f_localbrand/screens/cart/components/cart_empty.dart';
import 'package:f_localbrand/screens/cart/components/cart_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getCart();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
        if (state is CartLoading) {
          return CircularProgressIndicator();
        } else if (state is CartLoaded) {
          return Container(
            padding: EdgeInsets.only(top: 20, left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    'Item List',
                    style: textTheme.displayMedium,
                  ),
                ),
                CartBody(),
                CartSummary(),
                // CartEmpty()
              ],
            ),
          );
        } else if (state is CartIsEmpty) {
          return CartEmpty();
        } else {
          return Text('Something error in here...Oops!');
        }
      }),
    );
  }
}
