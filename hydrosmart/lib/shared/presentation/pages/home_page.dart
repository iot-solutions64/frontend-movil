import 'package:flutter/material.dart';
import 'package:hydrosmart/features/irrigation/presentation/pages/irrigation_page.dart';
import 'package:hydrosmart/features/security/data/repository/security_repository.dart';
import 'package:hydrosmart/features/soil/presentation/pages/soil_page.dart';
import 'package:hydrosmart/features/system/presentation/pages/system_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  final List<Widget> _pages = const [
    SoilPage(),
    IrrigationPage(),
    SystemPage(),
    Text(''),
  ];

  Future<void> _logout() async {
    SecurityRepository().logout();
    Navigator.pushReplacementNamed(context, '/login'); // Redirige al login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grass), label: 'Cultivo'),
          BottomNavigationBarItem(icon: Icon(Icons.water_drop), label: 'Agua'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Sistema'),
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