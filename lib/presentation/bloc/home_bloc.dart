import 'package:kriya_test_project/core/base/base_bloc.dart';
import 'package:kriya_test_project/core/base/event_bloc.dart';
import 'package:kriya_test_project/core/base/state_bloc.dart';
import 'package:kriya_test_project/core/usecase/usecase.dart';
import 'package:kriya_test_project/domain/entities/home_data.dart';
import 'package:kriya_test_project/domain/usecase/get_home_data.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  GetHomeData getHomeData = GetHomeData.instance();
  List<HomeData> productsInCart = [];

  HomeBloc() : super(InitialHomeState()) {
    on<GetHomeDataEvent>((event, emit) async {
      emit(LoadingHomeDataState());
      final datas = await getHomeData(NoParams());
      datas.fold((l) {}, (r) {
        emit(SuccessGetHomeDataState(r));
      });
    });

    on<AddItemToCart>((event, emit) {
      emit(AddingItemToCart());
      var isItemAlreadyIncart =
          productsInCart.where((element) => element.id == event.data.id);
      if (isItemAlreadyIncart.isNotEmpty) {
        isItemAlreadyIncart.first.qty++;
      } else {
        event.data.qty++;
        productsInCart.add(event.data);
      }
      var totalProducts = 0;
      for (var i = 0; i < productsInCart.length; i++) {
        totalProducts = totalProducts + productsInCart[i].qty;
      }
      emit(SuccessAddToCart(productsInCart, totalProducts));
    });

    on<RemoveItemFromCart>((event, emit) {
      emit(RemovingItemFromCart());
      var itemInCart =
          productsInCart.where((element) => element.id == event.data.id);
      if (itemInCart.first.qty == 1) {
        event.data.qty--;
        productsInCart.remove(itemInCart.first);
      } else {
        event.data.qty--;
      }
      var totalProducts = 0;
      for (var i = 0; i < productsInCart.length; i++) {
        totalProducts = totalProducts + productsInCart[i].qty;
      }
      emit(SuccessRemoveItemFromCart(totalProducts));
    });

    on<DoCheckout>((event, emit) {
      emit(NavigatingToSecondPage());
      var totalProducts = 0;
      for (var i = 0; i < productsInCart.length; i++) {
        totalProducts = totalProducts + productsInCart[i].qty;
      }
      emit(NavigateToSecondPage(productsInCart, totalProducts));
    });

    on<BuyProducts>((event, emit) {
      //emit(BuyingProducts());
      emit(SuccessBuyingProducts());
    });
  }
}
