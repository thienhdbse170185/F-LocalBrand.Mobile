import 'package:f_localbrand/features/order/bloc/cubit/order_cubit.dart';
import 'package:f_localbrand/screens/profile/screens/my_orders/widget/order_status_item.dart';
import 'package:f_localbrand/screens/widgets/list/vertical_sliver_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveTab extends StatefulWidget {
  const ActiveTab({super.key});

  @override
  State<ActiveTab> createState() => _ActiveTabState();
}

class _ActiveTabState extends State<ActiveTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        debugPrint('ActiveTab state: $state'); // Added logging
        if (state is FetchInprogressOrderTrackingInprogress) {
          return Center(child: CircularProgressIndicator());
        } else if (state is FetchInprogressOrderTrackingSuccess) {
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index < state.orderTrackingList.length) {
                      return OrderStatusItem(
                        orderTracking: state.orderTrackingList[index],
                      );
                    }
                    return null; // Return null to indicate the end of the list
                  },
                  childCount: state
                      .orderTrackingList.length, // Set the correct childCount
                ),
              ),
            ],
          );
        } else if (state is FetchInprogressOrderTrackingFail) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text('Something went wrong'));
        }
      },
    );
  }
}
