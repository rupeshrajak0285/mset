import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class MathTableGame extends StatefulWidget {
  final int level;
  const MathTableGame({super.key, required this.level});

  @override
  State<MathTableGame> createState() => _MathTableGameState();
}

class _MathTableGameState extends State<MathTableGame>
    with SingleTickerProviderStateMixin {
  late int num1;
  late int num2;
  String answer = "";
  int timeLeft = 60;
  Timer? timer;
  late int maxNumber;
  late String levelName;
  int score = 0;
  String lastResult = "";

  late AnimationController _buttonController;
  late Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();
    _setLevelSettings();
    _generateQuestion();
    _startTimer();

    _buttonController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _buttonAnimation =
        Tween<double>(begin: 1.0, end: 1.1).animate(_buttonController);
  }

  @override
  void dispose() {
    timer?.cancel();
    _buttonController.dispose();
    super.dispose();
  }

  void _setLevelSettings() {
    switch (widget.level) {
      case 1:
        maxNumber = 5;
        levelName = "Easy";
        break;
      case 2:
        maxNumber = 10;
        levelName = "Medium";
        break;
      case 3:
        maxNumber = 20;
        levelName = "Hard";
        break;
      default:
        maxNumber = 10;
        levelName = "Medium";
    }
  }

  void _generateQuestion() {
    setState(() {
      num1 = Random().nextInt(maxNumber) + 1;
      num2 = Random().nextInt(maxNumber) + 1;
      answer = "";
      lastResult = "";
    });
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          timer?.cancel();
          _showGameOver();
        }
      });
    });
  }

  void _checkAnswer() {
    if (answer.isEmpty) return;
    int userAnswer = int.tryParse(answer) ?? -1;
    if (userAnswer == num1 * num2) {
      setState(() {
        score++;
        lastResult = "🎉 Correct!";
      });
    } else {
      setState(() {
        lastResult = "❌ Wrong! Answer: ${num1 * num2}";
      });
    }
    Future.delayed(const Duration(milliseconds: 700), _generateQuestion);
  }

  void _showGameOver() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text("Game Over 🎮"),
        content: Text("Your score: $score"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return Expanded(
      child: GestureDetector(
        onTapDown: (_) => _buttonController.forward(),
        onTapUp: (_) => _buttonController.reverse(),
        onTapCancel: () => _buttonController.reverse(),
        onTap: () {
          setState(() {
            answer += number;
          });
        },
        child: ScaleTransition(
          scale: _buttonAnimation,
          child: Container(
            margin: const EdgeInsets.all(4),
            height: 70,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.orangeAccent, Colors.pinkAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.pink.withOpacity(0.4),
                  blurRadius: 6,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton(String label, Color bgColor, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTapDown: (_) => _buttonController.forward(),
        onTapUp: (_) => _buttonController.reverse(),
        onTapCancel: () => _buttonController.reverse(),
        onTap: onTap,
        child: ScaleTransition(
          scale: _buttonAnimation,
          child: Container(
            margin: const EdgeInsets.all(4),
            height: 70,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [bgColor.withOpacity(0.7), bgColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: bgColor.withOpacity(0.4),
                  blurRadius: 6,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
            child: Center(
                child: Text(
                  label,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                )),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        title: const Text(
          "Table Ninja 🥷",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Timer & Score
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "⏰ 00:${timeLeft.toString().padLeft(2, '0')}",
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                Text(
                  "🏆 Score: $score",
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Question Container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.orangeAccent, Colors.pinkAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$num1 × $num2 = ",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 90,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(
                        answer,
                        style: const TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              lastResult,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: lastResult.contains("Correct") ? Colors.green : Colors.red),
            ),
            const SizedBox(height: 20),
            // Number Pad
            Expanded(
              child: Column(
                children: [
                  Row(children: [_buildNumberButton("7"), _buildNumberButton("8"), _buildNumberButton("9")]),
                  Row(children: [_buildNumberButton("4"), _buildNumberButton("5"), _buildNumberButton("6")]),
                  Row(children: [_buildNumberButton("1"), _buildNumberButton("2"), _buildNumberButton("3")]),
                  Row(
                    children: [
                      _buildControlButton("⌫", Colors.grey, () {
                        setState(() {
                          if (answer.isNotEmpty) answer = answer.substring(0, answer.length - 1);
                        });
                      }),
                      _buildNumberButton("0"),
                      _buildControlButton("✔", Colors.green, _checkAnswer),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
