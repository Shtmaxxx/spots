import 'package:dartz/dartz.dart';
import 'package:spots/domain/core/errors/failures.dart';
import 'package:spots/domain/core/usecase/usecase.dart';
import 'package:spots/flows/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignOutUseCase implements UseCase<void, NoParams> {
  final AuthRepositoryI repository;

  SignOutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams noParams) async {
    return await repository.signOut();
  }
}
