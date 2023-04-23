import 'package:dartz/dartz.dart';
import 'package:spots/domain/core/errors/failures.dart';
import 'package:spots/flows/menu/domain/entities/marker_point.dart';

abstract class MarkersRepositoryI {
  Future<Either<Failure, List<MarkerPoint>>> getMarkers(String userId);
}
