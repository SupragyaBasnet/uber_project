// import 'package:dartz/dartz.dart';
// import 'package:easygo/core/error/failure.dart';
//
// /// Base class for use cases that take parameters.
// /// [SuccessType] represents the type of the result on success.
// /// [Params] represents the input parameters for the use case.
// abstract class UsecaseWithParams<SuccessType, Params> {
//   Future<Either<Failure, SuccessType>> call(Params params);
// }
//
// /// Base class for use cases that do not take any parameters.
// /// [SuccessType] represents the type of the result on success.
// abstract class UsecaseWithoutParams<SuccessType> {
//   Future<Either<Failure, SuccessType>> call();
// }

abstract class UseCase<Type, Params> {
  /// Executes the use case with the given parameters.
  Future<Type> call(Params params);
}

class NoParams {
  /// A placeholder for use cases that do not require any parameters.
  const NoParams();
}
