import 'package:f_localbrand/features/user/bloc/user_cubit.dart';
import 'package:f_localbrand/screens/widgets/appbars/custom_appbar.dart';
import 'package:f_localbrand/screens/widgets/buttons/back_button.dart';
import 'package:f_localbrand/screens/widgets/images/avatar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({super.key});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      return Scaffold(
        body: Column(
          children: [
            CustomAppbar(
              title: 'Profile Details',
              textTheme: textTheme,
              trailing: TextButton(
                onPressed: () {},
                child: Text(
                  'Edit',
                  style: textTheme.displaySmall,
                ),
              ),
            ),
            AvatarOval(
              image: NetworkImage(state.user!.image),
              isBorder: true,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                state.user!.fullName,
                style: textTheme.displayLarge,
              ),
            )
          ],
        ),
      );
    });
  }
}
