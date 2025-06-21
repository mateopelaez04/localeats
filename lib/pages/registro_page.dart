import 'package:flutter/material.dart';
import 'package:localeats/components/my_button.dart';
import 'package:localeats/components/my_textfield.dart';
import 'package:localeats/pages/restaurant_page.dart';

class RegistroPage extends StatelessWidget {
  RegistroPage({super.key});

  // text editing controllers
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void RegisterIn(BuildContext context) {
    final email = emailController.text.trim();
    final username = usernameController.text.trim();
    final password = passwordController.text;

    if (username.isEmpty || password.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent, // Fondo del snackbar
          content: Text(
            'Por favor, llena todos los campos',
            style: TextStyle(
              color: Colors.white, // Color del texto
              fontWeight: FontWeight.bold, // Opcional: texto en negrita
              fontSize: 16, // Opcional: tamaño del texto
            ),
          ),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RestaurantPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // logo
              Image.asset(
                'assets/images/localeats_logo.png',
                width: 300,
                height: 300,
              ),

              const SizedBox(height: 50),

              // welcome back, you've been missed!
              const Text(
                'Crear Cuenta',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(height: 25),

              // email textfield
              MyTextField(
                controller: emailController,
                hintText: 'Correo Electronico',
                obscureText: false,
              ),

              const SizedBox(height: 20),

              // username textfield
              MyTextField(
                controller: usernameController,
                hintText: 'Usuario',
                obscureText: false,
              ),

              const SizedBox(height: 20),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Contraseña',
                obscureText: true,
              ),

              const SizedBox(height: 20),

              MyButton(
                onTap: () => RegisterIn(context),
                text: 'Crear Cuenta',
                textColor: Colors.white,
                backgroundColor: Colors.deepOrangeAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
