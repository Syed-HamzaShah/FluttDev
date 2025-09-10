import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker_app/upload_page.dart';

const supabaseUrl = 'https://mxxlrugccwfctcdytoxe.supabase.co';
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im14eGxydWdjY3dmY3RjZHl0b3hlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTczNDIxNDYsImV4cCI6MjA3MjkxODE0Nn0.BzA_l7wkRVvnjukkJdBMY19mNOcmhcysDB50qHKvCPs';

void main() async {
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: UploadPage()),
    );
  }
}
