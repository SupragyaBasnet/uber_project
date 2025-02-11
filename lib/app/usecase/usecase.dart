import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';

// Generic Use Case Interface with Parameters
abstract interface class UsecaseWithParams<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

// Generic Use Case Interface without Parameters
abstract interface class UsecaseWithoutParams<SuccessType> {
  Future<Either<Failure, SuccessType>> call();
}
