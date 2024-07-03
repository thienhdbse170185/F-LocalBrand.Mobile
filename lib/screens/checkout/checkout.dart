import 'package:f_localbrand/screens/checkout/components/checkout_info.dart';
import 'package:f_localbrand/screens/checkout/components/checkout_item.dart';
import 'package:f_localbrand/screens/widgets/buttons/back_button.dart';
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
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text(
          'Checkout',
          style: textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 25, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CheckoutInformation(
                title: 'Shipping Address',
                headline: 'Home',
                description: '1901 Thornridge Cir. Shiloh, Hawaii 81063'),
            Divider(height: 48.0),
            CheckoutInformation(
                title: 'Choose Shipping Type',
                headline: 'Economy',
                description: 'Estimated Arrival 25 Auguest 2023'),
            Divider(height: 48.0),
            Text(
              'Order List',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Container(
              height: 270.0, // Adjust the height as needed
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      OrderItem(
                        imageUrl: 'assets/images/shirt_demo.png',
                        title: 'Brown Jacket',
                        size: 'XL',
                        price: 83.97,
                      ),
                      OrderItem(
                        imageUrl: 'assets/images/shirt_demo.png',
                        title: 'Brown Suite',
                        size: 'XL',
                        price: 120.0,
                      ),
                      OrderItem(
                        imageUrl: 'assets/images/shirt_demo.png',
                        title: 'Brown Jacket',
                        size: 'XL',
                        price: 83.97,
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
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
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
