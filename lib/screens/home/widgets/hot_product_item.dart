import 'package:f_localbrand/config/router.dart';
import 'package:f_localbrand/features/product/dto/product_dto.dart';
import 'package:f_localbrand/screens/widgets/snackbar/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:f_localbrand/features/product/dto/product_home_dto.dart';
import 'package:go_router/go_router.dart';

class HotProductItem extends StatefulWidget {
  const HotProductItem({super.key, required this.product});

  final ProductDto product;

  @override
  State<HotProductItem> createState() => _HotProductItemState();
}

class _HotProductItemState extends State<HotProductItem> {
  bool _isFavorite = false;

  void _onFavoritePressed() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    if (_isFavorite) {
      SnackbarUtil.showSnackbarSuccess(context, 'Added to your favourites');
    } else {
      SnackbarUtil.showSnackbarError(context, 'Removed from your favourites');
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        // context.go('${RouteName.productDetail}/${widget.product.id}');
        context.push(RouteName.productDetail, extra: widget.product.id);
      },
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10.0)),
                  // Adjust the image height
                  child: Image.network(
                    widget.product.imageUrl,
                    height: 160, // Adjust height to fit the card
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      _onFavoritePressed();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: FaIcon(
                          _isFavorite
                              ? FontAwesomeIcons.solidHeart
                              : FontAwesomeIcons.heart,
                          color: colorScheme.primary),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Text(
                widget.product.productName,
                style: textTheme.headlineSmall?.copyWith(fontSize: 14),
                maxLines: 1, // Prevent text overflow
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: Text(
                '${widget.product.price}VNĐ',
                style: textTheme.headlineMedium
                    ?.copyWith(color: colorScheme.primary),
                maxLines: 1, // Prevent text overflow
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
