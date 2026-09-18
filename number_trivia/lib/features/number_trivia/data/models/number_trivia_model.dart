import '../../domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia{

  final String text;
  final int number;

  const NumberTriviaModel({required this.text, required this.number}) : super(text: text, number: number);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> jsonMap){
    return NumberTriviaModel(text: jsonMap['text'], number: (jsonMap['number'] as num).toInt());
  }

  Map<String, dynamic> toJson(){
    return {
      'text': text,
      'number': number
    };
  }
}