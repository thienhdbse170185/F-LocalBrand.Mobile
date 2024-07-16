import 'package:f_localbrand/screens/widgets/appbars/custom_appbar.dart';
import 'package:f_localbrand/util/price_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timelines/timelines.dart';

class TrackingOrderScreen extends StatefulWidget {
  const TrackingOrderScreen({super.key});

  @override
  State<TrackingOrderScreen> createState() => _TrackingOrderScreenState();
}

class _TrackingOrderScreenState extends State<TrackingOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppbar(title: 'Track Order', textTheme: textTheme),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/shirt_demo.png', // Replace with your image asset path
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Brown Suite',
                              style: textTheme.headlineSmall
                                  ?.copyWith(fontSize: 20)),
                          Text('Size: XL | Qty: 10pcs'),
                          const SizedBox(height: 10),
                          Text(PriceUtil.formatPrice(100000),
                              style: textTheme.headlineSmall
                                  ?.copyWith(fontSize: 20)),
                        ],
                      ),
                    ],
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
                      Text('03 Sep 2023', style: textTheme.displayMedium),
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
                  SizedBox(height: 24.0),
                  FixedTimeline.tileBuilder(
                    theme: TimelineThemeData(
                      nodePosition: 0,
                      color: Colors.brown,
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
                      itemExtentBuilder: (_, __) => 100.0,
                      contentsBuilder: (context, index) {
                        var status = _orderStatus[index];
                        return Padding(
                            padding: const EdgeInsets.only(left: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(status['title'],
                                        style: textTheme.displayMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold)),
                                    SizedBox(height: 6.0),
                                    Text(status['subtitle'],
                                        style: textTheme.bodyMedium
                                            ?.copyWith(color: Colors.grey)),
                                  ],
                                ),
                                FaIcon(status['icon'] as IconData, size: 20.0),
                              ],
                            ));
                      },
                      indicatorBuilder: (context, index) {
                        return OutlinedDotIndicator(
                          color: _orderStatus[index]['isCompleted']
                              ? colorScheme.primary
                              : Colors.grey,
                        );
                      },
                      connectorBuilder: (_, index, type) {
                        if (index == 0) {
                          return null;
                        }
                        return SolidLineConnector(
                          color: _orderStatus[index]['isCompleted']
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

  final List<Map<String, dynamic>> _orderStatus = [
    {
      'title': 'Order Placed',
      'subtitle': '23 Aug 2023, 04:25 PM',
      'isCompleted': true,
      'icon': FontAwesomeIcons.listCheck
    },
    {
      'title': 'In Progress',
      'subtitle': '23 Aug 2023, 03:54 PM',
      'isCompleted': true,
      'icon': FontAwesomeIcons.boxesPacking
    },
    {
      'title': 'Shipped',
      'subtitle': 'Expected 02 Sep 2023',
      'isCompleted': false,
      'icon': FontAwesomeIcons.truckDroplet
    },
    {
      'title': 'Delivered',
      'subtitle': '23 Aug 2023, 2023',
      'isCompleted': false,
      'icon': FontAwesomeIcons.boxOpen
    },
  ];
}
