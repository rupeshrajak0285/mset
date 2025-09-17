import 'package:App/presentation/flex_pay/widgets/atm_card_widget.dart';
import 'package:flutter/cupertino.dart';

import '../../../common_libraries.dart';

class WallectCardTabView extends StatelessWidget {
  const WallectCardTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10,),
          SwipeableAtmCardStack(),
          const SizedBox(height: 10,),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 40,
              width: 175,
              decoration: BoxDecoration(
                color: const Color(0x801F2937),
                borderRadius: BorderRadius.circular(12), // rounded corners
                border: Border.all(
                  color: const Color(0x1AFFFFFF), // #FFFFFF1A in Flutter
                  width: 1, // adjust thickness as needed
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.settings, color: Colors.white,),
                  const SizedBox(width: 10,),
                  Text("Customization", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),)
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GradientIconBox(
                icon: Icons.child_friendly,
                label: "Kids",
                gradientColors: [Color(0xFFA855F7), Color(0xFF7E22CE)],
              ),
              const SizedBox(width: 10),
              GradientIconBox(
                icon: Icons.sports_soccer,
                label: "Sports",
                gradientColors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
              ),
              const SizedBox(width: 10),
              GradientIconBox(
                icon: Icons.music_note,
                label: "Music",
                gradientColors: [Color(0xFF22C55E), Color(0xFF15803D)],
              ),
              const SizedBox(width: 10),
              GradientIconBox(
                icon: Icons.book,
                label: "Books",
                gradientColors: [Color(0xFF06B6D4), Color(0xFF0E7490)],
              ),
            ],
          ),
          SizedBox(height: 30,),
          Container(
      
            decoration: BoxDecoration(
              color: const Color(0x801F2937),
              borderRadius: BorderRadius.circular(18), // rounded corners
              border: Border.all(
                color: const Color(0x1AFFFFFF), // #FFFFFF1A in Flutter
                width: 1, // adjust thickness as needed
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50, // circle size
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color(0xFF22D3EE).withOpacity(0.1), // transparent white
                              shape: BoxShape.circle,           // makes it circular
                            ),
                            child: Icon(Icons.qr_code, color:Color(0xFF22D3EE) , size: 15,),
                          ),
      
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Row(
                                children: [
                                  Icon(CupertinoIcons.plus, color: Colors.white,),
                                  const SizedBox(width: 5,),
                                  Text(
                                    "Add Card",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5,),
                              Text(
                                "Add your debit/credit card",
                                style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: 50, // circle size
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0x801F2937), // transparent white
                          shape: BoxShape.circle,           // makes it circular
                        ),
                        child: Icon(Icons.close, color:Colors.white , size: 15,),
                      ),
      
                    ],
                  ),
                  const SizedBox(height: 25),
      
                  // Card Number Input
                  Text("Card Number", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white)),
                  const SizedBox(height: 10,),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "1234 5678 9012 3456",
                      hintStyle: const TextStyle(color: Colors.grey),
                      labelText: "1234 5678 9012 3456",
                      labelStyle: const TextStyle(color: Colors.white70),
                      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0x1AFFFFFF)), // white border
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0x1AFFFFFF), width: 2),
                      ),
                      filled: true,
                      fillColor: const Color(0xFF0F172A),
      
                    ),
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 15),
      
                  // Card Holder Input
                  Text("Card Number", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white)),
                  const SizedBox(height: 10,),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "John Doe",
                      hintStyle: const TextStyle(color: Colors.grey),
                      labelText: "John Doe",
                      labelStyle: const TextStyle(color: Colors.white70),
                      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      filled: true,
                      fillColor: const Color(0xFF0F172A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0x1AFFFFFF)), // white border
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Color(0x1AFFFFFF), width: 2),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
      
                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF06B6D4), // Cyan color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 25),
                      ),
                      child: const Text(
                        "Add Securely",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


class GradientIconBox extends StatelessWidget {
  final IconData icon;
  final String label;
  final List<Color> gradientColors;
  final double size;
  final double borderRadius;

  const GradientIconBox({
    Key? key,
    required this.icon,
    required this.label,
    required this.gradientColors,
    this.size = 28,
    this.borderRadius = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 65,
          width: 65,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: size,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

