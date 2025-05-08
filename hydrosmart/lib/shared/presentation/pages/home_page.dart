import 'package:flutter/material.dart';
import 'package:hydrosmart/features/security/data/repository/security_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  final List<Widget> _pages = const [
    Text('Soil'),
    Text('Irrigation'),
    Text('System'),
    Text(''),
  ];

  Future<void> _logout() async {
    // Aquí puedes agregar la lógica para cerrar sesión, como limpiar el token o llamar a un servicio de logout
    // Por ejemplo:
    SecurityRepository().logout();
    Navigator.pushReplacementNamed(context, '/login'); // Redirige al login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grass), label: 'Soil'),
          BottomNavigationBarItem(icon: Icon(Icons.water_drop), label: 'Irrigation'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'System'),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Logout'),
        ],
        currentIndex: _index,
        onTap: (value) async {
          if (value == 3) {
            // Si el índice es 3 (Logout), cierra sesión
            await _logout();
          } else {
            setState(() {
              _index = value; // Cambia la página seleccionada
            });
          }
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(child: _pages[_index]),
    );
  }
}