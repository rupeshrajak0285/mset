import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// ------------------- ATM CARD WIDGET -------------------
class AtmCardWidget extends StatelessWidget {
  final LinearGradient gradient;

  const AtmCardWidget({super.key, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _buildCardContent(),
      ),
    );
  }

  /// Card inner content separated for readability
  Widget _buildCardContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Flex Pay",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Spacer(),
        Row(
          children: const [
            Text(
              "5000 0000 0000 0000",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Icon(CupertinoIcons.wifi, color: Colors.white),
          ],
        ),
        const Spacer(),
        Row(
          children: const [
            Text(
              "VALID THRU",
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            SizedBox(width: 8),
            Text(
              "12/28",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "SANDY CHUNGUS",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Text(
                "VISA",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

/// ------------------- CARD STACK -------------------
class SwipeableAtmCardStack extends StatefulWidget {
  const SwipeableAtmCardStack({super.key});

  @override
  State<SwipeableAtmCardStack> createState() => _SwipeableAtmCardStackState();
}

class _SwipeableAtmCardStackState extends State<SwipeableAtmCardStack> {
  final PageController _controller = PageController(viewportFraction: 0.8);
  double currentPage = 0;

  final List<LinearGradient> gradients = const [
    LinearGradient(
      colors: [Color(0xFF9333EA), Color(0xFFA855F7), Color(0xFFC084FC)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [Color(0xFF0EA5E9), Color(0xFF3B82F6), Color(0xFF60A5FA)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [Color(0xFFFACC15), Color(0xFFFBBF24), Color(0xFFF59E0B)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    LinearGradient(
      colors: [Color(0xFF16A34A), Color(0xFF22C55E), Color(0xFF4ADE80)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() => currentPage = _controller.page ?? 0);
    });
  }

  /// ------------------- DOTS INDICATOR -------------------
  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(gradients.length, (index) {
        bool isActive = index == currentPage.round();
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 12 : 8,
          height: isActive ? 12 : 8,
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.white38,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }

  /// ------------------- BUILD -------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: Stack(
            children: List.generate(gradients.length, (index) {
              double delta = index - currentPage;
              double scale = 1 - delta.abs() * 0.05;
              double yOffset = delta.abs() * 20;

              return Positioned(
                top: yOffset,
                left: 0,
                right: 0,
                child: Transform.scale(
                  scale: scale,
                  child: AtmCardWidget(gradient: gradients[index]),
                ),
              );
            }).reversed.toList(),
          ),
        ),
        const SizedBox(height: 16),
        _buildDots(),
      ],
    );
  }
}
