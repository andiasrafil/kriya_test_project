part of 'home_bloc.dart';

abstract class HomeEvent extends EventBloc {
  @override
  List<Object?> get props => [];
}

class GetHomeDataEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class AddItemToCart extends HomeEvent {
  final HomeData data;
  AddItemToCart(this.data);
}

class RemoveItemFromCart extends HomeEvent {
  final HomeData data;
  RemoveItemFromCart(this.data);
}

class DoCheckout extends HomeEvent {}

class BuyProducts extends HomeEvent {}
