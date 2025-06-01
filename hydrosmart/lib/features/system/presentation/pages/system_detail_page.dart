import 'package:flutter/material.dart';
import 'package:hydrosmart/features/system/domain/subsystem.dart';
import 'package:hydrosmart/features/system/domain/system.dart';


class SystemDetailPage extends StatefulWidget {
  final int systemId;

  const SystemDetailPage({super.key, required this.systemId});

  @override
  State<SystemDetailPage> createState() => _SystemDetailPageState();
}

class _SystemDetailPageState extends State<SystemDetailPage> {
  System _system = System();

  @override
  void initState() {
    super.initState();
    _fetchSystemDetails(widget.systemId);
  }

  void _fetchSystemDetails(int id) {
    // TODO: Implementar la lógica para obtener datos del sistema desde un servicio
    // Aquí simulamos la carga de datos con los valores de ejemplo
    setState(() {
      _system = System(
        id: id,
        name: "Sistema de zanahorias",
        cropId: 1,
        batteryLevel: 70,
        subsystems: [
          Subsystem(id: 1, name: "Regado automatico", value: null, status: "Normal", active: true),
          Subsystem(id: 2, name: "Temperatura", value: 22.0, status: "Normal", active: true),
          Subsystem(id: 3, name: "Humedad", value: 50.0, status: "Normal", active: false),
          Subsystem(id: 4, name: "Cantidad de agua", value: 1000.0, status: "Insuficiente", active: false),
        ],
      );
    });
  }

  Color _getBatteryColor(int percentage) {
    if (percentage >= 70) return const Color(0xFF27AE60);
    if (percentage >= 40) return const Color(0xFFF1C40F);
    if (percentage >= 20) return const Color(0xFFE67E22);
    return const Color(0xFFE74C3C);
  }

  void _deleteSystem(int id) {
    // TODO: Implementar la lógica para eliminar el sistema
    Navigator.of(context).pop();
  }

  void _goToEditSystem(int id) {
    //Navigator.of(context).pushNamed('/systems/${id}/edit');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(), // router.back()
          tooltip: 'Volver',
        ),
        title: Text(
          _system.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0), // m-3
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 160,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: _getBatteryColor(_system.batteryLevel),
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.battery_charging_full,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              children: [
                                const Text('Batería', textAlign: TextAlign.center),
                                Text(
                                  '${_system.batteryLevel}%',
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width * 0.8),
                      child: Table(
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        columnWidths: const {
                          0: FlexColumnWidth(1.8), // Sistema
                          1: FlexColumnWidth(1.5), // Lectura
                          2: FlexColumnWidth(1.2), // Estado
                          3: FlexColumnWidth(1.3), // Activado
                        },
                        children: [
                          const TableRow(
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Sistema',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Lectura',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Estado',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Activado',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ..._system.subsystems.map((sub) {
                            return TableRow(
                              children: [
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(sub.name),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(sub.value != null ? sub.value.toString() : 'No aplica'),
                                  ),
                                ),
                                TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(sub.status),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Checkbox(
                                      value: sub.active,
                                      onChanged: null,
                                      activeColor: Colors.grey,
                                      checkColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // mb-5

                  // Botones de acción
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0), 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 160, // w-10rem
                          child: ElevatedButton(
                            onPressed: () => _goToEditSystem(_system.id),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1856C3),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text('Editar'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          width: 160,
                          child: ElevatedButton(
                            onPressed: () => {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text('Eliminar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}