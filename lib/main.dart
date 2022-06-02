import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '/question_main.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Quizzler',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: MyPage(),
        backgroundColor: Colors.deepPurpleAccent,
      ),
    ),
  );
}

class MyPage extends StatefulWidget {
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List<Icon> checkingList = [];

  void checkAnswer(bool answer){
    bool userAnswer = answer;
    if(questions.isFinished()){
      setState(() {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
          buttons: [
            DialogButton(
              child: Text(
                "RESET",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();

        questions.resetIndex();

        checkingList = [];
      });
    }
    else{
      if(userAnswer==questions.getAnswerText()){
        checkingList.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ));
      }
      else{
        checkingList.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ));
      }
      questions.nextQuestion();
    }
  }



QuestionList questions = QuestionList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: null,
                  child: Text(
                    questions.getQuestionText(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Lobster',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepPurpleAccent),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      checkAnswer(true);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'a. True',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'ShadowsIntoLight',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red[500]),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      checkAnswer(false);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'b. False',
                      style: TextStyle(
                        fontFamily: 'ShadowsIntoLight',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.red[500]),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: checkingList,
          )
        ],
      ),
    );
  }
}
