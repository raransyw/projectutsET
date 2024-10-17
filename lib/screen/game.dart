import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'result.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int _level = 1;
  int _score = 0;
  List<int> _pattern = [];
  List<bool> _selected = [];
  bool _gameOver = false;
  Timer? _timer;
  int _timeLeft = 30;
  bool _showPattern = true;

  String _username = "";

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _startNewGame();
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel timer when widget is disposed
    super.dispose();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    if (mounted) {
      // Check if widget is still mounted
      setState(() {
        _username = prefs.getString('username') ?? "Player";
      });
    }
  }

  void _startNewGame() {
    _score = 0;
    _level = 1;
    _gameOver = false;
    _startLevel();
  }

  void _startLevel() {
    _generatePattern();
    _showPattern = true;
    setState(() {});

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // Ensure widget is still mounted
        setState(() {
          _showPattern = false;
        });
        _startTimer();
      }
    });
  }

  void _startTimer() {
    _timeLeft = 30;
    _timer?.cancel(); // Ensure any previous timer is cancelled
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft == 0) {
        _endGame();
        timer.cancel();
      } else if (mounted) {
        // Ensure widget is still mounted
        setState(() {
          _timeLeft--;
        });
      }
    });
  }

  void _endGame() {
    _gameOver = true;
    _timer?.cancel();
    if (mounted) {
      // Ensure widget is still mounted
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Result(score: _score)),
      );
    }
  }

  void _generatePattern() {
    Random random = Random();
    int gridSize = _getGridSize();
    _pattern.clear();
    _selected = List.generate(gridSize * gridSize, (index) => false);
    for (int i = 0; i < _level + 2; i++) {
      int newRandom;
      do {
        newRandom = random.nextInt(gridSize * gridSize);
      } while (_pattern.contains(newRandom));
      _pattern.add(newRandom);
    }
    if (mounted) {
      // Ensure widget is still mounted
      setState(() {});
    }
  }

  int _getGridSize() {
    return 3 + (_level - 1);
  }

  void _checkSelection(int index) {
    if (_pattern.contains(index)) {
      _score += 100;
      if (mounted) {
        setState(() {
          _selected[index] = true;
        });
      }
      if (_selected.where((element) => element).length == _pattern.length) {
        _nextLevel();
      }
    } else {
      _endGame();
    }
  }

  void _nextLevel() {
    if (mounted) {
      setState(() {
        _level++;
        if (_level > 5) {
          _showVictoryDialog();
        } else {
          _startLevel();
        }
      });
    }
  }

  void _showVictoryDialog() {
    _timer?.cancel();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Result(score: _score)),
      );
    }
  }

  Widget _buildGrid(BuildContext context) {
    int gridSize = _getGridSize();
    double screenWidth = MediaQuery.of(context).size.width;
    double blockSize = screenWidth / gridSize * 0.8;

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gridSize,
      ),
      itemCount: gridSize * gridSize,
      itemBuilder: (context, index) {
        bool isPatternTile = _pattern.contains(index);
        return GestureDetector(
          onTap: () {
            if (!_gameOver && !_showPattern) {
              _checkSelection(index);
            }
          },
          child: Container(
            margin: const EdgeInsets.all(4),
            width: blockSize,
            height: blockSize,
            decoration: BoxDecoration(
              color: _showPattern && isPatternTile
                  ? Colors.blue
                  : (_selected[index] ? Colors.blue : Colors.grey),
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress = _timeLeft / 30;

    return Scaffold(
      appBar: AppBar(
        title: const Text("MemoPattern"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Player: $_username',
                style: const TextStyle(fontSize: 22)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Level: $_level', style: const TextStyle(fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Score: $_score', style: const TextStyle(fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 20,
                  backgroundColor: Colors.grey[300],
                  color: Colors.blue,
                ),
                const SizedBox(height: 10),
                Text(
                  'Time Left: $_timeLeft seconds',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildGrid(context),
          ),
          if (!_showPattern)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Select the correct pattern',
                style: TextStyle(fontSize: 18),
              ),
            ),
        ],
      ),
    );
  }
}
