import 'package:flutter/material.dart';
import 'package:hydrosmart/features/system/domain/subsystem.dart';
import 'package:hydrosmart/features/system/domain/system.dart';


class SystemDetailPage extends StatefulWidget {
  final System? system;

  const SystemDetailPage({super.key, required this.system});

  @override
  State<SystemDetailPage> createState() => _SystemDetailPageState();
}

class _SystemDetailPageState extends State<SystemDetailPage> {
  System _system = System();

  @override
  void initState() {
    super.initState();
    _fetchSystemDetails(widget.system!);
  }

  void _fetchSystemDetails(System system) {
    // TODO: Implementar la lógica para obtener datos del sistema desde un servicio
    // Aquí simulamos la carga de datos con los valores de ejemplo
    setState(() {
      _system = System(
        id: system.id,
        name: system.name,
        cropId: system.cropId,
        batteryLevel: system.batteryLevel,
        subsystems: system.subsystems.map((sub) {
          return Subsystem(
            id: sub.id,
            name: sub.name,
            value: sub.value,
            status: sub.status,
            active: sub.active,
          );
        }).toList(),
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

  void _goToEditSystem() {
    Navigator.pushNamed(context, '/system_edit', arguments: _system);
  }

      void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar Sistema'),
          content: Text('¿Seguro que deseas eliminar #${_system.id} "${_system.name}"?'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF212121),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF84343),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // To Do: logica para eliminar el sistema
                Navigator.pop(context);
                Navigator.of(context).pop(); 
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
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
                                      activeColor: Colors.blue,
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
                            onPressed: () => _goToEditSystem(),
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
                            onPressed: _showDeleteDialog,
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