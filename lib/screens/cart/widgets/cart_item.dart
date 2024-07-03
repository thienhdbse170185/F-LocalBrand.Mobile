import 'package:f_localbrand/screens/widgets/buttons/icon_button.dart';
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
      margin: EdgeInsets.only(bottom: 20),
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
                height: 80,
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
                    Text('Size: ${widget.size}'),
                    Text('\$${widget.price}'),
                  ],
                ),
              ),
              Row(
                children: [
                  CustomIconButton(
                    icon: FontAwesomeIcons.minus,
                    onPressed: () {
                      setState(() {
                        if (widget.quantity > 1) {
                          widget.quantity--;
                        }
                      });
                    },
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('${widget.quantity}'),
                  ),
                  CustomIconButton(
                    icon: FontAwesomeIcons.plus,
                    backgroundColor: colorScheme.primary,
                    iconColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        widget.quantity++;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
