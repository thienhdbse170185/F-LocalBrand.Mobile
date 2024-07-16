part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final CartDto? cart;

  const CartLoaded(this.cart);
}

class CartError extends CartState {
  final String? message;

  CartError(this.message);
}

class CartAdded extends CartState {
  final ProductCartDto product;

  const CartAdded(this.product);

  @override
  List<Object> get props => [product];
}

class CartIsEmpty extends CartState {}

class AddToCartInprogress extends CartState {}

class AddToCartSuccess extends CartState {}

class AddToCartError extends CartState {}

class UpdateCartInprogress extends CartState {}

class UpdateCartSuccess extends CartState {}

class UpdateCartError extends CartState {}
