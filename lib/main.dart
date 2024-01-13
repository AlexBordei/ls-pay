import 'package:flutter/material.dart';
import 'package:pay/features/auth/presentation/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/service_locator.dart' as di;

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://lnjozbnrxxpfujyewibd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imxuam96Ym5yeHhwZnVqeWV3aWJkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDUxNDY1MzAsImV4cCI6MjAyMDcyMjUzMH0.bR9ijmqFf1a_KfaGNw1fynf7Y2OjNvJ0TZzJzSWHNAQ',
  );
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
