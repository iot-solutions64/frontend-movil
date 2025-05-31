import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrosmart/core/app_constants.dart';
import 'package:hydrosmart/features/security/presentation/bloc/register_bloc.dart';
import 'package:hydrosmart/features/security/presentation/bloc/register_event.dart';
import 'package:hydrosmart/features/security/presentation/bloc/register_state.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (BuildContext context, state) {
          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(
              content: const Text('Cuenta creada con éxito, inicia sesión'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              margin: const EdgeInsets.all(16),
            ));
            Navigator.pushNamed(context, '/login');
          } else if (state is RegisterError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Error al registrar usuario'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              margin: const EdgeInsets.all(16)
            ));
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
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
                    'Crear cuenta',
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
                  child: TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        label: const Text('Confirmar Contraseña'),
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
                        backgroundColor: const Color(0xFF1856C3), // Color de fondo del botón
                        foregroundColor: Colors.white, // Color del texto
                      ),
                      onPressed: () {
                        final String username = _usernameController.text;
                        final String password = _passwordController.text;
                        final String confirmPassword = _confirmPasswordController.text;
                        if (password != confirmPassword) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Las contraseñas no coinciden'),
                            backgroundColor: Colors.red,
                          ));
                          return;
                        }
                        context.read<RegisterBloc>().add(RegisterSubmitted(
                          username: username, password: password));
                      },
                      child: const Text('Registrar')),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Regresa a la página de inicio de sesión
                  },
                  child: const Text(
                    '¿Ya tienes cuenta? Inicia sesión',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
            ],)
          )
        ),
      ),
    );
  }

}