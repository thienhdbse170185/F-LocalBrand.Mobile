import 'package:f_localbrand/features/product/dto/customer_product_dto.dart';
import 'package:f_localbrand/features/product/dto/product_dto.dart';
import 'package:f_localbrand/screens/widgets/appbars/custom_appbar.dart';
import 'package:f_localbrand/screens/widgets/list/vertical_grid_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Mock data
final List<CustomerProductDto> customerProducts = [
  CustomerProductDto(
    id: 1,
    customerId: 7,
    productId: 1,
    buyDate: '2024-07-17',
    status: 'True',
    product: ProductDto(
      id: 1,
      productName: 'Áo Thun Nam',
      categoryId: 1,
      campaignId: 1,
      gender: 'Female',
      price: 1000000,
      description: 'string',
      stockQuantity: 760,
      imageUrl: 'assets/images/shirt_demo.png',
      size: 40,
      color: 'Red',
      status: 'Active',
      recommendations: null,
    ),
  ),
  // Add more products as needed
];

class MyProductsScreen extends StatefulWidget {
  const MyProductsScreen({super.key});

  @override
  State<MyProductsScreen> createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Column(
        children: [
          CustomAppbar(title: 'My Products', textTheme: textTheme),
          Container(
            height: 600,
            child: VerticalGridList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = customerProducts[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                            child: Image.asset(
                              product.product.imageUrl,
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.product.productName,
                                  style: textTheme.headlineSmall,
                                ),
                                Text(
                                  'Buy Date: ${DateFormat('dd MMM yyyy').format(DateTime.parse(product.buyDate))}',
                                ),
                                Row(
                                  children: [
                                    Text('Status: '),
                                    DropdownButton<String>(
                                      value: product.status,
                                      items: ['True', 'False']
                                          .map((status) => DropdownMenuItem(
                                                value: status,
                                                child: Text(
                                                  status,
                                                  style: textTheme.displayMedium
                                                      ?.copyWith(fontSize: 16),
                                                ),
                                              ))
                                          .toList(),
                                      onChanged: (newStatus) {
                                        setState(() {
                                          product.status = newStatus!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: customerProducts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
