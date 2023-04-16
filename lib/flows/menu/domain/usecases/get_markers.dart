import 'package:injectable/injectable.dart';
import 'package:spots/domain/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:spots/domain/core/usecase/usecase.dart';
import 'package:spots/flows/menu/domain/entities/marker_point.dart';
import 'package:spots/flows/menu/domain/repositories/markers_repository.dart';

@injectable
class GetMarkersUseCase implements UseCase<List<MarkerPoint>, NoParams> {
  final MarkersRepositoryI repository;

  GetMarkersUseCase(this.repository);

  @override
  Future<Either<Failure, List<MarkerPoint>>> call(NoParams noParams) async {
    return await repository.getMarkers();
  }
}