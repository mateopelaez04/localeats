import 'package:flutter/material.dart';
import 'PaginaPrincipal.dart';
import 'restaurant_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Localeats',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black12),
      ),
      home: const MyHomePage(title: 'Localeats'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

 

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localeats'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Login - Registro'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RestaurantPage(),
                  ),
                );
              },
              child: const Text('Ir a Restaurante'),
            ),
          ],
        ),
      ),
    );
  } // cierre de build
} // cierre de clase