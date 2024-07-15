import 'package:f_localbrand/features/cart/cubit/cart_cubit.dart';
import 'package:f_localbrand/features/cart/dto/cart_dto.dart';
import 'package:f_localbrand/screens/cart/components/cart_body.dart';
import 'package:f_localbrand/screens/cart/components/cart_empty.dart';
import 'package:f_localbrand/screens/cart/components/cart_summary.dart';
import 'package:f_localbrand/screens/widgets/appbars/custom_appbar.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartLoaded) {
            if (state.cart == null) {
              return CartEmpty();
            }
            return Container(
              padding: EdgeInsets.only(top: 20, left: 8, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppbar(title: 'My cart', textTheme: textTheme),
                  Padding(
                    padding: EdgeInsets.only(left: 20, bottom: 10),
                    child: Text(
                      'Item List',
                      style: textTheme.displayMedium,
                    ),
                  ),
                  CartBody(
                    items: state.cart!.items,
                  ),
                  CartSummary(
                    priceTotal: state.cart!.totalCartValue,
                  ),
                  // CartEmpty()
                ],
              ),
            );
          } else {
            return Text('Something error in here...Oops!');
          }
        },
      ),
    );
  }
}
