import 'package:dartz/dartz.dart';
import 'package:kriya_test_project/core/error/failures.dart';
import 'package:kriya_test_project/domain/entities/home_data.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<HomeData>>> getInitialData();
}
