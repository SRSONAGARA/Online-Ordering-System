abstract class ProductScreenState {}

class ProductScreenInitialState extends ProductScreenState {}

class ProductScreenLoadingState extends ProductScreenState {}

class ProductScreenSuccessState extends ProductScreenState {}

class ProductScreenErrorState extends ProductScreenState {}

class ProductScreenWatchListBtnLoadingState extends ProductScreenState {
  final int index;

  ProductScreenWatchListBtnLoadingState(this.index);
}

class ProductScreenWatchListBtnSuccessState extends ProductScreenState {}
