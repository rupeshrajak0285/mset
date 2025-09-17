import 'package:App/presentation/flex_pay/widgets/flex_pay_dashboard_screen.dart';

import '../../common_libraries.dart';
export 'widgets/widgets.dart';

class FlexPayScreen extends StatelessWidget {
  const FlexPayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String atmNumber = "1234567812345678";
    List<String> parts = atmNumber.replaceAllMapped(RegExp(r".{4}"), (m) => "${m.group(0)} ").trim().split(" ");
    return Scaffold(
      backgroundColor: const Color(0xFF111827),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: Container(
              height: 192,
              width: 320,
              decoration: BoxDecoration(
                color: const Color(0x801F2937),
                borderRadius: BorderRadius.circular(12), // rounded corners
                border: Border.all(
                  color: const Color(0x1AFFFFFF), // #FFFFFF1A in Flutter
                  width: 1, // adjust thickness as needed
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text("Flex Pay", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold
                          ),),
                        ),
                        Container(
                          height: 36,
                          width: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF6B7280), // top color
                                Color(0xFF374151), // bottom color
                              ],
                          ),
                        ),
                          child:  Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                                height: 28,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(
                                    color: Color(0x809CA3AF), // #FFFFFF1A in Flutter
                                    width: 2, // adjust thickness as needed
                                  ),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF6B7280), // top color
                                      Color(0xFF374151), // bottom color
                                    ],
                                  ),
                                )
                            ),
                          ),
                        )
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: parts.map((p) => Padding(
                        padding: const EdgeInsets.only(right: 8), // thoda spacing
                        child: Text(
                          p,
                          style: const TextStyle(
                            color: Color(0xFF9CA3AF), // text color
                            fontSize: 16,
                            letterSpacing: 2,
                          ),
                        ),
                      )).toList(),
                    )


                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 40,),
          const Text("Welcome To Flex Pay", style: TextStyle(fontSize: 36, color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),),
          const SizedBox(height: 20,),
          const Text("The future of your finances is here", style: TextStyle(fontSize: 18, color: Color(0xFF9CA3AF), fontWeight: FontWeight.w400),),
          const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainScreen()),
                );
              },
              child: Container(
                height: 60,
                width: 260,
                decoration: BoxDecoration(
                  color: const Color(0xFF06B6D4),
                  borderRadius: BorderRadius.circular(16), // rounded corners
                ),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Get Started", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                      SizedBox(width: 10,),
                      Icon(Icons.arrow_forward_ios, color: Colors.white,size: 18,)
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified_user_outlined, color: Color(0xFF4ADE80),),
              SizedBox(width: 10,),
              Text("Bank-level security. Your data is safe with us.", style: TextStyle(color: Color(0xFF6B7280),fontSize: 14, fontWeight: FontWeight.w400),),

            ],
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}
