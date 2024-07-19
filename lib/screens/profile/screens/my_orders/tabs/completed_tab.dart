import 'package:f_localbrand/config/router.dart';
import 'package:f_localbrand/config/themes/custom_themes/text_theme.dart';
import 'package:f_localbrand/features/order/bloc/cubit/order_cubit.dart';
import 'package:f_localbrand/features/order/dto/order_dto.dart';
import 'package:f_localbrand/features/order/dto/order_tracking_dto.dart';
import 'package:f_localbrand/features/user/bloc/user_cubit.dart';
import 'package:f_localbrand/screens/widgets/buttons/icon_button.dart';
import 'package:f_localbrand/screens/widgets/screens/empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CompletedTab extends StatefulWidget {
  const CompletedTab({Key? key}) : super(key: key);

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  bool _isLoading = false;
  bool _isEmpty = false;
  List<OrderTrackingDTO>? orders;

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    final customerId = context.read<UserCubit>().state.user!.id;
    context.read<OrderCubit>().fetchCompletedOrderHistory(customerId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderCubit, OrderState>(
      listener: (context, state) {
        if (state is FetchCompletedOrderHistoryInprogress) {
          setState(() {
            _isLoading = true;
          });
        } else if (state is FetchCompletedOrderHistorySuccess) {
          setState(() {
            orders = state.orderTrackingList;
            _isLoading = false;
            _isEmpty = orders!.isEmpty; // Check if orders list is empty
          });
        } else if (state is FetchCompletedOrderHistoryFail) {
          setState(() {
            _isLoading = false;
            _isEmpty = true;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      },
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_isEmpty) {
      return const EmptyOrder(); // Use a relevant empty state widget or screen
    } else if (orders == null || orders!.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return RefreshIndicator(
        onRefresh: _fetchOrders,
        child: ListView.builder(
          itemCount: orders!.length,
          itemBuilder: (BuildContext context, int index) {
            final OrderTrackingDTO order = orders![index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: FaIcon(
                      FontAwesomeIcons.box,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
                title: Text(
                  'Order #${order.orderId.toString()}',
                  style: FTextTheme.light.headlineSmall,
                ),
                subtitle: Text(
                  'Order Date: ${order.orderDate}',
                  style: FTextTheme.light.displaySmall,
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
