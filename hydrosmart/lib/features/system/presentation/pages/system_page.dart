import 'package:flutter/material.dart';
import 'package:hydrosmart/features/system/domain/subsystem.dart';
import 'package:hydrosmart/features/system/domain/system.dart';

class SystemPage extends StatefulWidget {
  const SystemPage({super.key});

  @override
  State<SystemPage> createState() => _SystemPageState();
}

class _SystemPageState extends State<SystemPage> {
List<System> _systems = [];

  @override
  void initState() {
    super.initState();
    _fetchSystems(); // Simula la obtención de datos al inicio
  }

  void _fetchSystems() {
    // TODO: Implementar la lógica para obtener sistemas de un servicio API
    setState(() {
      _systems = [
        System(
          id: 1,
          name: "Sistema de zanahorias",
          cropId: 1,
          batteryLevel: 70,
          subsystems: [
            Subsystem(id: 1, name: "Regado automatico", value: null, status: "Normal", active: true),
            Subsystem(id: 2, name: "Temperatura", value: 22.0, status: "Normal", active: true),
            Subsystem(id: 3, name: "Humedad", value: 50.0, status: "Normal", active: false),
            Subsystem(id: 4, name: "Cantidad de agua", value: 1000.0, status: "Insuficiente", active: false),
          ],
        ),
        System(
          id: 2,
          name: "Sistema de papas",
          cropId: 2,
          batteryLevel: 40,
          subsystems: [
            Subsystem(id: 1, name: "Regado automatico", value: null, status: "Normal", active: true),
            Subsystem(id: 2, name: "Temperatura", value: 19.0, status: "Normal", active: true),
            Subsystem(id: 3, name: "Humedad", value: 71.0, status: "Normal", active: true),
            Subsystem(id: 4, name: "Cantidad de agua", value: 2000.0, status: "Normal", active: true),
          ],
        ),
        System(
          id: 3,
          name: "Sistema de lechugas",
          cropId: 3,
          batteryLevel: 15,
          subsystems: [
            Subsystem(id: 1, name: "Regado automatico", value: null, status: "Normal", active: true),
            Subsystem(id: 2, name: "Temperatura", value: 18.0, status: "Normal", active: true),
            Subsystem(id: 3, name: "Humedad", value: 65.0, status: "Normal", active: true),
            Subsystem(id: 4, name: "Cantidad de agua", value: 1500.0, status: "Insuficiente", active: false),
          ],
        ),
        System(
          id: 4,
          name: "Sistema de tomates",
          cropId: 4,
          batteryLevel: 85,
          subsystems: [
            Subsystem(id: 1, name: "Regado automatico", value: null, status: "Normal", active: true),
            Subsystem(id: 2, name: "Temperatura", value: 21.0, status: "Normal", active: true),
            Subsystem(id: 3, name: "Humedad", value: 60.0, status: "Normal", active: true),
            Subsystem(id: 4, name: "Cantidad de agua", value: 1200.0, status: "Normal", active: true),
          ],
        ),
        System(
          id: 5,
          name: "Sistema de fresas",
          cropId: 5,
          batteryLevel: 50,
          subsystems: [
            Subsystem(id: 1, name: "Regado automatico", value: null, status: "Normal", active: true),
            Subsystem(id: 2, name: "Temperatura", value: 20.0, status: "Normal", active: true),
            Subsystem(id: 3, name: "Humedad", value: 55.0, status: "Normal", active: true),
            Subsystem(id: 4, name: "Cantidad de agua", value: 800.0, status: "Insuficiente", active: false),
          ],
        ),
      ];
    });
  }

  Color _getBatteryColor(int percentage) {
    if (percentage >= 70) return const Color(0xFF27AE60);
    if (percentage >= 40) return const Color(0xFFF1C40F);
    if (percentage >= 20) return const Color(0xFFE67E22);
    return const Color(0xFFE74C3C); // Red
  }

  void _goToSystemDetails(int id) {
    Navigator.of(context).pushNamed('/system_detail', arguments: id);
  }

  void _goToAddSystem() {
    //Navigator.of(context).pushNamed('/add_system');
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sistemas',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: screenHeight * 0.74,
              child: ListView.builder(
                itemCount: _systems.length,
                itemBuilder: (context, index) {
                  final system = _systems[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                system.name,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: _getBatteryColor(system.batteryLevel),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.battery_charging_full,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${system.batteryLevel}%',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Wrap(
                        spacing: 20.0,
                        runSpacing: 20.0,
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 160,
                                child: ElevatedButton.icon(
                                  onPressed: () => _goToSystemDetails(system.id),
                                  label: const Text('Ver sistema'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1856C3),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (index < _systems.length - 1)
                        const Divider(height: 40, thickness: 1, indent: 20, endIndent: 20),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF092C4C),
        onPressed: _goToAddSystem,
        tooltip: 'Añadir',
        child: const Icon(Icons.add, color: Colors.white),
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}