import 'package:flutter/material.dart';
import 'package:quizz_android/widgets/text_utils.dart';
import 'package:quizz_android/models/question.dart';

class QuizzPage extends StatefulWidget {
  @override
  _QuizzPageState createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {
  Question question;
  List<Question> listQuestions = [
    new Question('Paris est-elle la capitale de la france ? ', true,
        'C\'est bien la capitale', 'paris.jpg'),
    new Question('Paris est-elle la capitale de la belgique ? ', false,
        'En non c\'est la capitale de la france', 'limoges.jpg')
  ];

  int index = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    question = listQuestions[index];
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.5;
    return Scaffold(
        appBar: new AppBar(title: new TextUtils('Quizz | Partie')),
        body: new Center(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              new TextUtils('Question #${index + 1}', color: Colors.black),
              new TextUtils('Score : $score / ${index + 1}', color: Colors.black),
              new Card(
                  elevation: 8.0,
                  child: new Container(
                    height: size,
                    width: size,
                    child: new Image.asset('assets/' + question.imagePath),
                  )),
              new TextUtils(question.question,
                  color: Colors.black, textScaleFactor: 1.3),
              new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    boutonbool(true),
                    boutonbool(false),
                  ])
            ])));
  }

  RaisedButton boutonbool(bool b) {
    return new RaisedButton(
        elevation: 8.0,
        onPressed: (() => dialog(b)),
        color: Colors.green,
        child: TextUtils(b ? "Vrai" : "Faux"));
  }

  Future<Null> dialog(bool b) async {
    bool bonneResponse = (b == question.response);
    String vrai = 'assets/true.png';
    String faux = 'assets/false.png';

    if (bonneResponse) {
      score++;
    }
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new SimpleDialog(
            title: new TextUtils(
              bonneResponse ? 'Bravo' : 'Dommage',
              color: bonneResponse ? Colors.green : Colors.red,
              textScaleFactor: 1.4,
            ),
            contentPadding: EdgeInsets.all(18.0),
            children: <Widget>[
              new Image.asset(bonneResponse ? vrai : faux, fit: BoxFit.cover),
              new Container(height: 20.0),
              new TextUtils(question.explication,
                  textScaleFactor: 1.1, color: Colors.grey[900]),
              new Container(
                height: 20.0,
              ),
              new RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                  getNextQuestion();
                },
                color: Colors.green,
                child: new TextUtils('Question suivante',
                    color: Colors.white, textScaleFactor: 1.2),
              )
            ],
          );
        });
  }

  void getNextQuestion() {
    print('TEST');
  }
}
