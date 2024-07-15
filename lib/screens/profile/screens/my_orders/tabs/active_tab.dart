import 'package:f_localbrand/screens/profile/screens/my_orders/widget/order_status_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ActiveTab extends StatefulWidget {
  const ActiveTab({super.key});

  @override
  State<ActiveTab> createState() => _ActiveTabState();
}

class _ActiveTabState extends State<ActiveTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [OrderStatusItem(), Divider()],
    ));
  }
}
