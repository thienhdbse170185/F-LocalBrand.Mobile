import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:f_localbrand/features/product/data/product_repository.dart';
import 'package:f_localbrand/features/product/dto/customer_product_dto.dart';
import 'package:f_localbrand/features/product/dto/product_details.dart';
import 'package:f_localbrand/features/product/dto/product_dto.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({required this.productRepository}) : super(ProductInitial());
  final ProductRepository productRepository;

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

  Future<void> fetchProductDetail(int id) async {
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

  Future<void> getCustomerProduct(int id) async {
    emit(GetCustomerProductInprogress());
    try {
      final products = await productRepository.getCustomerProduct(id);
      emit(GetCustomerProductSuccess(products));
    } catch (e) {
      emit(GetCustomerProductError(e.toString()));
    }
  }

  Future<void> fetchCustomerProductRecommendations(int id) async {
    emit(GetCustomerProductRecommendationsInprogress());
    try {
      final products =
          await productRepository.getCustomerProductRecommendations(id);
      emit(GetCustomerProductRecommendationsSuccess(products));
    } catch (e) {
      emit(GetCustomerProductRecommendationsError(e.toString()));
    }
  }

  Future<void> fetchProductDetailsByName(String name) async {
    emit(GetProductDetailsByNameInprogress());
    try {
      final products =
          await productRepository.fetchProductDetailsByName(name);
      emit(GetProductDetailsByNameSuccess(products));
    } catch (e) {
      emit(GetProductDetailsByNameError(e.toString()));
    }
  }
}
