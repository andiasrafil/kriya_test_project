import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'event_bloc.dart';
import 'state_bloc.dart';

abstract class BaseBloc<T extends EventBloc, P extends StateBloc>
    extends Bloc<T, P> {
  BaseBloc(P initialState) : super(initialState);

  BuildContext? context;
}
