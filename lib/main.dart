import 'package:correios_frete_app/views/FreteScreen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de Frete - Loja Tech',
      theme: ThemeData(primarySwatch: Colors.green),
      home: FreteScreen(),
    );
  }
}