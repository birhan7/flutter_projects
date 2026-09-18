import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/exception.dart';
import 'package:number_trivia/core/error/failure.dart';
import 'package:number_trivia/core/network/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'number_trivia_repository_impl_test.mocks.dart';

@GenerateMocks([
  NumberTriviaRemoteDatasource,
  NumberTriviaLocalDatasource,
  NetworkInfo
])
void main(){

  late NumberTriviaRepositoryImpl repository;
  late MockNumberTriviaLocalDatasource mockLocalDatasource;
  late MockNumberTriviaRemoteDatasource mockRemoteDatasource;
  late MockNetworkInfo mockNetworkInfo;

  setUp((){
    mockRemoteDatasource = MockNumberTriviaRemoteDatasource();
    mockLocalDatasource = MockNumberTriviaLocalDatasource();
    mockNetworkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
      remoteDatasource: mockRemoteDatasource,
      localDatasource: mockLocalDatasource,
      networkInfo: mockNetworkInfo
    );
  });

    final tNumber = 7;
    final tNumberTriviaModel = NumberTriviaModel(text: "Trinity Number", number: tNumber);

    void runTestOnline(Function body){
      group('Device is Online', (){

        setUp((){
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          });
          body();
          });
          }

    void runTestoffline(Function body){
      group('Device is Offline', (){

        setUp((){
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
          });
          body();
          });
          }


    group('Get Concrete Number Trivia', (){

      runTestOnline((){

        setUp((){
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          });

    test('should return remote data when call to remote data source is successfull', () async {
      // arrange
      when(mockRemoteDatasource.getConcreteNumberTrivia(tNumber)).thenAnswer((_) async => tNumberTriviaModel);
      // act
      final result = await repository.getConcreteNumberTrivia(tNumber);
      // assert
      verify(mockRemoteDatasource.getConcreteNumberTrivia(tNumber));
      expect(result, equals(Right(tNumberTriviaModel)));
    });



    test('should cache the data locally when the call to remote data source is successfull', () async {
      // arrange
      when(mockRemoteDatasource.getConcreteNumberTrivia(tNumber)).thenAnswer((_) async => tNumberTriviaModel);
      // act
      await repository.getConcreteNumberTrivia(tNumber);
      // assert
      verify(mockRemoteDatasource.getConcreteNumberTrivia(tNumber));
      verify(mockLocalDatasource.cacheNumberTrivia(tNumberTriviaModel));
    });



    test('should return ServerFailure when the call to remote data source is unsuccessfull', () async {
      // arrange
      when(mockRemoteDatasource.getConcreteNumberTrivia(tNumber)).thenThrow(ServerException());
      // act
      final result = await repository.getConcreteNumberTrivia(tNumber);
      // assert
      verify(mockRemoteDatasource.getConcreteNumberTrivia(tNumber));
      verifyZeroInteractions(mockLocalDatasource);
      expect(result, equals(Left(ServerFailure())));
      });
    });

      runTestoffline((){

    setUp((){
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });


    test('should return last locally cached data when cached data is present', () async {
      // arrange
      when(mockLocalDatasource.getLastNumberNumberTrivia()).thenAnswer((_) async => tNumberTriviaModel);
      // act
      final result = await repository.getConcreteNumberTrivia(tNumber);
      // assert
      verifyZeroInteractions(mockRemoteDatasource);
      verify(mockLocalDatasource.getLastNumberNumberTrivia());
      expect(result, Right(tNumberTriviaModel));
    });



    test('should return CacheFailure  when cached data is not present', () async {
      // arrange
      when(mockLocalDatasource.getLastNumberNumberTrivia()).thenThrow(CacheException());
      // act
      final result = await repository.getConcreteNumberTrivia(tNumber);
      // assert
      verifyZeroInteractions(mockRemoteDatasource);
      verify(mockLocalDatasource.getLastNumberNumberTrivia());
      expect(result, Left(CacheFailure()));
    });
  });
    });








      group('Get Random Number Trivia', (){

      runTestOnline((){

        setUp((){
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          });

    test('should return remote data when call to remote data source is successfull', () async {
      // arrange
      when(mockRemoteDatasource.getRandomNumberTrivia()).thenAnswer((_) async => tNumberTriviaModel);
      // act
      final result = await repository.getRandomNumberTrivia();
      // assert
      verify(mockRemoteDatasource.getRandomNumberTrivia());
      expect(result, equals(Right(tNumberTriviaModel)));
    });



    test('should cache the data locally when the call to remote data source is successfull', () async {
      // arrange
      when(mockRemoteDatasource.getRandomNumberTrivia()).thenAnswer((_) async => tNumberTriviaModel);
      // act
      await repository.getRandomNumberTrivia();
      // assert
      verify(mockRemoteDatasource.getRandomNumberTrivia());
      verify(mockLocalDatasource.cacheNumberTrivia(tNumberTriviaModel));
    });



    test('should return ServerFailure when the call to remote data source is unsuccessfull', () async {
      // arrange
      when(mockRemoteDatasource.getRandomNumberTrivia()).thenThrow(ServerException());
      // act
      final result = await repository.getRandomNumberTrivia();
      // assert
      verify(mockRemoteDatasource.getRandomNumberTrivia());
      verifyZeroInteractions(mockLocalDatasource);
      expect(result, equals(Left(ServerFailure())));
      });
    });

      runTestoffline((){

    setUp((){
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });


    test('should return last locally cached data when cached data is present', () async {
      // arrange
      when(mockLocalDatasource.getLastNumberNumberTrivia()).thenAnswer((_) async => tNumberTriviaModel);
      // act
      final result = await repository.getRandomNumberTrivia();
      // assert
      verifyZeroInteractions(mockRemoteDatasource);
      verify(mockLocalDatasource.getLastNumberNumberTrivia());
      expect(result, Right(tNumberTriviaModel));
    });



    test('should return CacheFailure  when cached data is not present', () async {
      // arrange
      when(mockLocalDatasource.getLastNumberNumberTrivia()).thenThrow(CacheException());
      // act
      final result = await repository.getRandomNumberTrivia();
      // assert
      verifyZeroInteractions(mockRemoteDatasource);
      verify(mockLocalDatasource.getLastNumberNumberTrivia());
      expect(result, Left(CacheFailure()));
    });
  });
    });
    
}