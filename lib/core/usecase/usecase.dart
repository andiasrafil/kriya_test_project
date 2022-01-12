import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:kriya_test_project/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params param);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
