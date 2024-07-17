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
      if (cart != null) {
        cartRepository.setCart(cart);
        emit(CartLoaded(cart));
      } else {
        emit(CartIsEmpty());
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<bool> updateCart(List<ProductCartDto> selectedCartItems) async {
    emit(UpdateCartInprogress());
    try {
      await cartRepository.updateCart(selectedCartItems);
      emit(UpdateCartSuccess());
      return true;
    } catch (e) {
      emit(UpdateCartError());
      return false;
    }
  }

  Future<bool> deleteCartItem(int id) async {
    emit(DeleteCartItemInprogress());
    try {
      await cartRepository.deleteCartItem(id);
      fetchCart();
      emit(DeleteCartItemSuccess());
      return true;
    } catch (e) {
      emit(DeleteCartItemError());
      return false;
    }
  }
}
