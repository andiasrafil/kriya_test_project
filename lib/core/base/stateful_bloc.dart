import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_bloc.dart';
import 'event_bloc.dart';
import 'state_bloc.dart';

abstract class StatefulBloc<S extends StatefulWidget, B extends BaseBloc<E, ST>,
    ST extends StateBloc, E extends EventBloc> extends State<S> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  B bloc() => BlocProvider.of<B>(context);
  double? height;
  double? width;

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
  }

  void setSize(BuildContext context) {}

  /// Variable contains height of the on-screen keyboard
  double keyboardHeight = 0.0;

  void calculateBottomInsets() {
    keyboardHeight = EdgeInsets.fromWindowPadding(
      WidgetsBinding.instance!.window.viewInsets,
      WidgetsBinding.instance!.window.devicePixelRatio,
    ).bottom;
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    calculateBottomInsets();
    return body(context);
  }

  Widget createBloc({required Widget child}) {
    return BlocProvider<B>(
        create: (context) => BlocProvider.of<B>(context), child: child);
  }

  Widget blocSelector<V>({
    required BlocWidgetBuilder<V> builder,
    required BlocWidgetSelector<ST, V> d,
  }) {
    return BlocSelector<B, ST, V>(selector: d, builder: builder);
  }

  Widget body(BuildContext context);


  void pushEvent(
    E event,
  ) {
    BlocProvider.of<B>(context).add(event);
  }

  void initEvent(
    E event,
  ) {
    Future.delayed(const Duration(milliseconds: 300), () => pushEvent(event));
  }

  void initVoid(void function) {
    Future.delayed(const Duration(milliseconds: 300), () => function);
  }

  Widget blocBuilder({required BlocWidgetBuilder<ST> builder}) {
    return BlocBuilder<B, ST>(builder: builder);
  }

  Widget blocListener({
    required void Function(BuildContext, ST) listener,
    required Widget child,
  }) {
    return BlocListener<B, ST>(
      listener: listener,
      child: child,
    );

    // BlocBuilder<B, ST>(builder: builder);
  }

  @override
  void initState() {
    super.initState();
  }

  void pushState(FrameCallback st) {
    WidgetsBinding.instance!.addPostFrameCallback(st);
  }

  Future<void> closeKeyboard({
    bool condition = true,
  }) async {
    if (condition) {
      return await Future.delayed(
        const Duration(milliseconds: 1),
        () => FocusScope.of(context).unfocus(),
      );
    }
  }
}
