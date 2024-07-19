import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:f_localbrand/features/collection/data/collection_repository.dart';
import 'package:f_localbrand/features/collection/dto/collection_dto.dart';

part 'collection_state.dart';

class CollectionCubit extends Cubit<CollectionState> {
  CollectionCubit({required this.collectionRepository})
      : super(CollectionInitial());
  final CollectionRepository collectionRepository;

  Future<void> getCollectionList() async {
    emit(GetAllCollectionInprogress());
    try {
      final response = await collectionRepository.getCollectionList();
      emit(GetAllCollectionSuccess(collections: response));
    } catch (e) {
      emit(GetAllCollectionError());
    }
  }
}
