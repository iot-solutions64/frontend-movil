import 'package:flutter/material.dart';
import 'package:hydrosmart/features/soil/domain/crop.dart';

class SoilPage extends StatefulWidget {
  const SoilPage({super.key});

  @override
  State<SoilPage> createState() => _SoilPageState();
}

class _SoilPageState extends State<SoilPage> {

  // Simulación de datos
  List<Crop> cultivos = [
    Crop(id: 1, name: 'Maiz Dulce', maxLiters: 6000, autoIrrigation: true, tankId: 1),
    Crop(id: 2, name: 'Tomates Cherry', maxLiters: 8000, autoIrrigation: false, tankId: 2),
    Crop(id: 3, name: 'Lechuga Romana', maxLiters: 5000, autoIrrigation: true, tankId: 1),
    Crop(id: 4, name: 'Zanahorias', maxLiters: 7000, autoIrrigation: false, tankId: 3),
    Crop(id: 5, name: 'Pimientos Rojos', maxLiters: 4000, autoIrrigation: true, tankId: 2),
    Crop(id: 6, name: 'Espinacas', maxLiters: 3000, autoIrrigation: true, tankId: 1),
    Crop(id: 7, name: 'Berenjenas', maxLiters: 2000, autoIrrigation: true, tankId: 2),
    Crop(id: 8, name: 'Calabacines', maxLiters: 1000, autoIrrigation: false, tankId: 3),
    Crop(id: 9, name: 'Brócoli', maxLiters: 9500, autoIrrigation: true, tankId: 1),
    Crop(id: 10, name: 'Coliflor', maxLiters: 1000, autoIrrigation: true, tankId: 2),
    Crop(id: 11, name: 'Cebollas', maxLiters: 2000, autoIrrigation: false, tankId: 3),
    Crop(id: 12, name: 'Ajo', maxLiters: 3000, autoIrrigation: true, tankId: 1),
    Crop(id: 13, name: 'Perejil', maxLiters: 14000, autoIrrigation: true, tankId: 2),
    Crop(id: 14, name: 'Albahaca', maxLiters: 5000, autoIrrigation: true, tankId: 3),
    Crop(id: 15, name: 'Cilantro', maxLiters: 5600, autoIrrigation: true, tankId: 1),
    Crop(id: 16, name: 'Menta', maxLiters: 7000, autoIrrigation: false, tankId: 2),
  ];

  List<String> tanques = ['Tanque A', 'Tanque B', 'Tanque C'];

  String _getTanqueName(int tankId) {
    switch (tankId) {
      case 1:
        return 'Tanque A';
      case 2:
        return 'Tanque B';
      case 3:
        return 'Tanque C';
      default:
        return 'Desconocido';
    }
  }
  
    void _showAddDialog() {
    final nombreController = TextEditingController();
    final cantidadController = TextEditingController();
    String selectedTanque = tanques[0];
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
                    keyboardType: TextInputType.number,
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
                    setState(() {
                      cultivos.add(
                        Crop(
                          id: cultivos.length + 1,
                          name: nombreController.text,
                          maxLiters: int.tryParse(cantidadController.text) ?? 0,
                          autoIrrigation: riegoAutomatico,
                          tankId: tanques.indexOf(selectedTanque) + 1,
                        ),
                      );
                    });
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

  void _showEditDialog(Crop cultivo) {
    final nombreController = TextEditingController(text: cultivo.name);
    final cantidadController = TextEditingController(text: cultivo.maxLiters.toString());
    String selectedTanque = _getTanqueName(cultivo.tankId);
    bool riegoAutomatico = cultivo.autoIrrigation;

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
                    keyboardType: TextInputType.number,
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
                    setState(() {
                      final index = cultivos.indexWhere((c) => c.id == cultivo.id);
                      if (index != -1) {
                        cultivos[index] = Crop(
                          id: cultivo.id,
                          name: nombreController.text,
                          maxLiters: int.tryParse(cantidadController.text) ?? 0,
                          autoIrrigation: riegoAutomatico,
                          tankId: tanques.indexOf(selectedTanque) + 1,
                        );
                      }
                    });
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

  void _showDeleteDialog(Crop cultivo) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar Cultivo'),
          content: Text('¿Seguro que deseas eliminar "${cultivo.name}"?'),
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
                setState(() {
                  cultivos.removeWhere((c) => c.id == cultivo.id);
                });
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
                        DataCell(Text(cultivo.id.toString())),
                        DataCell(Text(cultivo.name)),
                        DataCell(Text(cultivo.maxLiters.toString())),
                        DataCell(
                          Checkbox(
                            value: cultivo.autoIrrigation,
                            onChanged: (value) {
                              setState(() {
                                final index = cultivos.indexWhere((c) => c.id == cultivo.id);
                                if (index != -1) {
                                  cultivos[index] = Crop(
                                    id: cultivo.id,
                                    name: cultivo.name,
                                    maxLiters: cultivo.maxLiters,
                                    autoIrrigation: value ?? false,
                                    tankId: cultivo.tankId,
                                  );
                                }
                              });
                            },
                          ),
                        ),
                        DataCell(Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.search, color: Color(0xFF1856C3)),
                              onPressed: () {
                                Navigator.pushNamed(context, '/crop_detail', arguments: cultivo);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit, color: Color(0xFF27AE60)),
                              onPressed: () => _showEditDialog(cultivo),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Color(0xFFF84343)),
                              onPressed: () => _showDeleteDialog(cultivo),
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