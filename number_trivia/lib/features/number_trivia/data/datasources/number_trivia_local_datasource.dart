import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDatasource {
  Future<NumberTriviaModel> getLastNumberNumberTrivia();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}