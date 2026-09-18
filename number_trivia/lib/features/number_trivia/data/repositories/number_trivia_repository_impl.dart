import 'package:dartz/dartz.dart';
import 'package:number_trivia/core/error/exception.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/number_trivia_local_datasource.dart';
import '../datasources/number_trivia_remote_datasource.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImpl implements NumberTriviaRepository{
  final NumberTriviaRemoteDatasource remoteDatasource;
  final NumberTriviaLocalDatasource localDatasource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({required this.remoteDatasource, required this.localDatasource, required this.networkInfo});

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) async {
    return await _getTrivia((){return remoteDatasource.getConcreteNumberTrivia(number);});
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia((){return remoteDatasource.getRandomNumberTrivia();});
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(Future<NumberTriviaModel> Function() getConcreteOrRandomTrivia) async{
    if (await networkInfo.isConnected){
      try{
        final remoteTrivia = await getConcreteOrRandomTrivia();
        localDatasource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
    } on ServerException{
        return Left(ServerFailure());
    }
    } else {
      try{
        final localTrivia = await localDatasource.getLastNumberNumberTrivia();
        return Right(localTrivia);
      } on CacheException{
        return Left(CacheFailure());
      }
    }
  }
}