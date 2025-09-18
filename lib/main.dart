
import 'package:firebase_core/firebase_core.dart';

import 'common_libraries.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiClientService.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // ye important hai Web ke liye
  );
  await Prefs.init();
  SystemChrome.setSystemUIOverlayStyle( const SystemUiOverlayStyle(
    statusBarColor: Colors.white, // Status bar background color
    statusBarIconBrightness: Brightness.light, // For Android
    statusBarBrightness: Brightness.dark, // For iOS
  ));
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(),
        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false, // switch to true if you want Material3
        ),
        home:  const SignInScreen(),
      ),
    );
  }
}
