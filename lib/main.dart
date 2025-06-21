import 'package:flutter/material.dart';
import 'pages/inicio_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black, // fondo de todas las pantallas
        brightness: Brightness.dark, // textos y widgets con estilo oscuro
        primaryColor: Colors.white, // color primario (botones, etc.)
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[900], // fondo de los textfields
          hintStyle: TextStyle(color: Colors.grey[400]), // color del hint
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),

      ),
      home: InicioPage(),
    );
  }
}