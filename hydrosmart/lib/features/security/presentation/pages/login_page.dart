import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrosmart/core/app_constants.dart';
import 'package:hydrosmart/features/security/presentation/bloc/login_bloc.dart';
import 'package:hydrosmart/features/security/presentation/bloc/login_event.dart';
import 'package:hydrosmart/features/security/presentation/bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (BuildContext context, state) {
          if (state is LoginSuccess) {
            Navigator.pushNamed(context, '/home');
          } else if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Credenciales incorrectas'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              margin: const EdgeInsets.all(16),
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
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  label: const Text('Contraseña'),
                  prefixIcon: const Icon(Icons.key),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)
                ),
                suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  )
                ),
                        
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1856C3), // Color de fondo del botón
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