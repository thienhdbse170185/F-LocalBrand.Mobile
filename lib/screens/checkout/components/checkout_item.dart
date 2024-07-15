import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String size;
  final String price;

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
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Size: $size',
                  style: textTheme.displaySmall
                      ?.copyWith(fontSize: 14, color: colorScheme.outline),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Price: $price',
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
