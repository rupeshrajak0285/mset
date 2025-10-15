import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // dark navy background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/male.jpeg"),
                        radius: 22,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Welcome back,", style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14)),
                          Text("Sandy Chungus", style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 18, fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.notifications_none, color: Colors.white70),
                  const SizedBox(width: 10,),
                  Icon(Icons.menu, color: Colors.white70,)
                ],
              ),

              const SizedBox(height: 40),
              const BalanceScreen(),

              const SizedBox(height: 30),

              // Transactions
              Row(
                children: [
                  const Text(
                    "Transactions",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Container(
                    width: 40, // circle size
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0x801F2937), // transparent white
                      shape: BoxShape.circle,           // makes it circular
                    ),
                    child: Icon(Icons.filter_alt_sharp, color:Color(0xFF9CA3AF) , size: 15,),
                  )

                ],
              ),

              const SizedBox(height: 16),

              Expanded(
                child: ListView(
                  children: [
                    _transactionTile("Amazon", "Jan 20, 2024", "-\$103.68", "assets/amazon.png"),
                    _transactionTile("McDonalds", "Jan 19, 2024", "-\$54.70", "assets/mcd.png"),
                    _transactionTile("Sarah Johnson", "sent you money", "+\$150.00", "assets/user1.png", positive: true),
                    _transactionTile("Mike Chen", "sent you money", "+\$75.50", "assets/user2.png", positive: true),
                    _transactionTile("Netflix", "Jan 16, 2024", "-\$15.99", "assets/netflix.png"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _transactionTile(String title, String subtitle, String amount, String asset,
      {bool positive = false}) {
    return Container(

      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF0801F2937), // card background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0x1AFFFFFF), // #FFFFFF1A in Flutter
          width: 1, // adjust thickness as needed
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/amazone.png"),
            radius: 30,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                const SizedBox(height: 5,),
                Text(subtitle,
                    style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: positive ? Colors.greenAccent : Colors.redAccent,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}




class BalanceScreen extends StatelessWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer circular glow
          Stack(
            alignment: Alignment.center,
            children: [
              buildCircle(250, Color(0xFF64748B)),
              buildCircle(220, Color(0xFF0FF0F172A)),
              buildCircle(190, Color(0xFF0FF0F172A)),
              buildCircle(160, Color(0xFF0F172A)),

            ],
          ),
          // Center balance text
          Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                "\$9,983.75",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Available Balance",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget buildCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
       /* boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(3, 3),
          ),
        ],*/
        gradient: RadialGradient(
          colors: [
            color.withOpacity(0.6),
            Colors.transparent,
          ],
          radius: 0.8,
        ),
      ),
    );
  }
  Widget _buildCapsule() {
    return Container(
      width: 70,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF00C896),
            Color(0xFF00E6A7),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.purpleAccent.withOpacity(0.6),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}


