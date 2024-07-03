import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem(
      {super.key,
      required this.route,
      required this.title,
      required this.icon});

  final String route;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant, width: 1.0),
        ),
        color: Colors.transparent,
      ),
      child: ListTile(
        onTap: () {
          context.go(route);
        },
        leading: FaIcon(icon),
        title: Text(
          title,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
        trailing: FaIcon(
          FontAwesomeIcons.arrowRight,
        ),
        tileColor: Colors.transparent,
      ),
    );
  }
}
