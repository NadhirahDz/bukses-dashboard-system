import 'package:flutter/material.dart';
import 'package:school/dashboard_page.dart';
import 'package:school/home_page.dart';
import 'package:school/upload_page.dart';
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
        '/home': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return HomeMenuPage(
            name: args['name'] ?? 'User',
            role: args['role'] ?? 'teacher_form4',
          );
        },
        '/admin': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return HomeMenuPage(
            name: args['name'] ?? 'Pentadbir',
            role: 'admin',
          );
        },
        '/teacher4': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return HomeMenuPage(
            name: args['name'] ?? 'Cikgu',
            role: 'teacher_form4',
          );
        },
        '/teacher5': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return HomeMenuPage(
            name: args['name'] ?? 'Cikgu',
            role: 'teacher_form5',
          );
        },
        '/dashboard': (context) => const DashboardPage(),
        '/update': (context) => const UploadPage(),
      },
    );
  }
}