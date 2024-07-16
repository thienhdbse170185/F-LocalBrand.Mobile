import 'package:f_localbrand/config/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty_cart.png',
            height: 240,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 30),
            child: Text('Your cart is empty',
                style: Theme.of(context).textTheme.displayMedium),
          ),
          ElevatedButton(
            onPressed: () {
              context.push(RouteName.home);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 70, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(90),
              ),
            ),
            child: Text('SHOP NOW',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.white)),
          )
        ],
      ),
    );
  }
}
