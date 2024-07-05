import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:f_localbrand/features/category/data/category_repository.dart';
import 'package:f_localbrand/features/category/dto/category_dto.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({required this.categoryRepository}) : super(CategoryInitial());
  final CategoryRepository categoryRepository;

  Future<void> getCategories() async {
    emit(GetCategoriesLoading());
    try {
      List<CategoryDto> categories = await categoryRepository.getCategories();
      emit(GetCategoriesSuccess(categories: categories));
    } catch (e) {
      emit(GetCategoriesFailure());
    }
  }
}
