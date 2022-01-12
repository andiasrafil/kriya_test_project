import 'package:kriya_test_project/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:kriya_test_project/core/usecase/usecase.dart';
import 'package:kriya_test_project/data/repositories/home_repository_impl.dart';
import 'package:kriya_test_project/domain/entities/home_data.dart';
import 'package:kriya_test_project/domain/repositories/home_repository.dart';

class GetHomeData extends UseCase<List<HomeData>, NoParams> {
  late HomeRepository repository;
  GetHomeData.instance() {
    repository = HomeRepositoryImpl.getInstance();
  }

  @override
  Future<Either<Failure, List<HomeData>>> call(NoParams param) async {
    return await repository.getInitialData();
  }
}
