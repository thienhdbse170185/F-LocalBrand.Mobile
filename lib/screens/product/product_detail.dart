import 'package:f_localbrand/features/cart/cubit/cart_cubit.dart';
import 'package:f_localbrand/features/product/bloc/product_cubit.dart';
import 'package:f_localbrand/features/product/dto/product_details.dart';
import 'package:f_localbrand/features/product/dto/product_dto.dart';
import 'package:f_localbrand/features/product/dto/product_home_dto.dart';
import 'package:f_localbrand/screens/home/widgets/product_home.dart';
import 'package:f_localbrand/screens/product/widgets/sub_section.dart';
import 'package:f_localbrand/screens/widgets/buttons/back_button.dart';
import 'package:f_localbrand/screens/widgets/inputs/quantity_input.dart';
import 'package:f_localbrand/screens/widgets/list/horizontal_grid_list.dart';
import 'package:f_localbrand/screens/widgets/snackbar/snackbar_util.dart';
import 'package:f_localbrand/util/price_util.dart';
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
  ProductDto? _product;
  List<ProductDetailsDTO>? _productDetails;

  bool _isFavourite = false;
  String _selectedSize = '';
  Color? _selectedColor;
  int quantity = 1;

  List<String> _availableSizes = [];
  List<Color> _availableColors = [];

  final ScrollController _scrollController = ScrollController();
  double _imageHeight = 400;
  double _cartOpacity = 1.0;

  bool _showSuccessSnackbar = false;

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
      SnackbarUtil.showSnackbarSuccess(context, 'Added to your favourites!',
          paddingBottom: 100);
    } else {
      SnackbarUtil.showSnackbarError(context, 'Removed from your favourites!',
          paddingBottom: 100);
    }
  }

  void _addToCart() {
    if (_product != null) {
      context.read<CartCubit>().addToCart(_product!.id, quantity);
    }
  }

  void _updateAvailableSizesAndColors() {
    if (_productDetails != null) {
      Set<String> sizes = {};
      Set<Color> colors = {};

      for (var detail in _productDetails!) {
        sizes.add(detail.size.toString());
        colors.add(_parseColor(detail.color));
      }

      setState(() {
        _availableSizes = sizes.toList();
        _availableColors = colors.toList();
      });
    }
  }

  void _updateAvailableSizes() {
    if (_productDetails != null && _selectedColor != null) {
      Set<String> sizes = {};

      for (var detail in _productDetails!) {
        if (_parseColor(detail.color) == _selectedColor) {
          sizes.add(detail.size.toString());
        }
      }

      setState(() {
        _availableSizes = sizes.toList();
      });
    }
  }

  void _updateAvailableColors() {
    if (_productDetails != null && _selectedSize.isNotEmpty) {
      Set<Color> colors = {};

      for (var detail in _productDetails!) {
        if (detail.size == _selectedSize) {
          colors.add(_parseColor(detail.color));
        }
      }

      setState(() {
        _availableColors = colors.toList();
      });
    }
  }

  Color _parseColor(String colorStr) {
    switch (colorStr.toLowerCase()) {
      case 'brown':
        return Colors.brown;
      case 'black':
        return Colors.black;
      case 'grey':
        return Colors.grey;
      case 'white':
        return Colors.white;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return MultiBlocListener(
      listeners: [
        BlocListener<ProductCubit, ProductState>(
          listener: (context, state) {
            if (state is ProductDetailsLoading) {
              print('loading product detail');
            } else if (state is ProductDetailsLoaded) {
              print('product detail loaded');
              setState(() {
                _product = state.product;
                _updateAvailableSizesAndColors();
              });
              context
                  .read<ProductCubit>()
                  .fetchProductDetailsByName(_product!.productName);
            } else if (state is ProductDetailsError) {
              print('error loading product detail');
            } else if (state is GetProductDetailsByNameSuccess) {
              setState(() {
                _productDetails = state.productDetails;
                _updateAvailableSizesAndColors();
              });
            }
          },
        ),
        BlocListener<CartCubit, CartState>(
          listener: (context, state) async {
            if (state is AddToCartInprogress) {
              print('adding to cart');
            } else if (state is AddToCartSuccess) {
              print('added to cart');
              setState(() {
                _showSuccessSnackbar = true;
              });
              SnackbarUtil.showSnackbarSuccess(
                  context, 'Added to your cart! Thank you ^^',
                  paddingBottom: 100);
              await Future.delayed(Duration(milliseconds: 2000));
              setState(() {
                _showSuccessSnackbar = false;
              });
            } else if (state is AddToCartError) {
              print('error adding to cart');
            }
          },
        ),
      ],
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
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
                                    _product?.productName ?? '',
                                    style: textTheme.headlineMedium,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          PriceUtil.formatPrice(
                                              _product?.price.toInt() ?? 0),
                                          style: textTheme.headlineMedium),
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
                                padding: EdgeInsets.only(top: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Female\'s Style',
                                        style: textTheme.displaySmall),
                                    QuantityInput(
                                        quantity: quantity,
                                        onIncrease: () {
                                          setState(() {
                                            quantity++;
                                          });
                                        },
                                        onDecrease: () {
                                          setState(() {
                                            quantity--;
                                          });
                                        })
                                  ],
                                ),
                              ),
                              SubSection(
                                title: 'Description',
                                widget: Text(
                                  _product?.description ?? '',
                                  style: textTheme.displaySmall
                                      ?.copyWith(color: colorScheme.outline),
                                ),
                              ),
                              SubSection(
                                title: 'Size',
                                widget: Wrap(
                                  spacing: 8.0,
                                  children: _availableSizes.map((size) {
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
                                          _selectedSize = selected ? size : '';
                                          _updateAvailableColors();
                                        });
                                      },
                                      selectedColor:
                                          Theme.of(context).primaryColor,
                                    );
                                  }).toList(),
                                ),
                              ),
                              SubSection(
                                title: 'Color',
                                widget: Wrap(
                                  spacing: 16.0,
                                  children: _availableColors.map((color) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedColor = color;
                                          _updateAvailableSizes();
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
              bottom: 10,
              left: 0,
              right: 0,
              child: AnimatedOpacity(
                opacity: _cartOpacity,
                duration: Duration(milliseconds: 300),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: _addToCart,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'Add to Cart',
                      style: textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                      ),
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
