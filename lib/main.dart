import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petite_money/pages/onboarding_page.dart';
import 'package:petite_money/provider/theme_provider.dart';
import 'package:petite_money/utils/my_themes.dart';
import 'package:provider/provider.dart';

const dGreen = Color(0xFF00b894);
const bgGray = Color(0xFFB7D2DB);
const dTitle = Color(0xFF37474f);
const dGray = Color(0xff263238);
const dYellow = Color(0xffffcc00);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return ThemeProvider();
        })
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.getThemeMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Petite Money',
          debugShowCheckedModeBanner: false,
          theme: MyThemes.themeData(themeProvider.getIsDarkMode, context),
          home: const OnboardingPage(),
        );
      },
    );
  }
}
