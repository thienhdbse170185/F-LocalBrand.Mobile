import 'package:f_localbrand/config/router.dart';
import 'package:f_localbrand/features/cart/dto/cart_product_dto.dart';
import 'package:f_localbrand/features/order/bloc/cubit/order_cubit.dart';
import 'package:f_localbrand/screens/cart/components/cart_empty.dart';
import 'package:f_localbrand/screens/widgets/snackbar/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:f_localbrand/features/cart/cubit/cart_cubit.dart';
import 'package:f_localbrand/features/cart/dto/cart_dto.dart';
import 'package:f_localbrand/screens/cart/widgets/cart_item.dart';
import 'package:f_localbrand/screens/widgets/appbars/custom_appbar.dart';
import 'package:f_localbrand/util/price_util.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ScrollController _scrollController = ScrollController();
  CartDto? _cart;
  double _totalValue = 0;
  List<ProductCartDto> _selectedItems = [];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onQuantityChanged(int quantity, int index) {
    setState(() {
      _cart!.items[index].quantity = quantity;
      _updateCartTotal();
    });
  }

  void _updateCartTotal() {
    double total = 0;
    _selectedItems.clear(); // Xóa danh sách đã chọn để cập nhật lại
    for (var item in _cart!.items) {
      if (item.isChecked) {
        total += item.price * item.quantity;
        _selectedItems.add(item); // Thêm mặt hàng đã chọn vào danh sách
      }
    }
    setState(() {
      _totalValue = total;
    });
  }

  Future<void> _onSubmitCheckout() async {
    if (_selectedItems.isEmpty) {
      SnackbarUtil.showSnackbarError(context, 'Please select at least one item',
          paddingBottom: 150);
    } else {
      context.read<OrderCubit>().addToOrderList(_selectedItems);
      context.push(RouteName.checkout);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is DeleteCartItemSuccess) {
          SnackbarUtil.showSnackbarSuccess(context, 'Delete item cart success!',
              paddingBottom: 60);
        } else if (state is DeleteCartItemError) {
          SnackbarUtil.showSnackbarError(context, 'Delete item cart error!',
              paddingBottom: 60);
        }
      },
      child: Scaffold(
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CartLoaded) {
              _cart = state.cart!;
              return _buildCartView(state.cart!, textTheme);
            } else if (state is CartIsEmpty) {
              return _buildEmptyCartView(textTheme);
            } else {
              return Text('Something error in here...Oops!');
            }
          },
        ),
      ),
    );
  }

  Widget _buildEmptyCartView(TextTheme textTheme) {
    return Center(child: CartEmpty());
  }

  Widget _buildCartView(CartDto cart, TextTheme textTheme) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppbar(
            title: 'My cart',
            textTheme: textTheme,
            hasBack: false,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 10),
            child: Text(
              'Item List',
              style: textTheme.displayMedium,
            ),
          ),
          Container(
            height: 520,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = cart.items[index];
                      return Column(children: [
                        CartItem(
                          id: item.id,
                          imageUrl: 'assets/images/shirt_demo.png',
                          title: item.name,
                          size: 'XL',
                          price: item.price,
                          quantity: item.quantity,
                          onQuantityChanged: (quantity) {
                            _onQuantityChanged(quantity, index);
                          },
                          onCheckedChanged: (isChecked) {
                            setState(() {
                              item.isChecked = isChecked;
                              _updateCartTotal();
                            });
                          },
                        ),
                        Divider()
                      ]);
                    },
                    childCount: cart.items.length,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10.0),
                ],
                borderRadius: BorderRadius.circular(12.0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Cost',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(PriceUtil.formatPrice(_totalValue.toInt()),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                      onPressed: () {
                        _onSubmitCheckout();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 64, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        elevation: 4,
                        shadowColor: Colors.grey,
                      ),
                      child: Text(
                        'Proceed to Checkout',
                        style: textTheme.displaySmall
                            ?.copyWith(color: Colors.white),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
