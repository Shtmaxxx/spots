import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spots/domain/core/errors/failures.dart';

import '../usecases/sign_in.dart';

abstract class AuthRepositoryI {
  Future<Either<Failure, UserCredential>> signIn(SignInParams params);
  Future<Either<Failure, UserCredential>> signUp(SignInParams params);
  Future<Either<Failure, void>> signOut();
}
