import 'package:f_localbrand/config/router.dart';
import 'package:f_localbrand/util/price_util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CartSummary extends StatefulWidget {
  double priceTotal;
  CartSummary({required this.priceTotal});
  @override
  State<CartSummary> createState() => _CartSummaryState();
}

class _CartSummaryState extends State<CartSummary> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    Future<void> _onSubmitCheckout() async {
      context.push(RouteName.checkout);
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 10.0),
          ],
          borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text('Sub-Total'),
          //     Text('\$407.94'),
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text('Delivery Fee'),
          //     Text('\$25.00'),
          //   ],
          // ),
          // Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Cost', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(PriceUtil.formatPrice(widget.priceTotal.toInt()),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: ElevatedButton(
                onPressed: () {
                  _onSubmitCheckout();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 64, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  elevation: 4,
                  shadowColor: Colors.grey,
                ),
                child: Text(
                  'Proceed to Checkout',
                  style: textTheme.displaySmall?.copyWith(color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }
}
