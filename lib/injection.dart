import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/bloc/home_bloc.dart';

class Injection {
  Injection._privateConstructor();
  static final Injection _instance = Injection._privateConstructor();
  static Injection get instance => _instance;

  List<BlocProvider> initBloc() =>
      [BlocProvider<HomeBloc>(create: (context) => HomeBloc())];
}