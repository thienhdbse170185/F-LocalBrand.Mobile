import 'package:carousel_slider/carousel_slider.dart';
import 'package:f_localbrand/config/router.dart';
import 'package:f_localbrand/config/themes/custom_themes/index.dart';
import 'package:f_localbrand/features/category/cubit/category_cubit.dart';
import 'package:f_localbrand/features/product/bloc/product_cubit.dart';
import 'package:f_localbrand/features/product/dto/product_home_dto.dart';
import 'package:f_localbrand/features/user/bloc/user_cubit.dart';
import 'package:f_localbrand/screens/home/hot_product.dart';
import 'package:f_localbrand/screens/home/widgets/category_image.dart';
import 'package:f_localbrand/screens/home/widgets/hot_product_item.dart';
import 'package:f_localbrand/screens/home/widgets/product_home.dart';
import 'package:f_localbrand/screens/home/widgets/sub_section.dart';
import 'package:f_localbrand/screens/widgets/inputs/expanded_rounded_icon_input.dart';
import 'package:f_localbrand/screens/widgets/list/horizontal_grid_list.dart';
import 'package:f_localbrand/screens/widgets/texts/text_pressed.dart';
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
  @override
  void initState() {
    super.initState();
    // await context.read<ProductCubit>().fetchProductsNewest();
    // await context.read<ProductCubit>().fetchProductsBestseller();
    // context.read<CategoryCubit>().getCategories();
  }

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

    List<ProductHomeDto> _products = [
      ProductHomeDto(id: 1, name: "Home Shirt", price: 100),
      ProductHomeDto(id: 2, name: "Home Shirt", price: 100),
      ProductHomeDto(id: 3, name: "Home Shirt", price: 100),
      ProductHomeDto(id: 4, name: "Home Shirt", price: 100),
    ];

    return Scaffold(
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
                            title: 'Best-seller',
                            body: HorizontalGridList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final product = _products[index];
                                  return ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight: 300,
                                      maxHeight: 500,
                                      minWidth: 0,
                                      maxWidth: 200,
                                    ),
                                    child: ProductHome(product: product),
                                  );
                                },
                                childCount: _products.length,
                              ),
                            ),
                            textTheme: textTheme),
                        SubSectionHome(
                          title: 'News from F-LocalBrand',
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
                            title: 'Newest',
                            body: HorizontalGridList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final product = _products[index];
                                  return ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight: 300,
                                      maxHeight: 500,
                                      minWidth: 0,
                                      maxWidth: 200,
                                    ),
                                    child: ProductHome(product: product),
                                  );
                                },
                                childCount: _products.length,
                              ),
                            ),
                            textTheme: textTheme),
                        SubSectionHome(
                          title: 'Category',
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
                          title: 'Shopping',
                          body: HotProduct(),
                          textTheme: textTheme,
                          hasAllText: true,
                        )
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
