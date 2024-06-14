import 'package:flutter/material.dart';
import 'package:quizzler4/quizbrain.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: QuizWelcomeScreen(),
        ),
      ),
    );
  }
}

class QuizWelcomeScreen extends StatefulWidget {
  @override
  _QuizWelcomeScreenState createState() => _QuizWelcomeScreenState();
}

class _QuizWelcomeScreenState extends State<QuizWelcomeScreen> {
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Hero(
            tag: 'app_logo',
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50.0,
              child: Icon(
                Icons.school,
                color: Colors.blue,
                size: 50.0,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Welcome to Quizzler!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Enter your name',
              labelStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizPage(
                    playerName: _nameController.text,
                  ),
                ),
              );
            },
            child: Text('Start Quiz'),
          ),
        ],
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  final String playerName;

  const QuizPage({Key? key, required this.playerName}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scorekeeper = [];
  int correctCount = 0;
  late Quizbrain quizbrain;

  @override
  void initState() {
    super.initState();
    quizbrain = Quizbrain();
  }

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizbrain.getAnswer();

    setState(() {
      if (quizbrain.isFinished()) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QuizExitScreen(
              playerName: widget.playerName,
              score: correctCount,
            ),
          ),
        );
      } else {
        if (userPickedAnswer == correctAnswer) {
          correctCount++;
          scorekeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scorekeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizbrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  quizbrain.getQuestion(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  textStyle: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  checkAnswer(true);
                },
                child: const Text('True'),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  textStyle: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  checkAnswer(false);
                },
                child: const Text(
                  'False',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: scorekeeper,
          )
        ],
      ),
    );
  }
}

class QuizExitScreen extends StatelessWidget {
  final String playerName;
  final int score;

  const QuizExitScreen({Key? key, required this.playerName, required this.score})
      : super(key: key);

  String getMessage() {
    if (score <= 4) {
      return 'Start studying! It\'s high time.';
    } else if (score >= 5 && score <= 7) {
      return 'Good effort! Keep it up.';
    } else {
      return 'Great job! You nailed it!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Quiz Completed, $playerName!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Your Score: $score',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              getMessage(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Quizzler(),
                  ),
                );
              },
              child: Text('Restart Test'),
            ),
          ],
        ),
      ),
    );
  }
}