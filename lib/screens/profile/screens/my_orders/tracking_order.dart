import 'package:f_localbrand/features/order/bloc/cubit/order_cubit.dart';
import 'package:f_localbrand/features/order/dto/order_tracking_dto.dart';
import 'package:f_localbrand/screens/checkout/components/checkout_item.dart';
import 'package:f_localbrand/screens/widgets/appbars/custom_appbar.dart';
import 'package:f_localbrand/util/price_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timelines/timelines.dart';
import 'package:intl/intl.dart';

class TrackingOrderScreen extends StatefulWidget {
  const TrackingOrderScreen({super.key, required this.orderTrackingDTO});
  final OrderTrackingDTO orderTrackingDTO;

  @override
  State<TrackingOrderScreen> createState() => _TrackingOrderScreenState();
}

class _TrackingOrderScreenState extends State<TrackingOrderScreen> {
  final List<Map<String, dynamic>> _orderStatus = [
    {
      'title': 'Preparing',
      'status': 'Preparing',
      'icon': FontAwesomeIcons.utensils,
    },
    {
      'title': 'Prepared',
      'status': 'Prepared',
      'icon': FontAwesomeIcons.clipboardCheck,
    },
    {
      'title': 'Shipper Received',
      'status': 'ShipperReceived',
      'icon': FontAwesomeIcons.personWalking,
    },
    {
      'title': 'Shipping',
      'status': 'Shipping',
      'icon': FontAwesomeIcons.truck,
    },
    {
      'title': 'Delivered',
      'status': 'Delivered',
      'icon': FontAwesomeIcons.boxOpen,
    },
  ];

  int _currentStatusIndex() {
    return _orderStatus.indexWhere(
        (status) => status['status'] == widget.orderTrackingDTO.currentStatus);
  }

  String _calculateExpectedDeliveryDate() {
    final DateTime orderDate =
        DateTime.parse(widget.orderTrackingDTO.orderDate);
    final DateTime expectedDeliveryDate = orderDate.add(Duration(days: 10));
    return DateFormat('dd MMM yyyy').format(expectedDeliveryDate);
  }

  String _getChangeTime(String status) {
    final changeTimeString = widget.orderTrackingDTO.changeTime;
    if (changeTimeString != null) {
      final changeTimeMap = Map.fromEntries(
        changeTimeString.split(',').map((e) {
          final split = e.split(':');
          return MapEntry(split[0], split[1]);
        }),
      );
      if (changeTimeMap.containsKey(status)) {
        return DateFormat('dd MMM yyyy, hh:mm a')
            .format(DateTime.parse(changeTimeMap[status]!));
      }
    }
    return 'N/A';
  }

  @override
  void initState() {
    super.initState();
    context
        .read<OrderCubit>()
        .fetchProductByOrderId(widget.orderTrackingDTO.orderId);
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final currentStatusIndex = _currentStatusIndex();
    final expectedDeliveryDate = _calculateExpectedDeliveryDate();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppbar(
              title: 'Tracking Order',
              textTheme: textTheme,
              onPressed: () {
                context.read<OrderCubit>().fetchInprogressOrderTracking();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    child: BlocBuilder<OrderCubit, OrderState>(
                      builder: (context, state) {
                        if (state is FetchOrderDetailsInprogress) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is FetchOrderDetailsSuccess) {
                          return CustomScrollView(
                            slivers: [
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                    return OrderItem(
                                      imageUrl: 'assets/images/shirt_demo.png',
                                      title: state.orderDetails[index].product
                                          .productName,
                                      size: state
                                          .orderDetails[index].product.size
                                          .toString(),
                                      price: PriceUtil.formatPrice(state
                                          .orderDetails[index].product.price
                                          .toInt()),
                                      totalPrice:
                                          state.orderDetails[index].quantity *
                                              state.orderDetails[index].product
                                                  .price,
                                      quantity:
                                          state.orderDetails[index].quantity,
                                    );
                                  },
                                  childCount: state.orderDetails.length,
                                ),
                              ),
                            ],
                          );
                        } else if (state is FetchOrderDetailsFail) {
                          return Center(child: Text(state.message));
                        } else {
                          return Center(child: Text('Something went wrong'));
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Divider(),
                  SizedBox(height: 16.0),
                  Text('Order Details', style: textTheme.headlineMedium),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Expected Delivery Date',
                          style: textTheme.displayMedium),
                      Text(expectedDeliveryDate,
                          style: textTheme.displayMedium),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tracking ID', style: textTheme.displayMedium),
                      Text('TRK452126542', style: textTheme.displayMedium),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Divider(),
                  SizedBox(height: 16.0),
                  Text('Order Status', style: textTheme.headlineMedium),
                  SizedBox(height: 32.0),
                  FixedTimeline.tileBuilder(
                    theme: TimelineThemeData(
                      nodePosition: 0,
                      color: colorScheme.primary,
                      indicatorTheme: IndicatorThemeData(
                        position: 0,
                        size: 20.0,
                      ),
                      connectorTheme: ConnectorThemeData(
                        thickness: 2.5,
                      ),
                    ),
                    builder: TimelineTileBuilder.connected(
                      connectionDirection: ConnectionDirection.before,
                      itemExtentBuilder: (_, __) => 80.0,
                      contentsBuilder: (context, index) {
                        var status = _orderStatus[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 24.0, right: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(status['title'],
                                      style: textTheme.displayMedium?.copyWith(
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 6.0),
                                  Text(_getChangeTime(status['status']),
                                      style: textTheme.bodyMedium
                                          ?.copyWith(color: Colors.grey)),
                                ],
                              ),
                              Spacer(),
                              FaIcon(
                                status['icon'] as IconData,
                                size: 28.0,
                                color: colorScheme.primary,
                              ),
                            ],
                          ),
                        );
                      },
                      indicatorBuilder: (context, index) {
                        return index <= currentStatusIndex
                            ? DotIndicator(
                                color: colorScheme.primary,
                                child: Icon(
                                  FontAwesomeIcons.check,
                                  color: Colors.white,
                                  size: 12.0,
                                ),
                              )
                            : OutlinedDotIndicator(
                                color: Colors.grey,
                              );
                      },
                      connectorBuilder: (_, index, type) {
                        if (index == 0) {
                          return null;
                        }
                        return SolidLineConnector(
                          color: index <= currentStatusIndex
                              ? colorScheme.primary
                              : Colors.grey,
                        );
                      },
                      itemCount: _orderStatus.length,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
