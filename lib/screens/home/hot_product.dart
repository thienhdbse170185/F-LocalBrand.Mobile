import 'package:f_localbrand/features/collection/cubit/collection_cubit.dart';
import 'package:f_localbrand/features/collection/dto/collection_dto.dart';
import 'package:f_localbrand/screens/home/widgets/product_home.dart';
import 'package:f_localbrand/screens/widgets/list/category_list.dart';
import 'package:f_localbrand/screens/widgets/list/horizontal_grid_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotProduct extends StatefulWidget {
  const HotProduct({super.key});

  @override
  State<HotProduct> createState() => _HotProductState();
}

class _HotProductState extends State<HotProduct> {
  String _selectedCollection = '';
  List<CollectionDto> _collections = [];
  bool _isCollectionsLoading = true;
  List<String> collectionsName = [];

  @override
  void initState() {
    super.initState();
    _fetchCollections();
  }

  void _fetchCollections() {
    context.read<CollectionCubit>().getCollectionList();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BlocListener<CollectionCubit, CollectionState>(
      listener: (context, state) {
        if (state is GetAllCollectionInprogress) {
          setState(() {
            _isCollectionsLoading = true;
          });
        } else if (state is GetAllCollectionSuccess) {
          setState(() {
            _collections = state.collections;
            _isCollectionsLoading = false;
            collectionsName = _collections
                .map((collection) => collection.collectionName)
                .toList();
            if (collectionsName.isNotEmpty) {
              _selectedCollection = collectionsName.first;
            }
          });
        } else if (state is GetAllCollectionError) {
          setState(() {
            _isCollectionsLoading = false;
          });
        }
      },
      child: Column(
        children: [
          Center(
            child: CategoryList(
              colorScheme: colorScheme,
              textTheme: textTheme,
              categories: collectionsName,
              selectedCategory: _selectedCollection,
              onCategoryPressed: (collectionName) {
                setState(() {
                  _selectedCollection = collectionName;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          _isCollectionsLoading
              ? Center(child: CircularProgressIndicator())
              : _selectedCollection.isEmpty
                  ? Text("Please select a collection")
                  : _collections
                          .where((collection) =>
                              collection.collectionName == _selectedCollection)
                          .isEmpty
                      ? Text("No products available in the selected collection")
                      : Container(
                          height: 270,
                          child: HorizontalGridList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final selectedCollection =
                                    _collections.firstWhere(
                                        (collection) =>
                                            collection.collectionName ==
                                            _selectedCollection,
                                        orElse: () => CollectionDto(
                                            collectionName: '',
                                            products: [],
                                            id: 0,
                                            status: ''));
                                if (selectedCollection == null) {
                                  return Center(
                                      child: Text("Collection not found"));
                                }
                                final product =
                                    selectedCollection.products[index];
                                return ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minHeight: 300,
                                    maxHeight: 500,
                                    minWidth: 0,
                                    maxWidth: 200,
                                  ),
                                  child: ProductHome(product: product),
                                );
                              },
                              childCount: _collections
                                  .firstWhere(
                                      (collection) =>
                                          collection.collectionName ==
                                          _selectedCollection,
                                      orElse: () => CollectionDto(
                                          collectionName: '',
                                          products: [],
                                          id: 0,
                                          status: ''))
                                  .products
                                  .length,
                            ),
                          ),
                        ),
        ],
      ),
    );
  }
}
