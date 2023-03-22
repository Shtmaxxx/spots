import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spots/domain/core/errors/failures.dart';
import 'package:spots/domain/core/usecase/usecase.dart';
import 'package:spots/flows/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignInUseCase implements UseCase<UserCredential, SignInParams> {
  final AuthRepositoryI repository;

  SignInUseCase(this.repository);

  @override
  Future<Either<Failure, UserCredential>> call(SignInParams parameters) async {
    return await repository.signIn(parameters);
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({
    required this.email,
    required this.password,
  });
}
