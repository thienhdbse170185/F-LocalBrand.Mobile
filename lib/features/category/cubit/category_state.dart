part of 'category_cubit.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

class GetCategoriesLoading extends CategoryState {}

class GetCategoriesSuccess extends CategoryState {
  final List<CategoryDto> categories;

  GetCategoriesSuccess({required this.categories});

  @override
  List<Object> get props => [categories];
}

class GetCategoriesFailure extends CategoryState {}

class GetCategoriesProductsLoading extends CategoryState {}

class GetCategoriesProductsSuccess extends CategoryState {
  final List<CategoryDto> categories;

  GetCategoriesProductsSuccess({required this.categories});

  @override
  List<Object> get props => [categories];
}

class GetCategoriesProductsFailure extends CategoryState {}
