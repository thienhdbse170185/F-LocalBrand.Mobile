import 'package:f_localbrand/features/product/bloc/product_cubit.dart';
import 'package:f_localbrand/features/product/dto/product_home_dto.dart';
import 'package:f_localbrand/screens/home/hot_product.dart';
import 'package:f_localbrand/screens/home/widgets/product_home.dart';
import 'package:f_localbrand/screens/product/widgets/sub_section.dart';
import 'package:f_localbrand/screens/widgets/buttons/back_button.dart';
import 'package:f_localbrand/screens/widgets/list/horizontal_grid_list.dart';
import 'package:f_localbrand/screens/widgets/snackbar/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductDetailScreen extends StatefulWidget {
  final int id;

  const ProductDetailScreen({super.key, required this.id});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _isFavourite = false;
  String _selectedSize = 'S';
  Color? _selectedColor = Colors.brown;

  final ScrollController _scrollController = ScrollController();
  double _imageHeight = 400;
  double _cartOpacity = 1.0;

  bool _showSuccessSnackbar = false;

  List<ProductHomeDto> _products = [
    ProductHomeDto(id: 1, name: "Home Shirt", price: 100),
    ProductHomeDto(id: 2, name: "Home Shirt", price: 100),
    ProductHomeDto(id: 3, name: "Home Shirt", price: 100),
    ProductHomeDto(id: 4, name: "Home Shirt", price: 100),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        if (_scrollController.offset > 0 && _imageHeight == 400) {
          _imageHeight = 300;
          _cartOpacity = 1.0;
        } else if (_scrollController.offset <= 0 && _imageHeight == 300) {
          _imageHeight = 400;
          _cartOpacity = 0.0;
        }
      });
    });
  }

  void _onFavoritePressed() {
    setState(() {
      _isFavourite = !_isFavourite;
    });
    if (_isFavourite) {
      SnackbarUtil.showSnackbarSuccess(context, 'Added to your favourites!');
    } else {
      SnackbarUtil.showSnackbarError(context, 'Removed from your favourites!');
    }
  }

  void _addToCart() {
    setState(() {
      _showSuccessSnackbar = true;
    });
    SnackbarUtil.showSnackbarSuccess(
        context, 'Added to your cart! Thank you ^^');
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _showSuccessSnackbar = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return BlocListener<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is ProductDetailsLoading) {
          print('loading product detail');
        } else if (state is ProductDetailsLoaded) {
          print('loaded product detail');
        } else if (state is ProductDetailsError) {
          print('error loading product detail');
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  height: _imageHeight,
                  curve: Curves.easeInOut,
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/shirt_demo.png',
                          height: 400,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 40,
                        left: 20,
                        child: CustomBackButton(),
                      ),
                      Positioned(
                        top: 40,
                        right: 20,
                        child: IconButton(
                          icon: FaIcon(
                            _isFavourite
                                ? FontAwesomeIcons.solidHeart
                                : FontAwesomeIcons.heart,
                            color: colorScheme.primary,
                          ),
                          onPressed: () {
                            _onFavoritePressed();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.only(
                            top: 30, left: 20, right: 20, bottom: 90),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Home Shirt', // Replace with product name
                                    style: textTheme.headlineMedium,
                                  ),
                                  Row(
                                    children: [
                                      Text('\$100.0',
                                          style: textTheme.displayMedium),
                                      const SizedBox(width: 8),
                                      FaIcon(
                                          FontAwesomeIcons.circleDollarToSlot,
                                          color: colorScheme.primary,
                                          size: 28),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: Text('Female\'s Style',
                                    style: textTheme.displaySmall),
                              ),
                              SubSection(
                                title: 'Description',
                                widget: Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                  style: textTheme.displaySmall
                                      ?.copyWith(color: colorScheme.outline),
                                ),
                              ),
                              SubSection(
                                title: 'Select Size',
                                widget: Wrap(
                                  spacing: 8.0,
                                  children: ['S', 'M', 'L', 'XL', 'XXL'].map(
                                    (size) {
                                      return ChoiceChip(
                                        label: Text(size),
                                        padding: EdgeInsets.all(8),
                                        showCheckmark: false,
                                        selected: _selectedSize == size,
                                        labelStyle:
                                            textTheme.displaySmall?.copyWith(
                                          color: _selectedSize == size
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        onSelected: (bool selected) {
                                          setState(() {
                                            _selectedSize =
                                                selected ? size : '';
                                          });
                                        },
                                        selectedColor:
                                            Theme.of(context).primaryColor,
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                              SubSection(
                                title: 'Select Color: Brown',
                                widget: Wrap(
                                  spacing: 16.0,
                                  children: [
                                    Colors.brown,
                                    Colors.black,
                                    Colors.grey,
                                    Colors.white,
                                  ].map((color) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedColor = color;
                                        });
                                      },
                                      child: Container(
                                        decoration: ShapeDecoration(
                                          shape: CircleBorder(
                                            side: BorderSide(
                                              color: colorScheme.outline,
                                              width: 1.0,
                                            ),
                                          ),
                                          color: color,
                                        ),
                                        width: 40.0,
                                        height: 40.0,
                                        child: Center(
                                          child: Container(
                                            width: 24.0,
                                            height: 24.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: _selectedColor == color
                                                  ? (color == Colors.white
                                                      ? Colors.black
                                                      : Colors.white)
                                                  : null,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              // SubSection(
                              //   title: 'Recommended products',
                              //   widget: HorizontalGridList(
                              //     delegate: SliverChildBuilderDelegate(
                              //       (context, index) {
                              //         final product = _products[index];
                              //         return ConstrainedBox(
                              //           constraints: BoxConstraints(
                              //             minHeight: 300,
                              //             maxHeight: 500,
                              //             minWidth: 0,
                              //             maxWidth: 200,
                              //           ),
                              //           child: ProductHome(product: product),
                              //         );
                              //       },
                              //       childCount: _products.length,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AnimatedOpacity(
                opacity: _cartOpacity,
                duration: Duration(milliseconds: 300),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: Offset(0, -2),
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(28),
                            topRight: Radius.circular(28))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Total price', // Replace with actual total
                                style: textTheme.headlineSmall?.copyWith(
                                  color: colorScheme.outline,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                '\$0.0', // Replace with actual total
                                style: textTheme.headlineSmall?.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _addToCart();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _showSuccessSnackbar
                                ? Colors.grey
                                : Theme.of(context).primaryColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            elevation: 4,
                            shadowColor: Colors.grey,
                          ),
                          child: Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.bagShopping,
                                color: Colors.white,
                              ),
                              SizedBox(width: 12),
                              Text(
                                _showSuccessSnackbar ? 'Added!' : 'Add to Cart',
                                style: textTheme.headlineSmall
                                    ?.copyWith(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
