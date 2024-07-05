import 'package:f_localbrand/screens/filter/widgets/filter_horizontal_item.dart';
import 'package:f_localbrand/screens/filter/widgets/range_slider.dart';
import 'package:f_localbrand/screens/widgets/buttons/back_button.dart';
import 'package:f_localbrand/screens/widgets/buttons/rounded_elevated_button.dart';
import 'package:f_localbrand/screens/widgets/buttons/rounded_outlined_button.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> categories = ['Category 1', 'Category 2', 'Category 3'];
  String selectedCategory = 'Category 1';

  List<String> campaigns = ['Campaign 1', 'Campaign 2', 'Campaign 3'];
  String selectedCampaign = 'Campaign 1';

  List<String> collections = ['Collection 1', 'Collection 2', 'Collection 3'];
  String selectedCollection = 'Collection 1';

  List<String> genders = ['Male', 'Female', 'Unisex'];
  String selectedGender = 'Male';

  List<String> sortBy = ['Name', 'Release Date', 'Price'];
  String selectedSortBy = 'Name';

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text(
          'Filter',
          style: textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 100),
        child: Column(
          children: [
            FilterHorizontalItem(
              key: UniqueKey(),
              title: 'Category',
              categories: categories,
              selectedCategory: selectedCategory,
              onCategoryPressed: (category) {
                setState(() {
                  selectedCategory = category;
                });
              },
            ),
            FilterHorizontalItem(
              key: UniqueKey(),
              title: 'Campaign',
              categories: campaigns,
              selectedCategory: selectedCampaign,
              onCategoryPressed: (campaign) {
                setState(() {
                  selectedCampaign = campaign;
                });
              },
            ),
            FilterHorizontalItem(
              key: UniqueKey(),
              title: 'Collection',
              categories: collections,
              selectedCategory: selectedCollection,
              onCategoryPressed: (collection) {
                setState(() {
                  selectedCollection = collection;
                });
              },
            ),
            FilterHorizontalItem(
              key: UniqueKey(),
              title: 'Gender',
              categories: genders,
              selectedCategory: selectedGender,
              onCategoryPressed: (gender) {
                setState(() {
                  selectedGender = gender;
                });
              },
            ),
            FilterHorizontalItem(
              key: UniqueKey(),
              title: 'Sort by',
              categories: sortBy,
              selectedCategory: selectedSortBy,
              onCategoryPressed: (sort) {
                setState(() {
                  selectedSortBy = sort;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Price Range', style: textTheme.headlineSmall),
                  CustomRangeSlider(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedOutlinedButton(
              title: 'Reset Filter',
              onPressed: () {},
              padding: EdgeInsets.symmetric(horizontal: 36, vertical: 16),
            ),
            const SizedBox(
              width: 10,
            ),
            RoundedElevatedButton(
              title: 'Apply',
              onPressed: () {},
              padding: EdgeInsets.symmetric(horizontal: 52, vertical: 16),
            ),
          ],
        ),
      ),
    );
  }
}
