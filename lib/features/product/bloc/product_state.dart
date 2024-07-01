part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  final List<String> products;
  final bool loading;
  final bool error;

  const ProductState({
    this.products = const [],
    this.loading = false,
    this.error = false,
  });

  @override
  List<Object> get props => [products, loading, error];
}

class ProductInitial extends ProductState {
  const ProductInitial() : super();
}

class ProductLoading extends ProductState {
  const ProductLoading() : super(loading: true);
}

class ProductLoaded extends ProductState {
  const ProductLoaded(List<String> products) : super(products: products);
}

class ProductError extends ProductState {
  const ProductError() : super(error: true);
}
