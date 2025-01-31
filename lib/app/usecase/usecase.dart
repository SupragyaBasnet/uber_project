import 'package:dartz/dartz.dart';


import '../../core/error/failure.dart';

/// **Generic UseCase Interface (With Parameters)**
abstract interface class UsecaseWithParams<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

/// **Generic UseCase Interface (Without Parameters)**
abstract interface class UsecaseWithoutParams<SuccessType> {
  Future<Either<Failure, SuccessType>> call();
}
