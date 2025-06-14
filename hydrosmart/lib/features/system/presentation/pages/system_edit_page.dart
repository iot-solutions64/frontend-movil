import 'package:flutter/material.dart';
import 'package:hydrosmart/features/system/domain/subsystem.dart';
import 'package:hydrosmart/features/system/domain/system.dart';

class SystemEditPage extends StatefulWidget {
  final System system;

  const SystemEditPage({super.key, required this.system});

  @override
  State<SystemEditPage> createState() => _SystemEditPageState();
}

class _SystemEditPageState extends State<SystemEditPage> {
  late TextEditingController _nameController;
  late List<Subsystem> _subsystems;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.system.name);
    _subsystems = widget.system.subsystems
        .map((s) => Subsystem(
              id: s.id,
              name: s.name,
              value: s.value,
              status: s.status,
              active: s.active,
            ))
        .toList();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Color _getBatteryColor(int percentage) {
    if (percentage >= 70) return const Color(0xFF27AE60);
    if (percentage >= 40) return const Color(0xFFF1C40F);
    if (percentage >= 20) return const Color(0xFFE67E22);
    return const Color(0xFFE74C3C);
  }

  void _saveChanges() {
    // Aquí puedes guardar los cambios (llamar a tu backend, etc.)
    // Por ahora solo regresa con los datos editados
    Navigator.of(context).pop(
      System(
        id: widget.system.id,
        name: _nameController.text,
        cropId: widget.system.cropId,
        batteryLevel: widget.system.batteryLevel,
        subsystems: _subsystems,
      ),
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
        title: const Text(
          'Editar sistema',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
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
                            color: _getBatteryColor(widget.system.batteryLevel),
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
                              '${widget.system.batteryLevel}%',
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
              // Editable system name
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del sistema',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width * 0.8),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FlexColumnWidth(1.8),
                      1: FlexColumnWidth(1.5),
                      2: FlexColumnWidth(1.2),
                      3: FlexColumnWidth(1.3),
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
                      ..._subsystems.asMap().entries.map((entry) {
                        final i = entry.key;
                        final sub = entry.value;
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
                                  onChanged: (val) {
                                    setState(() {
                                      _subsystems[i] = Subsystem(
                                        id: sub.id,
                                        name: sub.name,
                                        value: sub.value,
                                        status: sub.status,
                                        active: val ?? false,
                                      );
                                    });
                                  },
                                  activeColor: Colors.blue,
                                  checkColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 180,
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1856C3),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text('Guardar cambios'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}