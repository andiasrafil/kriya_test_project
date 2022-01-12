import 'package:flutter/material.dart';
import 'package:kriya_test_project/core/base/stateful_bloc.dart';
import 'package:kriya_test_project/domain/entities/home_data.dart';
import 'package:kriya_test_project/presentation/bloc/home_bloc.dart';

class SecondPage extends StatefulWidget {
  SecondPage({Key? key, required this.datas, required this.totalProducts})
      : super(key: key);
  List<HomeData> datas;
  int totalProducts;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState
    extends StatefulBloc<SecondPage, HomeBloc, HomeState, HomeEvent> {
  @override
  Widget body(BuildContext context) {
    return blocListener(
      listener: (BuildContext context, state) {
        if (state is SuccessBuyingProducts) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("product list"),
          actions: [
            Center(child: Text("quantity : ${widget.totalProducts}")),
            SizedBox(
              width: 40,
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: widget.datas.length,
                  itemBuilder: (BuildContext context, position) {
                    final data = widget.datas[position];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(flex: 6, child: Text(data.title!)),
                        Expanded(
                            flex: 1,
                            child: GestureDetector(
                                onTap: () {},
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
                                onTap: () {},
                                child: const Icon(Icons.remove, size: 40))),
                      ],
                    );
                  }),
            ),
            ElevatedButton(
                onPressed: () {
                  pushEvent(BuyProducts());
                },
                child: Text("bayar")),
          ],
        ),
      ),
    );
  }
}
