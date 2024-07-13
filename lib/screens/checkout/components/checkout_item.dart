import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String size;
  final double price;

  const OrderItem({
    required this.imageUrl,
    required this.title,
    required this.size,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                Text(title, style: textTheme.displayMedium),
                Text(
                  'Size: $size',
                  style: textTheme.displaySmall
                      ?.copyWith(fontSize: 14, color: colorScheme.outline),
                ),
                Text(
                  '\$$price',
                  style: textTheme.displayMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
