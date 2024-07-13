import 'package:carousel_slider/carousel_slider.dart';
import 'package:f_localbrand/config/router.dart';
import 'package:f_localbrand/config/themes/custom_themes/index.dart';
import 'package:f_localbrand/features/product/bloc/product_cubit.dart';
import 'package:f_localbrand/features/product/dto/product_dto.dart';
import 'package:f_localbrand/features/user/bloc/user_cubit.dart';
import 'package:f_localbrand/screens/home/hot_product.dart';
import 'package:f_localbrand/screens/home/widgets/category_image.dart';
import 'package:f_localbrand/screens/home/widgets/product_home.dart';
import 'package:f_localbrand/screens/home/widgets/sub_section.dart';
import 'package:f_localbrand/screens/widgets/inputs/expanded_rounded_icon_input.dart';
import 'package:f_localbrand/screens/widgets/list/horizontal_grid_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class HomeItemScreen extends StatefulWidget {
  const HomeItemScreen({super.key});

  @override
  State<HomeItemScreen> createState() => _HomeItemScreenState();
}

class _HomeItemScreenState extends State<HomeItemScreen> {
  List<ProductDto> _productBestsellers = [];
  List<ProductDto> _productNewest = [];
  bool _isBestsellerLoading = false, _isNewestLoading = false;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextEditingController _searchController = TextEditingController();
    final TextTheme textTheme = FTextTheme.light;

    int _current = 0;
    final CarouselController _controller = CarouselController();

    final imageList = [
      'assets/images/banner2.png',
      'assets/images/banner3.png',
      'assets/images/banner4.png',
    ];

    return BlocListener<ProductCubit, ProductState>(
      listener: (context, state) {
        if (state is ProductBestsellerLoading) {
          setState(() {
            _isBestsellerLoading = true;
          });
        } else if (state is ProductNewestLoading) {
          setState(() {
            _isNewestLoading = true;
          });
        } else if (state is ProductBestsellerLoaded) {
          setState(() {
            _isBestsellerLoading = false;
            _productBestsellers = state.productsBestseller;
          });
          print('best-seller loaded');
        } else if (state is ProductNewestLoaded) {
          setState(() {
            _isNewestLoading = false;
            _productNewest = state.productsNewest;
          });
          print('newest loaded');
        } else if (state is ProductBestsellerError) {
          print('get best-seller error');
          setState(() {
            _isBestsellerLoading = false;
          });
        } else if (state is ProductNewestError) {
          print('get newest error');
          setState(() {
            _isNewestLoading = false;
          });
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
            children: [
              BlocBuilder<UserCubit, UserState>(builder: (context, state) {
                if (state is GetUserInfoSuccess) {
                  return SizedBox(
                    width: 400,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Good evening,',
                                style: FTextTheme.light.headlineSmall,
                              ),
                              Text(state.user.fullName),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colorScheme.onInverseSurface,
                          ),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: FaIcon(
                                  FontAwesomeIcons.solidBell,
                                  size: 28,
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: colorScheme.onInverseSurface,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: SizedBox(
                                    width: 2,
                                    height: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: colorScheme.primary,
                              width: 2.0,
                            ),
                          ),
                          child: ClipOval(
                            child: Image(
                              image: NetworkImage(state.user.image),
                              height: 48,
                              width: 48,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ExpandedRoundedIconInput(
                        textController: _searchController,
                        hintText: "Search shirt, pant, sneaker...",
                        icon: FontAwesomeIcons.magnifyingGlass),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        context.push(RouteName.filter);
                      },
                      child: Container(
                        height: 64,
                        width: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.filter,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          SubSectionHome(
                              paddingTop: 20,
                              hasAllText: true,
                              title: 'BEST-SELLERS',
                              body: _isBestsellerLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : _productBestsellers.isEmpty
                                      ? Text("No best-sellers available")
                                      : HorizontalGridList(
                                          delegate: SliverChildBuilderDelegate(
                                            (context, index) {
                                              final product =
                                                  _productBestsellers[index];
                                              return ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  minHeight: 300,
                                                  maxHeight: 500,
                                                  minWidth: 0,
                                                  maxWidth: 200,
                                                ),
                                                child: ProductHome(
                                                    product: product),
                                              );
                                            },
                                            childCount:
                                                _productBestsellers.length,
                                          ),
                                        ),
                              textTheme: textTheme),
                          SubSectionHome(
                            title: 'NEWS FROM F-LocalBrand',
                            body: CarouselSlider(
                              carouselController: _controller,
                              options: CarouselOptions(
                                height: 200,
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.8,
                                enlargeCenterPage: true,
                                pauseAutoPlayOnManualNavigate: true,
                                autoPlay: true,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                },
                              ),
                              items: imageList.map((imagePath) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Image.asset(
                                        imagePath,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                            textTheme: textTheme,
                          ),
                          SubSectionHome(
                              hasAllText: true,
                              title: 'NEWEST',
                              body: _isNewestLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : _productNewest.isEmpty
                                      ? Text("No newest products available")
                                      : HorizontalGridList(
                                          delegate: SliverChildBuilderDelegate(
                                            (context, index) {
                                              // final product = _productNewest[index];
                                              final product =
                                                  _productNewest[index];
                                              return ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  minHeight: 300,
                                                  maxHeight: 500,
                                                  minWidth: 0,
                                                  maxWidth: 200,
                                                ),
                                                child: ProductHome(
                                                    product: product),
                                              );
                                            },
                                            childCount: _productNewest.length,
                                          ),
                                        ),
                              textTheme: textTheme),
                          SubSectionHome(
                            title: 'CATEGORY',
                            body: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CategoryImage(
                                  image: AssetImage("assets/icon/shirt.png"),
                                  title: 'Shirt',
                                  onPressed: () {
                                    context.push(RouteName.category,
                                        extra: 'Shirts');
                                  },
                                ),
                                const SizedBox(width: 30),
                                CategoryImage(
                                  image: AssetImage("assets/icon/pant.png"),
                                  title: 'Pant',
                                  onPressed: () {
                                    context.push(RouteName.category,
                                        extra: 'Pants');
                                  },
                                ),
                                const SizedBox(width: 30),
                                CategoryImage(
                                  image: AssetImage("assets/icon/sneakers.png"),
                                  title: 'Sneaker',
                                  onPressed: () {
                                    context.push(RouteName.category,
                                        extra: 'Sneakers');
                                  },
                                ),
                                const SizedBox(width: 30),
                                CategoryImage(
                                  image: AssetImage("assets/icon/sneakers.png"),
                                  title: 'Sneaker',
                                  onPressed: () {
                                    context.push(RouteName.category,
                                        extra: 'Sneakers');
                                  },
                                ),
                              ],
                            ),
                            textTheme: textTheme,
                            hasAllText: true,
                          ),
                          SubSectionHome(
                            title: 'SHOPPING NOW',
                            body: HotProduct(),
                            textTheme: textTheme,
                            hasAllText: true,
                          )
                        ],
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
