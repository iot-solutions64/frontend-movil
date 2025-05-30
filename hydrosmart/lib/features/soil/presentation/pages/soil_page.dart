import 'package:flutter/material.dart';

class SoilPage extends StatefulWidget {
  const SoilPage({super.key});

  @override
  State<SoilPage> createState() => _SoilPageState();
}

class _SoilPageState extends State<SoilPage> {

  // Simulación de datos
  List<Map<String, dynamic>> cultivos = [
    {
      'id': '1',
      'nombre': 'Maiz Dulce',
      'cantidad': '6000',
      'riegoAutomatico': true,
    },
    {
      'id': '2',
      'nombre': 'Tomates Cherry',
      'cantidad': '8000',
      'riegoAutomatico': false,
    },
  ];

  void _showAddDialog() {
    final nombreController = TextEditingController();
    final cantidadController = TextEditingController();
    String selectedTanque = 'Tanque A';
    final List<String> tanques = ['Tanque A', 'Tanque B', 'Tanque C'];
    bool riegoAutomatico = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Agregar Cultivo'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nombreController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedTanque,
                    decoration: const InputDecoration(labelText: 'Tanque de agua'),
                    items: tanques
                        .map((tanque) => DropdownMenuItem(
                              value: tanque,
                              child: Text(tanque),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setStateDialog(() {
                          selectedTanque = value;
                        });
                      }
                    },
                  ),
                  TextField(
                    controller: cantidadController,
                    decoration: const InputDecoration(labelText: 'Cantidad máxima (litros)'),
                  ),
                  CheckboxListTile(
                    title: const Text('Riego automático'),
                    value: riegoAutomatico,
                    onChanged: (value) {
                      setStateDialog(() {
                        riegoAutomatico = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xB41856C3),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xB41856C3),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // Lógica para agregar cultivo
                    Navigator.pop(context);
                  },
                  child: const Text('Agregar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showEditDialog(String nombre, String cantidad, bool riegoInicial) {
    final nombreController = TextEditingController(text: nombre);
    final cantidadController = TextEditingController(text: cantidad);
    String selectedTanque = 'Tanque A';
    final List<String> tanques = ['Tanque A', 'Tanque B', 'Tanque C'];
    bool riegoAutomatico = riegoInicial;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Editar Cultivo'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nombreController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedTanque,
                    decoration: const InputDecoration(labelText: 'Tanque de agua'),
                    items: tanques
                        .map((tanque) => DropdownMenuItem(
                              value: tanque,
                              child: Text(tanque),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setStateDialog(() {
                          selectedTanque = value;
                        });
                      }
                    },
                  ),
                  TextField(
                    controller: cantidadController,
                    decoration: const InputDecoration(labelText: 'Cantidad máxima (litros)'),
                  ),
                  CheckboxListTile(
                    title: const Text('Riego automático'),
                    value: riegoAutomatico,
                    onChanged: (value) {
                      setStateDialog(() {
                        riegoAutomatico = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xB41856C3),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xB41856C3),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // Lógica para editar cultivo
                    Navigator.pop(context);
                  },
                  child: const Text('Guardar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDeleteDialog(String nombre) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar Cultivo'),
          content: Text('¿Seguro que deseas eliminar "$nombre"?'),
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
                // Lógica para eliminar cultivo
                Navigator.pop(context);
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
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Cultivos',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Nombre')),
                      DataColumn(label: Text('Cantidad')),
                      DataColumn(label: Text('Riego autom.')),
                      DataColumn(label: Text('Acciones')),
                    ],
                    rows: cultivos.map((cultivo) {
                      return DataRow(cells: [
                        DataCell(Text(cultivo['id'])),
                        DataCell(Text(cultivo['nombre'])),
                        DataCell(Text(cultivo['cantidad'])),
                        DataCell(
                          Checkbox(
                            value: cultivo['riegoAutomatico'],
                            onChanged: (value) {
                              setState(() {
                                cultivo['riegoAutomatico'] = value!;
                              });
                            },
                          ),
                        ),
                        DataCell(Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.search, color: Color(0xFF1856C3)),
                              onPressed: null,
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit, color: Color(0xFF27AE60)),
                              onPressed: () => _showEditDialog(cultivo['nombre'], cultivo['cantidad'], cultivo['riegoAutomatico']),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Color(0xFFF84343)),
                              onPressed: () => _showDeleteDialog(cultivo['nombre']),
                            ),
                          ],
                        )),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF092C4C),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  tooltip: 'Añadir',
                  onPressed: _showAddDialog,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}