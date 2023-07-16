import 'package:doctors_on_hand/screens/doctor_detail_screen.dart';
import 'package:doctors_on_hand/screens/doctor_detail.dart';
import 'package:doctors_on_hand/screens/home_screen.dart';
import 'package:doctors_on_hand/screens/main_screen.dart';
import 'package:doctors_on_hand/screens/map.dart';
import 'package:doctors_on_hand/theme/theme_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:doctors_on_hand/screens/login_screen.dart';
import 'package:doctors_on_hand/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:doctors_on_hand/screens/sign_up_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

//List<MultiProvider> providers = [];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeManager()),
      ],
      child: Consumer<ThemeManager>(
        child: LoginScreen(),
        builder: (c, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeProvider.selectedThemeMode,
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
