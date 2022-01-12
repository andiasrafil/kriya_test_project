import 'package:equatable/equatable.dart';

abstract class StateBloc extends Equatable {
  final String? message;

  const StateBloc({
    this.message,
  });
}
