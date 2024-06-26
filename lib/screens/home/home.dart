import 'package:carousel_slider/carousel_slider.dart';
import 'package:f_localbrand/config/themes/custom_themes/index.dart';
import 'package:f_localbrand/features/user/bloc/user_cubit.dart';
import 'package:f_localbrand/screens/home/hot_product.dart';
import 'package:f_localbrand/screens/home/widgets/category_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/icons/icon_input.dart';

class HomeItemScreen extends StatefulWidget {
  const HomeItemScreen({super.key});

  @override
  State<HomeItemScreen> createState() => _HomeItemScreenState();
}

class _HomeItemScreenState extends State<HomeItemScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUserInfo();
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
                              'Good morning,',
                              style: FTextTheme.light.headlineSmall,
                            ),
                            Text('Thiên'),
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
                            height: 64,
                            width: 64,
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
                  Expanded(
                    child: SizedBox(
                      width: 200,
                      child: TextFormField(
                        autocorrect: false,
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "Search",
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                          ),
                          prefixIcon: IconInput(
                            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
                          ),
                        ),
                        style: textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    height: 64,
                    width: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.primaryFixed,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.filter,
                        color: Colors.white,
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
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'News',
                                style: textTheme.headlineMedium,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 25),
                                child: CarouselSlider(
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
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: Image.asset(
                                            imagePath,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Category',
                                style: textTheme.headlineMedium,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 25),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CategoryImage(
                                            image: AssetImage(
                                                "assets/icon/shirt.png"),
                                            title: 'Shirt'),
                                        const SizedBox(width: 30),
                                        CategoryImage(
                                            image: AssetImage(
                                                "assets/icon/pant.png"),
                                            title: 'Pant'),
                                        const SizedBox(width: 30),
                                        CategoryImage(
                                            image: AssetImage(
                                                "assets/icon/sneakers.png"),
                                            title: 'Sneaker'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Column(
                            children: [
                              Text(
                                'Shopping',
                                style: textTheme.headlineMedium,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: HotProduct(),
                              )
                            ],
                          ),
                        )
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
