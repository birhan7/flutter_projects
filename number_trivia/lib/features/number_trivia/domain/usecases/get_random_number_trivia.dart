import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../repositories/number_trivia_repository.dart';
import '../../../../core/error/failure.dart';
import '../entities/number_trivia.dart';
import '../../../../core/usecase/usecase.dart';

class GetRandomNumberTrivia implements Usecase<NumberTrivia, NoParams>{
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);
  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async{
    return await repository.getRandomNumberTrivia();
  }
}

class NoParams extends Equatable{
  @override
  List<Object?> get props => [];
}