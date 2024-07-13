part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  final List<ProductDto> products;
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
  const ProductLoaded(List<ProductDto> products) : super(products: products);
}

class ProductError extends ProductState {
  const ProductError() : super(error: true);
}

class ProductNewestLoading extends ProductState {
  const ProductNewestLoading() : super();
}

class ProductNewestLoaded extends ProductState {
  const ProductNewestLoaded(this.productsNewest) : super();
  final List<ProductDto> productsNewest;
}

class ProductNewestError extends ProductState {
  const ProductNewestError() : super();
}

class ProductBestsellerLoaded extends ProductState {
  const ProductBestsellerLoaded(this.productsBestseller) : super();
  final List<ProductDto> productsBestseller;
}

class ProductBestsellerError extends ProductState {
  const ProductBestsellerError() : super();
}

class ProductBestsellerLoading extends ProductState {
  const ProductBestsellerLoading() : super();
}

class ProductDetailsLoading extends ProductState {
  const ProductDetailsLoading() : super();
}

class ProductDetailsLoaded extends ProductState {
  const ProductDetailsLoaded(this.product) : super();
  final ProductDto product;
}

class ProductDetailsError extends ProductState {
  const ProductDetailsError() : super();
}
