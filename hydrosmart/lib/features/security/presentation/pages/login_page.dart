import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrosmart/core/app_constants.dart';
import 'package:hydrosmart/features/security/presentation/bloc/login_bloc.dart';
import 'package:hydrosmart/features/security/presentation/bloc/login_event.dart';
import 'package:hydrosmart/features/security/presentation/bloc/login_state.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (BuildContext context, state) {
          if (state is LoginSuccess) {
            Navigator.pushNamed(context, '/home');
          } else if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Credenciales incorrectas'),
              backgroundColor: Colors.red,
            ));
          }
        },
        child: SafeArea(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                  AppConstants.logo,
                  height: 200,
                  fit: BoxFit.cover,
                ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Iniciar sesión',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                    label: const Text('Usuario'),
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    label: const Text('Contraseña'),
                    prefixIcon: const Icon(Icons.key),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xB43B82F6), // Color de fondo del botón
                    foregroundColor: Colors.white, // Color del texto
                  ),
                  onPressed: () {
                    final String username = _usernameController.text;
                    final String password = _passwordController.text;
                    context.read<LoginBloc>().add(LoginSubmitted(
                        username: username, password: password));
                  },
                  child: const Text('Acceder')),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text(
                '¿No tienes cuenta? Regístrate aquí',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}