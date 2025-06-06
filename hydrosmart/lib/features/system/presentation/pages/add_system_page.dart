import 'package:flutter/material.dart';
import 'package:hydrosmart/features/system/domain/subsystem.dart';
import 'package:hydrosmart/features/system/domain/system.dart';

class AddSystemPage extends StatefulWidget {
  const AddSystemPage({super.key});

  @override
  State<AddSystemPage> createState() => _AddSystemPageState();
}

class _AddSystemPageState extends State<AddSystemPage> {
  bool _loading = true;
  List<System> _systems = [];

  @override
  void initState() {
    super.initState();
    _fetchSystemsToAdd(); // Simulate fetching data
  }

  void _fetchSystemsToAdd() {
    // TODO: Implement the actual logic to fetch systems from an API service
    Future.delayed(const Duration(milliseconds: 3000), () {
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
        ];
        _loading = false;
      });
    });
  }

  void _addSystem(System system) {
    // TODO: Implement the actual logic to add the system to the user's account

    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
      content: const Text('Sistema agregado correctamente'),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(16),
    ));
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed('/system_detail', arguments: system);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Volver',
        ),
        title: const Text(
          'Añadir sistema',
          style: TextStyle(fontWeight: FontWeight.bold),
          ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            if (_loading)
              const Column(
                children: [
                  Text(
                    'Se están buscando sistemas nuevos para agregar...',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 24),
                  CircularProgressIndicator(),
                ],
              )
            else // v-else
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (_systems.isNotEmpty)
                    Text(
                      'Se ha encontrado ${_systems.length} sistema(s).',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    )
                  else
                    const Text(
                      'No se ha encontrado ningún sistema.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),

                  if (_systems.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _systems.length,
                        itemBuilder: (context, index) {
                          final system = _systems[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Card(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width > 450 ? 400 : MediaQuery.of(context).size.width * 0.9,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row( 
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF092C4C),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.settings,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Text(
                                          system.name,
                                          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      const SizedBox(width: 16), 
                                      ElevatedButton.icon( 
                                        onPressed: () => _addSystem(system),
                                        icon: const Icon(Icons.add),
                                        label: const Text('Agregar'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF1856C3),
                                          foregroundColor: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
