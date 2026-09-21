import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/exception.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:http/http.dart' as http;
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import '../../../../fixture/fixture.dart';
import 'number_trivia_remote_datasource_test.mocks.dart';


@GenerateMocks([http.Client])
void main(){
  late MockClient httpClient;
  late NumberTriviaRemoteDatasourceImpl datasource;

  setUp((){
    httpClient = MockClient();
    datasource = NumberTriviaRemoteDatasourceImpl(httpClient);
  });

  void setUpMockHttpClientSuccess200(){
    when(httpClient.get(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response(jsonEncode(fixture('trivia.json')), 200));
  }

  void setUpMockHttpClientFailure404(){
    when(httpClient.get(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response("Something went wrong.", 404));
  }

  group('Get Concrete Number Trivia', (){
    final tNumber = 42;
    final tNumberTriviaModel = NumberTriviaModel.fromJson(fixture('trivia.json'));
    test('should perform a GET request on a URL with the endpoint being the number and Header as application/json', () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      await datasource.getConcreteNumberTrivia(tNumber);
      // assert
      verify(httpClient.get(Uri(scheme: 'http',host: 'number-trivia.com', path: '$tNumber'), headers: {'Content-Type': 'application/json'}));
    });



    test('should return Number trivia when the status code is 200(success)', () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await datasource.getConcreteNumberTrivia(tNumber);
      // assert
      expect(result, equals(tNumberTriviaModel));
    });



    test('should throw ServerException when the response code is 404 or other', () async {
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = datasource.getConcreteNumberTrivia;
      // assert
      expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
    });

  });



  group('Get random Number Trivia', (){
    final tNumberTriviaModel = NumberTriviaModel.fromJson(fixture('trivia.json'));
  
    test('should perform a GET request on a URL with the endpoint being /random and Header as application/json', () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      await datasource.getRandomNumberTrivia();
      // assert
      verify(httpClient.get(Uri(scheme: 'http',host: 'number-trivia.com', path: 'random'), headers: {'Content-Type': 'application/json'}));
    });



    test('should return Number trivia when the status code is 200(success)', () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await datasource.getRandomNumberTrivia();
      // assert
      expect(result, equals(tNumberTriviaModel));
    });



    test('should throw ServerException when the response code is 404 or other', () async {
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = datasource.getRandomNumberTrivia;
      // assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });

  });
}