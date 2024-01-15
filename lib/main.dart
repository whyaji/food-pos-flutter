import 'package:flutter/material.dart';
import 'package:food_pos/pages/checkout_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food POS',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 37, 167, 172)),
        useMaterial3: true,
      ),
      home: const CheckOutPage(),
    );
  }
}
