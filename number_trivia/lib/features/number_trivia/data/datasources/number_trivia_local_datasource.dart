import 'dart:convert';

import 'package:number_trivia/core/error/exception.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDatasource {
  Future<NumberTriviaModel> getLastNumberNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA'; 

class NumberTriviaLocalDatasourceImpl implements NumberTriviaLocalDatasource{
  final SharedPreferencesWithCache sharedPreferencesWithCache;

  NumberTriviaLocalDatasourceImpl(this.sharedPreferencesWithCache);


  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache) {
    return sharedPreferencesWithCache.setString(CACHED_NUMBER_TRIVIA, jsonEncode(triviaToCache));
  }

  @override
  Future<NumberTriviaModel> getLastNumberNumberTrivia() {
    final jsonString = sharedPreferencesWithCache.getString(CACHED_NUMBER_TRIVIA);
    if (jsonString != null){
      return Future.value(NumberTriviaModel.fromJson(jsonDecode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}