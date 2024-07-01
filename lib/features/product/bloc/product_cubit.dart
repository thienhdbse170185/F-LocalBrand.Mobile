import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:f_localbrand/features/product/data/product_repository.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({required this.productRepository}) : super(ProductInitial());
  final ProductRepository productRepository;

  Future<void> fetchProducts(String filter) async {
    emit(ProductLoading());
    try {
      // Call the API or any async operation here
      final products = await productRepository.getProductsByFilter(filter);
      emit(ProductLoaded(products));
    } catch (e) {
      emit(const ProductError());
    }
  }
}
