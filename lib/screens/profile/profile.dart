import 'package:f_localbrand/config/router.dart';
import 'package:f_localbrand/config/themes/custom_themes/index.dart';
import 'package:f_localbrand/config/themes/material_theme.dart';
import 'package:f_localbrand/features/auth/bloc/auth_bloc.dart';
import 'package:f_localbrand/features/user/bloc/user_cubit.dart';
import 'package:f_localbrand/screens/profile/widgets/profile_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> navigationItems = [
    {
      'route': '/profile-detail',
      'title': 'Your Profile',
      'icon': FontAwesomeIcons.solidUser,
    },
    {
      'route': '/profile-payment',
      'title': 'Payment Methods',
      'icon': FontAwesomeIcons.creditCard,
    },
    {
      'route': '/profile-orders',
      'title': 'My Orders',
      'icon': FontAwesomeIcons.boxesStacked,
    },
    {
      'route': '/settings',
      'title': 'Settings',
      'icon': FontAwesomeIcons.gear,
    },
    {
      'route': '/help-center',
      'title': 'Help Center',
      'icon': FontAwesomeIcons.circleInfo,
    },
    {
      'route': '/privacy-policy',
      'title': 'Privacy Policy',
      'icon': FontAwesomeIcons.lock,
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(listener: (context, state) {
          if (state is AuthLogoutSuccess) {
            context.go(RouteName.getStarted);
          }
        }),
        BlocListener<UserCubit, UserState>(listener: (context, state) {
          if (state is GetUserInfoSuccess) {
            print(state.user.image);
          }
        })
      ],
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 64),
          child: Center(
            child: Column(
              children: [
                Text(
                  'Profile',
                  style: FTextTheme.light.titleSmall,
                ),
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    if (state is GetUserInfoSuccess) {
                      return Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: ClipOval(
                                  child: Image(
                                    image: NetworkImage(state.user.image),
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            Text(
                              state.user.fullName,
                              style: FTextTheme.light.headlineSmall,
                            ),
                            Text(
                              state.user.email,
                              style: FTextTheme.light.displayMedium?.copyWith(
                                color: MaterialTheme.lightScheme().outline,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return CircularProgressIndicator(); // Hiển thị loading indicator nếu chưa có dữ liệu
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView(
                      controller: _scrollController,
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        ...navigationItems.map((item) => ProfileItem(
                              route: item['route'],
                              title: item['title'],
                              icon: item['icon'],
                            )),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 24.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                                width: 1.0,
                              ),
                            ),
                            color: Colors.transparent,
                          ),
                          child: ListTile(
                            onTap: () async {
                              await showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: 200,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Text('Logout',
                                              style: FTextTheme
                                                  .light.headlineMedium),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            child: Container(
                                              width: double.infinity,
                                              height: 1,
                                              color: MaterialTheme.lightScheme()
                                                  .outlineVariant,
                                            ),
                                          ),
                                          Text(
                                              'Are you sure you want to logout?',
                                              style: FTextTheme
                                                  .light.displayMedium
                                                  ?.copyWith(
                                                      color: MaterialTheme
                                                              .lightScheme()
                                                          .outline)),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      40)),
                                                  child: Text(
                                                    'Cancel',
                                                    style: FTextTheme
                                                        .light.headlineMedium
                                                        ?.copyWith(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 30,
                                                ),
                                                OutlinedButton(
                                                    onPressed: () {
                                                      context.read<AuthBloc>().add(
                                                          AuthLogoutStarted());
                                                    },
                                                    child: Text(
                                                      'Yes, logout',
                                                      style: FTextTheme
                                                          .light.headlineMedium
                                                          ?.copyWith(
                                                        fontSize: 16,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            leading: FaIcon(
                              FontAwesomeIcons.arrowRightFromBracket,
                            ),
                            title: Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: FaIcon(
                              FontAwesomeIcons.arrowRight,
                            ),
                            tileColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
