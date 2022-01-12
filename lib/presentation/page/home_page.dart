import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kriya_test_project/core/base/stateful_bloc.dart';
import 'package:kriya_test_project/domain/entities/home_data.dart';
import 'package:kriya_test_project/presentation/bloc/home_bloc.dart';
import 'package:kriya_test_project/presentation/bloc/home_bloc.dart';
import 'package:kriya_test_project/presentation/page/second_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState
    extends StatefulBloc<HomePage, HomeBloc, HomeState, HomeEvent> {
  List<HomeData> datas = [];
  int totalProducts = 0;

  @override
  void initState() {
    super.initState();
    pushEvent(GetHomeDataEvent());
  }

  @override
  Widget body(BuildContext context) {
    return Material(
      child: blocListener(
        listener: (BuildContext context, state) {
          if (state is SuccessGetHomeDataState) {
            setState(() {
              datas = state.data;
            });
          } else if (state is SuccessAddToCart) {
            setState(() {
              totalProducts = state.totalProducts;
            });
          } else if (state is NavigateToSecondPage) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SecondPage(
                    datas: state.listProducts,
                    totalProducts: state.totalProducts)));
          } else if (state is SuccessBuyingProducts) {
            pushEvent(GetHomeDataEvent());
            setState(() {
              totalProducts = 0;
            });
          } else if (state is SuccessRemoveItemFromCart) {
            setState(() {
              totalProducts = state.totalProducts;
            });
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("product list"),
            actions: [
              Center(child: Text("quantity : $totalProducts")),
              SizedBox(
                width: 40,
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.separated(
                    itemBuilder: (BuildContext context, position) {
                      final data = datas[position];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(flex: 6, child: Text(data.title!)),
                          Expanded(
                              flex: 1,
                              child: GestureDetector(
                                  onTap: () {
                                    pushEvent(AddItemToCart(data));
                                  },
                                  child: const Icon(Icons.remove, size: 40))),
                          Expanded(
                              flex: 1,
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: Center(child: Text(data.qty.toString())),
                              )),
                          Expanded(
                              flex: 1,
                              child: GestureDetector(
                                  onTap: () {
                                    if (data.qty > 0) {
                                      pushEvent(RemoveItemFromCart(data));
                                    }
                                  },
                                  child: const Icon(Icons.remove, size: 40))),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, position) {
                      return const Divider();
                    },
                    itemCount: datas.length),
              ),
              ElevatedButton(
                  onPressed: () {
                    pushEvent(DoCheckout());
                  },
                  child: Text("checkout"))
            ],
          ),
        ),
      ),
    );
  }
}
