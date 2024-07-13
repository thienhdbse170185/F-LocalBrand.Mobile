import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:f_localbrand/features/product/data/product_repository.dart';
import 'package:f_localbrand/features/product/dto/product_dto.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({required this.productRepository}) : super(ProductInitial());
  final ProductRepository productRepository;

  Future<void> fetchProducts(String filter) async {
    emit(ProductLoading());
    try {
      // Call the API or any async operation here
      filter = filter.toLowerCase();
      final products = await productRepository.getProductsByFilter(filter);
      emit(ProductLoaded(products));
    } catch (e) {
      emit(const ProductError());
    }
  }

  Future<void> fetchProductsNewest() async {
    emit(ProductNewestLoading());
    try {
      final products = await productRepository.getProductsNewest();
      emit(ProductNewestLoaded(products));
    } catch (e) {
      emit(const ProductNewestError());
    }
  }

  Future<void> fetchProductsBestseller() async {
    emit(ProductBestsellerLoading());
    try {
      final products = await productRepository.getProductsBestseller();
      emit(ProductBestsellerLoaded(products));
    } catch (e) {
      emit(const ProductBestsellerError());
    }
  }

  Future<void> getProductDetail(int id) async {
    emit(ProductDetailsLoading());
    try {
      final product = await productRepository.getProductDetail(id);
      if (product != null) {
        emit(ProductDetailsLoaded(product));
        return;
      }
      emit(ProductDetailsError());
    } catch (e) {
      emit(const ProductDetailsError());
    }
  }
}
