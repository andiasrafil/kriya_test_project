part of 'home_bloc.dart';

abstract class HomeState extends StateBloc {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class InitialHomeState extends HomeState {
  @override
  List<Object?> get props => [];
}

class LoadingHomeDataState extends HomeState {
  @override
  List<Object?> get props => [];
}

class SuccessGetHomeDataState extends HomeState {
  final List<HomeData> data;
  SuccessGetHomeDataState(this.data);
}

class SuccessAddToCart extends HomeState {
  final List<HomeData> data;
  final int totalProducts;
  SuccessAddToCart(this.data, this.totalProducts);
}

class AddingItemToCart extends HomeState {}

class NavigatingToSecondPage extends HomeState {}

class NavigateToSecondPage extends HomeState {
  final List<HomeData> listProducts;
  final int totalProducts;
  NavigateToSecondPage(this.listProducts, this.totalProducts);
}

class RemovingItemFromCart extends HomeState {}

class SuccessRemoveItemFromCart extends HomeState {
  final int totalProducts;
  SuccessRemoveItemFromCart(this.totalProducts);
}

class BuyingProducts extends HomeState {}

class SuccessBuyingProducts extends HomeState {}
