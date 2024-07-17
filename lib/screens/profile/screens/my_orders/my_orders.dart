import 'package:f_localbrand/features/order/bloc/cubit/order_cubit.dart';
import 'package:f_localbrand/screens/profile/screens/my_orders/tabs/active_tab.dart';
import 'package:f_localbrand/screens/profile/screens/my_orders/tabs/cancelled_tab.dart';
import 'package:f_localbrand/screens/profile/screens/my_orders/tabs/completed_tab.dart';
import 'package:f_localbrand/screens/widgets/appbars/custom_appbar.dart';
import 'package:f_localbrand/screens/widgets/buttons/back_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OrderCubit>().fetchInprogressOrderTracking();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      animationDuration: Duration(milliseconds: 400),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight + kTextTabBarHeight),
          child: Column(
            children: [
              AppBar(
                title: Text(
                  'My Orders',
                  style: textTheme.headlineMedium,
                ),
                centerTitle: true,
              ),
              TabBar(
                tabs: [
                  Tab(text: 'Active'),
                  Tab(text: 'Completed'),
                  Tab(text: 'Cancelled'),
                ],
                labelColor: colorScheme.primary,
                unselectedLabelColor: Colors.grey,
                indicatorColor: colorScheme.primary,
                labelStyle: textTheme.displayMedium,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: ActiveTab()),
            Center(child: CompletedTab()),
            Center(child: CancelledTab()),
          ],
        ),
      ),
    );
  }
}
