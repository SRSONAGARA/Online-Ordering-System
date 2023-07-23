import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oline_ordering_system/Bloc/ViewsBloc/app_pages/product_screen/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final searchController = TextEditingController();
  bool searchButton = false;
  Icon customSearchIcon = const Icon(
    Icons.search,
    color: Colors.white,
  );
  Icon customMenuIcon = const Icon(
    Icons.menu,
    color: Colors.white,
  );

  Widget customText = const Text(
    "Ordefy",
    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
  );

  SearchCubit() : super(SearchInitialState());

  void searchButtonPress() {
    searchButton = true;
    customSearchIcon = const Icon(
      Icons.clear_outlined,
      color: Colors.white,
    );
    emit(SearchButtonPressedState());
  }

  void searchButtonUnPress() {
    searchController.clear();
    searchButton = false;
    customSearchIcon = const Icon(
      Icons.search,
      color: Colors.white,
    );
    customText = const Text(
      "Ordefy",
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
    );
    emit(SearchButtonUnpressedState());
  }

  void searchListIsEmpty() {
    emit(SearchListEmptyState());
  }

  void searchListIsNotEmpty() {
    emit(SearchListNotEmptyState());
  }
}
