import 'dart:async';
import 'dart:math';

import '../../../../common_libraries.dart';

class GameCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final Function(int level) onSelectLevel;

  const GameCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.onSelectLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(image, width: 80, height: 80, fit: BoxFit.cover),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(description, style: TextStyle(color: Colors.grey[700])),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _levelButton("Easy", Colors.green, () => onSelectLevel(1)),
                      const SizedBox(width: 8),
                      _levelButton("Medium", Colors.orange, () => onSelectLevel(2)),
                      const SizedBox(width: 8),
                      _levelButton("Hard", Colors.red, () => onSelectLevel(3)),
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

  Widget _levelButton(String text, Color color, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(text),
    );
  }
}

/// ------------------ GAME SCREEN -------------------

class Balloon {
  String question;
  int answer;
  double positionX;
  double positionY;

  Balloon({
    required this.question,
    required this.answer,
    required this.positionX,
    required this.positionY,
  });
}

class MathBallonGame extends StatefulWidget {
  final int startLevel;
  const MathBallonGame({super.key, required this.startLevel});

  @override
  _MathBallonGameState createState() => _MathBallonGameState();
}

class _MathBallonGameState extends State<MathBallonGame> {
  int score = 0;
  late int level;
  int life = 3;

  List<Balloon> balloons = [];
  final TextEditingController answerController = TextEditingController();
  Timer? gameTimer;
  Timer? spawnTimer;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    level = widget.startLevel;
    startGame();
  }

  void startGame() {
    _startBalloonSpawn();
    gameTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        double speed = 1.0 + level * 0.5; // Balloon falls faster with higher level
        for (var balloon in balloons) {
          balloon.positionY += speed;
        }

        balloons.removeWhere((b) {
          if (b.positionY > MediaQuery.of(context).size.height - 120) {
            life--;
            if (life <= 0) {
              showGameOverDialog();
            }
            return true;
          }
          return false;
        });
      });
    });
  }

  void _startBalloonSpawn() {
    int intervalMs;
    switch (level) {
      case 1:
        intervalMs = 6000; // Easy: 1 balloon every 6 sec
        break;
      case 2:
        intervalMs = 4000; // Medium: 1 balloon every 4 sec
        break;
      case 3:
        intervalMs = 2000; // Hard: 1 balloon every 2 sec
        break;
      default:
        intervalMs = 6000;
    }

    spawnTimer?.cancel();
    spawnTimer = Timer.periodic(Duration(milliseconds: intervalMs), (timer) {
      if (life <= 0) {
        timer.cancel();
        return;
      }
      int a = random.nextInt(30) + (level * 5);
      int b = random.nextInt(20) + (level * 2);
      String question = "$a+$b";
      balloons.add(Balloon(
        question: question,
        answer: a + b,
        positionX: random.nextDouble() * (MediaQuery.of(context).size.width - 80),
        positionY: 0,
      ));
    });
  }

  void checkAnswer(String input) {
    if (input.isEmpty) return;

    int? userAnswer = int.tryParse(input);
    if (userAnswer == null) return;

    bool correct = false;

    for (var balloon in balloons) {
      if (balloon.answer == userAnswer) {
        setState(() {
          balloons.remove(balloon);
          score += 10;
          if (score % 50 == 0 && level < 3) level++; // Increase level after 50 points
          _startBalloonSpawn(); // Adjust spawn speed for new level
        });
        correct = true;
        break;
      }
    }

    if (!correct) {
      setState(() {
        life--;
      });
      if (life <= 0) {
        showGameOverDialog();
      }
    }

    answerController.clear();
  }

  void showGameOverDialog() {
    gameTimer?.cancel();
    spawnTimer?.cancel();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade200, Colors.purple.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.sports_esports, size: 60, color: Colors.white),
              const SizedBox(height: 16),
              const Text("Game Over",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 8),
              Text("Your Score: $score",
                  style: const TextStyle(fontSize: 20, color: Colors.white70)),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context); // Back to game selection
                },
                icon: const Icon(Icons.home),
                label: const Text("Back to Menu"),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    spawnTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "🎈 Math Balloon",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade100, Colors.pink.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // Balloons
            ...balloons.map((b) => Positioned(
              left: b.positionX,
              top: b.positionY,
              child: Column(
                children: [
                  Image.asset("assets/parachute1.png", width: 60, height: 80),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.shade400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      b.question,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )),

            // Scoreboard HUD
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _hudItem(Icons.star, "Score: $score"),
                    _hudItem(Icons.trending_up, "Level: $level"),
                    _hudItem(Icons.favorite, "Life: $life"),
                  ],
                ),
              ),
            ),

            // Answer box
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: TextField(
                  controller: answerController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.edit, color: Colors.purple),
                    hintText: "Type your answer here",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSubmitted: checkAnswer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _hudItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.purple, size: 20),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }
}
