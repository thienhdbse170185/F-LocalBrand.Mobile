import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:f_localbrand/features/cart/data/cart_repository.dart';
import 'package:f_localbrand/features/cart/dto/cart_product.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required this.cartRepository}) : super(CartInitial());

  final CartRepository cartRepository;

  Future<void> getCart() async {
    emit(CartLoading());
    List<ProductCartDto> cart = [];
    cart = await cartRepository.getCart();
    if (cart.isEmpty) {
      emit(CartIsEmpty());
      return;
    }
    emit(CartLoaded(cart));
  }
}
