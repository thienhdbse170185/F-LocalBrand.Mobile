import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:f_localbrand/features/cart/data/cart_repository.dart';
import 'package:f_localbrand/features/cart/dto/cart_dto.dart';
import 'package:f_localbrand/features/cart/dto/cart_product_dto.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({required this.cartRepository}) : super(CartInitial());

  final CartRepository cartRepository;

  Future<void> addToCart(int productID, int quantity) async {
    emit(AddToCartInprogress());
    try {
      await cartRepository.addToCart(productID, quantity);
      emit(AddToCartSuccess());
      fetchCart();
    } catch (e) {
      emit(AddToCartError());
    }
  }

  Future<void> fetchCart() async {
    emit(CartLoading());
    try {
      final cart = await cartRepository.getCart();
      emit(CartLoaded(cart));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
