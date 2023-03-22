import 'package:spots/flows/auth/domain/usecases/sign_in.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spots/domain/core/errors/failures.dart';
import 'package:spots/domain/core/usecase/usecase.dart';
import 'package:spots/flows/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpUseCase implements UseCase<UserCredential, SignInParams> {
  final AuthRepositoryI repository;

  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, UserCredential>> call(SignInParams parameters) async {
    return await repository.signUp(parameters);
  }
}
