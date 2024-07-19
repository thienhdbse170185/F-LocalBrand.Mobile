part of 'collection_cubit.dart';

sealed class CollectionState extends Equatable {
  const CollectionState();

  @override
  List<Object> get props => [];
}

final class CollectionInitial extends CollectionState {}

final class GetAllCollectionInprogress extends CollectionState {}

final class GetAllCollectionSuccess extends CollectionState {
  final List<CollectionDto> collections;
  GetAllCollectionSuccess({required this.collections});
}

final class GetAllCollectionError extends CollectionState {}
