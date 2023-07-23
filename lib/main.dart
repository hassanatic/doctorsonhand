import 'package:doctors_on_hand/screens/splash_screen.dart';
import 'package:doctors_on_hand/theme/theme_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> _getUserToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('userToken');
}

Future<int?> _getRole() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('role');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  String? userToken = await _getUserToken();
  int? role = await _getRole();
  runApp(MyApp(
    userToken: userToken,
    role: role,
  ));
}

//List<MultiProvider> providers = [];

class MyApp extends StatelessWidget {
  final String? userToken;
  final int? role;

  MyApp({required this.userToken, required this.role});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeManager()),
      ],
      child: Consumer<ThemeManager>(
        child: SplashScreen(userToken: userToken, role: role),
        builder: (c, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // theme: lightTheme,
            // darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: child,
          );
        },
      ),
    );

    // ChangeNotifierProvider(
    //   create: (context) => ThemeManager(),
    //   child: MaterialApp(
    //     themeMode: Provider.of<ThemeManager>(context).selectedThemeMode,
    //     home: WelcomeScreen(),
    //   ),
    // );
  }
}
