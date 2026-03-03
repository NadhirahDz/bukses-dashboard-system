import 'package:flutter/material.dart';
import 'package:school/dashboard_page.dart';
import 'package:school/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistem Sekolah',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/admin': (context) {
          final name = ModalRoute.of(context)!.settings.arguments as String;
          return HomeMenuPage(name: name, role: 'admin');
        },
        '/teacher4': (context) {
          final name = ModalRoute.of(context)!.settings.arguments as String;
          return HomeMenuPage(name: name, role: 'teacher_form4');
        },
        '/teacher5': (context) {
          final name = ModalRoute.of(context)!.settings.arguments as String;
          return HomeMenuPage(name: name, role: 'teacher_form5');
        },
        '/dashboard': (context) => const DashboardPage(),
        '/update': (context) => const Placeholder(),
      },
    );
  }
}