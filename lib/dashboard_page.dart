// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui;

import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late String name;
  late String role;
  late String viewId;

  // Add your dashboard URLs here
  final Map<String, String> dashboardUrls = {
    'admin':
        'https://lookerstudio.google.com/embed/reporting/4d52ceca-bdba-4dd5-8896-617036cee9c6/page/KMtjF',
    'teacher_form4':
        'https://lookerstudio.google.com/embed/reporting/PLACEHOLDER_FORM4/page/XXXXX',
    'teacher_form5':
        'https://lookerstudio.google.com/embed/reporting/PLACEHOLDER_FORM5/page/XXXXX',
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    name = args['name'];
    role = args['role'];
    viewId = 'looker-$role';

    final String url = dashboardUrls[role] ?? dashboardUrls['admin']!;

    ui.platformViewRegistry.registerViewFactory(viewId, (int viewId) {
      final iframe = html.IFrameElement()
        ..src = url
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%'
        ..allow = 'fullscreen'
        ..setAttribute('sandbox',
            'allow-storage-access-by-user-activation allow-scripts allow-same-origin allow-popups allow-popups-to-escape-sandbox');
      return iframe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1565C0), Color(0xFF0e9f6e)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getDashboardTitle(role),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Semester 1, 2025',
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 13, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      body: HtmlElementView(viewType: viewId),
    );
  }

  String _getDashboardTitle(String role) {
    switch (role) {
      case 'admin':
        return 'Dashboard Pentadbir';
      case 'teacher_form4':
        return 'Dashboard Tingkatan 4';
      case 'teacher_form5':
        return 'Dashboard Tingkatan 5';
      default:
        return 'Dashboard';
    }
  }
}