import 'package:flutter/material.dart';
import 'package:projectuts/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'game.dart';
import 'leaderboard.dart';


class Result extends StatefulWidget {
  final int score;

  const Result({Key? key, required this.score}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  int _highScore = 0;

  @override
  void initState() {
    super.initState();
    _loadHighScore();
    _saveScores(active_user, widget.score.toString());
  }

  Future<void> _loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _highScore = prefs.getInt('leaderboard') ?? 0;
      if (widget.score > _highScore) {
        _highScore = widget.score;
        prefs.setInt('leaderboard', _highScore);
      }
    });
  }

  Future<void> _saveScores(String username, String score) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? scoreList = prefs.getStringList('listofscores');
  
    scoreList ??= [];

    scoreList.add('$username:$score');

    List<List<String>> scores = scoreList.map((scoreList) {
      var split = scoreList.split(':');
      return [split[0], split[1]];
    }).toList();

    scores.sort((a, b) => int.parse(b[1]).compareTo(int.parse(a[1])));

    List<String> updatedScoreList = scores.map((score) {
      return '${score[0]}:${score[1]}';
    }).toList();

    await prefs.setStringList('listofscores', updatedScoreList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MemoPattern', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Game Over",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              "\nYour Score: ${widget.score}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              "High Score: $_highScore",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Game()),
                );
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.play_arrow),
                  SizedBox(width: 8), 
                  Text("Play Again"),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Leaderboard()),
                ); 
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.emoji_events),
                  SizedBox(width: 8), 
                  Text("Leaderboard"),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) =>  const MyApp()),
                  (route) => false,
                );
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [Icon(Icons.home),
                  SizedBox(width: 8), 
                  Text("Home"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
