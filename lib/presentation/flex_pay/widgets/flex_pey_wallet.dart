import 'package:App/presentation/flex_pay/widgets/wallect_card_tab_view.dart';

import '../../../common_libraries.dart';

class FlexPeyWallet extends StatelessWidget {
  const FlexPeyWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111827),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111827),
        elevation: 0,
        centerTitle: true,
        title: Text("wallet", style: TextStyle(color: Colors.white),),) ,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: OctaveTabBarWidget(
                initialIndex: 0,
                tabs: [
                  OctaveTabData(label: "Card", content: Center(child: WallectCardTabView())),
                  OctaveTabData(label: "Account", content: Center(child: Text("Profile Content"))),

                ],
                onTabChanged: (index) {
                  print("Selected tab: $index");
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}




class CardUiExample extends StatefulWidget {
  const CardUiExample({super.key});

  @override
  State<CardUiExample> createState() => _CardUiExampleState();
}

class _CardUiExampleState extends State<CardUiExample>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF111827), // Dark background
      child: TabBar(
        controller: _tabController,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(width: 2.5, color: Color(0xFF22C55E)), // indicator color & thickness
          insets: EdgeInsets.symmetric(horizontal: 20), // optional padding under tab
        ),
        labelColor: Colors.white, // active tab text color
        unselectedLabelColor: Colors.grey, // inactive tab text color
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        tabs: const [
          Tab(text: "Cards"),
          Tab(text: "Account"),
        ],
      ),
    )
    ;
  }

  Widget _buildCardTab() {
    return Center(
      child: Container(
        width: 320,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF9C27B0), Color(0xFF673AB7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 15,
              offset: const Offset(5, 8),
            )
          ],
        ),
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Flex Pay",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                "5000 0000 0000 0000",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  letterSpacing: 3,
                ),
              ),
              Spacer(),
              Text(
                "SANDY CHUNGUS",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

