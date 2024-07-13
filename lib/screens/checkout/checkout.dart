import 'package:f_localbrand/screens/checkout/components/checkout_info.dart';
import 'package:f_localbrand/screens/checkout/components/checkout_item.dart';
import 'package:f_localbrand/screens/widgets/appbars/custom_appbar.dart';
import 'package:f_localbrand/screens/widgets/buttons/back_button.dart';
import 'package:f_localbrand/screens/widgets/list/vertical_sliver_list.dart';
import 'package:flutter/material.dart';

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

class CheckoutScreen extends StatelessWidget {
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
                // CheckoutInformation(
                //     title: 'Choose Shipping Type',
                //     headline: 'Economy',
                //     description: 'Estimated Arrival 25 Auguest 2023'),
                // Divider(height: 48.0),
                Text(
                  'Order List',
                  style: textTheme.headlineMedium,
                ),
                VerticalSliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Column(
                      children: [
                        OrderItem(
                          imageUrl: 'assets/images/shirt_demo.png',
                          title: 'Brown Jacket',
                          size: 'XL',
                          price: 83.97,
                        ),
                        Divider(
                          height: 20,
                          thickness: 1,
                        ),
                        OrderItem(
                          imageUrl: 'assets/images/shirt_demo.png',
                          title: 'Brown Suite',
                          size: 'XL',
                          price: 120.0,
                        ),
                        Divider(
                          height: 20,
                          thickness: 1,
                        ),
                        OrderItem(
                          imageUrl: 'assets/images/shirt_demo.png',
                          title: 'Brown Jacket',
                          size: 'XL',
                          price: 83.97,
                        ),
                        Divider(
                          height: 20,
                          thickness: 1,
                        ),
                      ],
                    );
                  }),
                  height: 700,
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
            // Handle continue to payment action
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
