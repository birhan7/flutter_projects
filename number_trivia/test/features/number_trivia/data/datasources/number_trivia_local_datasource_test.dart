import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:number_trivia/core/error/exception.dart';
import 'package:number_trivia/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../fixture/fixture.dart';
import 'number_trivia_local_datasource_test.mocks.dart';


@GenerateMocks([SharedPreferencesWithCache])
void main(){
  late MockSharedPreferencesWithCache sharedPreferencesWithCache;
  late NumberTriviaLocalDatasourceImpl datasource;

  setUp((){
    sharedPreferencesWithCache = MockSharedPreferencesWithCache();
    datasource = NumberTriviaLocalDatasourceImpl(
      sharedPreferencesWithCache
    );
  });

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(fixture('trivia_cached.json'));
    test('should return number trivia from the shared preferences if there is one', () async {
      // arrange
      when(sharedPreferencesWithCache.getString(any)).thenReturn(jsonEncode(fixture(('trivia_cached.json'))));
      // act
      final result = await datasource.getLastNumberNumberTrivia();
      // assert
      verify(sharedPreferencesWithCache.getString(CACHED_NUMBER_TRIVIA));
      expect(result, equals(tNumberTriviaModel));
    });




    test('should throw CacheException if shared preferences is empty', () async {
      // arrange
      when(sharedPreferencesWithCache.getString(any)).thenReturn(null);
      // act
      final call = datasource.getLastNumberNumberTrivia;
      // assert
      expect(() async => await call(), throwsA(TypeMatcher<CacheException>()));
    });

  });



  group('Cache Number Trivia', (){
    final tNumberTriviaModel = NumberTriviaModel(text: "trinity number", number: 7);
    test('should call the shared preference to cache data', () async {
      // act
      await datasource.cacheNumberTrivia(tNumberTriviaModel);
      // assert
      verify(sharedPreferencesWithCache.setString(CACHED_NUMBER_TRIVIA, jsonEncode(tNumberTriviaModel)));
    });
  });
}