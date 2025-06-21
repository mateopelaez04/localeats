import 'package:flutter/material.dart';
import 'package:localeats/components/my_button.dart';
import 'package:localeats/pages/registro_page.dart';
import 'package:localeats/pages/login_page.dart';

class InicioPage extends StatelessWidget {
  InicioPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void RegisterIn(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RegistroPage()),
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

              // sign in button
              MyButton(
              onTap: () => signUserIn(context),
              text: 'Iniciar Sesion',
              textColor: Colors.white,
              backgroundColor: Colors.deepOrangeAccent,
              ) ,

              const SizedBox(height: 80),

              MyButton(
                onTap: () => RegisterIn(context),
                text: 'Crear Cuenta',
                textColor: Colors.black,
                backgroundColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
