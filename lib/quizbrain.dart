import 'question.dart';

class Quizbrain {
  int _questionNumber = 0;
  List<Question> _questionBank = [
    Question(' In C, the keyword function is used to declare a function.', false),
    Question('The sizeof operator in C returns the size of a variable in bytes.', true),
    Question('In C, the ++ operator increments the value of a variable by 2.', false),
    Question('The scanf function is used for formatted output in C', false),
    Question(' A single-line comment in C starts with the symbol //.', true),
    Question('NULL is a keyword in C.', false),
    Question(
        'The switch statement can be used with floating-point numbers in C.',
        false),
    Question(
        'The printf function is used to input data in C.',
        false),
    Question(
        'The sizeof operator can be used to find the size of any data type in C.',
        true),
    Question(
        'A variable declared as static in a function in C retains its value between function calls.',
        true),

  ];
  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestion() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      print('Now returning true');
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}
