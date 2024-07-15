import 'package:f_localbrand/config/router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class OrderStatusItem extends StatefulWidget {
  const OrderStatusItem({super.key});

  @override
  State<OrderStatusItem> createState() => _OrderStatusItemState();
}

class _OrderStatusItemState extends State<OrderStatusItem> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.box,
            size: 88,
            color: colorScheme.primary,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order #1',
                  style: textTheme.headlineMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('Order Date: 01/01/2022'),
                Text('Quantity: 4')
              ],
            )),
          ),
          Container(
            width: 90,
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                context.push(
                    '${RouteName.profile}/${RouteName.myOrders}/${RouteName.trackingOrder}');
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: Text(
                'Track',
                style: textTheme.displaySmall?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
