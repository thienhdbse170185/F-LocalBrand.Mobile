part of 'product_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();
}

final class ProductInitial extends ProductState {
  @override
  List<Object> get props => [];
}
