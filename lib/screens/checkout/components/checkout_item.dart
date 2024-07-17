import 'package:f_localbrand/util/price_util.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String size;
  final String price;
  final int? quantity;
  final double? totalPrice;

  const OrderItem(
      {required this.imageUrl,
      required this.title,
      required this.size,
      required this.price,
      this.quantity,
      this.totalPrice});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 16),
      child: Row(
        children: [
          Image.asset(
            imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: textTheme.headlineSmall),
                    Text('Qty: $quantity')
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Size: $size',
                      style: textTheme.displaySmall
                          ?.copyWith(fontSize: 14, color: colorScheme.outline),
                    ),
                    Text('Price: $price')
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                if (totalPrice != null)
                  Text(
                    PriceUtil.formatPrice(totalPrice!.toInt()),
                    style: textTheme.headlineSmall,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
