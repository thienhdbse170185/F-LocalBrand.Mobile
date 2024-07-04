import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key, required this.asset, required this.title});

  final String asset;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            asset,
            height: 240,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 30),
            child:
                Text(title, style: Theme.of(context).textTheme.displayMedium),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 70, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(90),
              ),
            ),
            child: Text('Shop now',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.white)),
          )
        ],
      ),
    );
  }
}
