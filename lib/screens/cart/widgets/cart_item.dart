import 'package:f_localbrand/config/themes/custom_themes/index.dart';
import 'package:f_localbrand/screens/widgets/buttons/icon_button.dart';
import 'package:f_localbrand/screens/widgets/inputs/quantity_input.dart';
import 'package:f_localbrand/util/price_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartItem extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String size;
  final double price;
  int quantity;

  CartItem({
    required this.imageUrl,
    required this.title,
    required this.size,
    required this.price,
    required this.quantity,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Dismissible(
        key: UniqueKey(),
        background: Container(
          color: colorScheme.errorContainer,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20.0),
          child: Icon(
            FontAwesomeIcons.trash,
            color: colorScheme.error,
            size: 30.0,
          ),
        ),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Remove from Cart"),
                content: Text('Are you sure?'),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                actions: <Widget>[
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Text("Cancel",
                        style: FTextTheme.light.displaySmall
                            ?.copyWith(color: colorScheme.primary)),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Text(
                      "Yes, Remove",
                      style: FTextTheme.light.displaySmall
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
        },
        onDismissed: (direction) {
          // Handle item dismissal, e.g., remove item from the cart
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.network(widget.imageUrl, width: 80, height: 80, fit: BoxFit.cover),
              Image.asset(
                'assets/images/shirt_demo.png',
                width: 80,
                height: 120,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                    Text('Size: XL'),
                    Text(
                      PriceUtil.formatPrice(widget.price.toInt()),
                    ),
                  ],
                ),
              ),
              QuantityInput(
                  quantity: widget.quantity,
                  onIncrease: () {
                    setState(() {
                      widget.quantity++;
                    });
                  },
                  onDecrease: () {
                    setState(() {
                      widget.quantity--;
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
