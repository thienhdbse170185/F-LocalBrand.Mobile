import 'package:f_localbrand/screens/widgets/inputs/quantity_input.dart';
import 'package:f_localbrand/util/price_util.dart';
import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String size;
  final double price;
  int quantity;
  final ValueChanged<int>? onQuantityChanged;
  final ValueChanged<bool>? onCheckedChanged;

  CartItem({
    required this.imageUrl,
    required this.title,
    required this.size,
    required this.price,
    required this.quantity,
    this.onQuantityChanged,
    this.onCheckedChanged,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
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
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text("Cancel"),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text("Yes, Remove"),
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: _isChecked,
                onChanged: (value) {
                  setState(() {
                    _isChecked = value!;
                    if (widget.onCheckedChanged != null) {
                      widget.onCheckedChanged!(_isChecked);
                    }
                  });
                },
              ),
              Image.asset(
                widget.imageUrl,
                width: 80,
                height: 120,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Size: ${widget.size}'),
                    const SizedBox(height: 10),
                    Text(
                      PriceUtil.formatPrice(widget.price.toInt()),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              QuantityInput(
                quantity: widget.quantity,
                onIncrease: () {
                  setState(() {
                    widget.quantity++;
                    if (widget.onQuantityChanged != null) {
                      widget.onQuantityChanged!(widget.quantity);
                    }
                  });
                },
                onDecrease: () {
                  setState(() {
                    if (widget.quantity > 1) {
                      widget.quantity--;
                      if (widget.onQuantityChanged != null) {
                        widget.onQuantityChanged!(widget.quantity);
                      }
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
