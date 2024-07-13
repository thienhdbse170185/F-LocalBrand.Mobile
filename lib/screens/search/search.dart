import 'package:f_localbrand/features/product/dto/product_home_dto.dart';
import 'package:f_localbrand/screens/home/widgets/product_home.dart';
import 'package:f_localbrand/screens/widgets/inputs/expanded_rounded_icon_input.dart';
import 'package:f_localbrand/screens/widgets/list/vertical_grid_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> _recentSearches = [
    'Blue Shirt',
    'CosmicChic Jacket',
    'EnchantedElegance Dress',
    'WhimsyWhirl Top',
    'Fluffernova Coat',
    'MirageMelody Cape',
    'BlossomBreeze Overalls',
    'EnchantedElegance Dress'
  ];

  List<ProductHomeDto> _productResults = [
    ProductHomeDto(id: 1, name: "Home Shirt", price: 100),
    ProductHomeDto(id: 2, name: "Home Shirt", price: 100),
    ProductHomeDto(id: 3, name: "Home Shirt", price: 100),
    ProductHomeDto(id: 4, name: "Home Shirt", price: 100),
    ProductHomeDto(id: 5, name: "Home Shirt", price: 100),
    ProductHomeDto(id: 6, name: "Home Shirt", price: 100),
    ProductHomeDto(id: 7, name: "Home Shirt", price: 100),
    ProductHomeDto(id: 8, name: "Home Shirt", price: 100),
  ];

  TextEditingController _searchController = TextEditingController();
  bool _isSearched = false;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Search', style: textTheme.headlineSmall),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Row(
                children: [
                  ExpandedRoundedIconInput(
                    textController: _searchController,
                    hintText: "Search",
                    icon: FontAwesomeIcons.magnifyingGlass,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                      if (value.isNotEmpty) {
                        setState(() {
                          _isSearched = true;
                        });
                      } else {
                        setState(() {
                          _isSearched = false;
                        });
                      }
                    },
                  ),
                ],
              )),
          if (!_isSearched) ...[
            Padding(
                padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Recent',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _recentSearches.clear();
                            });
                          },
                          child: Text(
                            'Clear All',
                            style: textTheme.bodyLarge!.copyWith(
                                color: colorScheme.primary,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 10,
                    )
                  ],
                )),
            Expanded(
              child: ListView.builder(
                itemCount: _recentSearches.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_recentSearches[index]),
                    trailing: IconButton(
                      icon: FaIcon(FontAwesomeIcons.circleXmark),
                      onPressed: () {
                        setState(() {
                          _recentSearches.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            )
          ] else ...[
            Container(
              height: 650,
              padding: EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            Text(
                              'Result for "${_searchController.text}"',
                              style: textTheme.headlineSmall,
                            ),
                            Text(
                              '8 founds',
                              style: textTheme.headlineSmall
                                  ?.copyWith(fontSize: 13),
                            )
                          ]))
                    ],
                  ),
                  // VerticalGridList(
                  //     delegate: SliverChildBuilderDelegate(
                  //   (context, index) {
                  //     final product = _productResults[index];
                  //     return ProductHome(product: product);
                  //   },
                  //   childCount: _productResults.length,
                  // ))
                ],
              ),
            )
          ]
        ],
      ),
    );
  }
}
