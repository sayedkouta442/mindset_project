import 'package:flutter/material.dart';

import 'package:mindset_project/navigation_bottom.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ltmusqlcjfwihifpqsrs.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx0bXVzcWxjamZ3aWhpZnBxc3JzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDYxMzEwMjUsImV4cCI6MjA2MTcwNzAyNX0.PNTi8TlUwB28xkJeOAS5CpfKiDtBnmKhT-0KEBoHrNo',
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationBottom(),
    );
  }
}
