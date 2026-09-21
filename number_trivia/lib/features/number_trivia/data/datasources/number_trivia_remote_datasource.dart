import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:number_trivia/core/error/exception.dart';
import '../models/number_trivia_model.dart';


abstract class NumberTriviaRemoteDatasource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDatasourceImpl implements NumberTriviaRemoteDatasource{
  final http.Client client;
  NumberTriviaRemoteDatasourceImpl(this.client);


  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    final uri = Uri(scheme: 'http',host: 'number-trivia.com', path: '$number');
    return _getTrivia(uri);
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async{
    final uri = Uri(scheme: 'http',host: 'number-trivia.com', path: 'random');
    return _getTrivia(uri);
  }

  Future<NumberTriviaModel> _getTrivia(Uri uri) async {
    final response =  await client.get(uri, headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200){
      return NumberTriviaModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
