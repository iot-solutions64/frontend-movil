import 'package:flutter/material.dart';
import 'package:hydrosmart/core/resource.dart';
import 'package:hydrosmart/features/irrigation/data/repository/irrigation_repository.dart';
import 'package:hydrosmart/features/irrigation/domain/water_tank.dart';
import 'package:hydrosmart/features/soil/domain/crop.dart';

class SoilPage extends StatefulWidget {
  const SoilPage({super.key});

  @override
  State<SoilPage> createState() => _SoilPageState();
}

class _SoilPageState extends State<SoilPage> {
  List<Crop> _crops = [];
  List<WaterTank> _tanks = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchCrops();
  }
  void _fetchCrops() {
    setState(() {
      _isLoading = true;
    });
    IrrigationRepository().getWaterTanks().then((result) {
      if(result is Success) {
        setState(() {
          _tanks = result.data!;
          int id = _tanks.elementAt(0).id;
          _crops = [
          Crop(id: 1, name: 'Maiz Dulce', waterTankId: id),
          Crop(id: 2, name: 'Tomates Cherry', waterTankId: id),
          Crop(id: 3, name: 'Lechuga Romana', waterTankId: id),
          Crop(id: 4, name: 'Zanahorias', waterTankId: id),
          Crop(id: 5, name: 'Pimientos Rojos', waterTankId: id),
          Crop(id: 6, name: 'Espinacas', waterTankId: id),
          Crop(id: 7, name: 'Berenjenas', waterTankId: id),
          Crop(id: 8, name: 'Calabacines', waterTankId: id),
          Crop(id: 9, name: 'Brócoli', waterTankId: id),
          Crop(id: 10, name: 'Coliflor', waterTankId: id),
          Crop(id: 11, name: 'Cebollas', waterTankId: id),
          Crop(id: 12, name: 'Ajo', waterTankId: id),
          Crop(id: 13, name: 'Perejil', waterTankId: id),
          Crop(id: 14, name: 'Albahaca', waterTankId: id),
          Crop(id: 15, name: 'Cilantro', waterTankId: id),
          Crop(id: 16, name: 'Menta', waterTankId: id)
          ];
          _isLoading = false;
        });
      } else if (result is Error) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }
  
  void _showAddDialog() {
    final nombreController = TextEditingController();
    WaterTank selectedTanque = _tanks.isNotEmpty ? _tanks.first : WaterTank(id: 0, name: '', remainingLiters: 0, totalLiters: 0, status: '');

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
                  DropdownButtonFormField<WaterTank>(
                    value: selectedTanque,
                    decoration: const InputDecoration(labelText: 'Tanque de agua'),
                    items: _tanks
                        .map((tanque) => DropdownMenuItem(
                              value: tanque,
                              child: Text(tanque.name),
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
                      _crops.add(
                        Crop(
                          id: _crops.length + 1,
                          name: nombreController.text,
                          waterTankId: selectedTanque.id,
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
    WaterTank? selectedTanque = _tanks.firstWhere(
      (t) => t.id == cultivo.waterTankId,
      orElse: () => _tanks.isNotEmpty ? _tanks.first : WaterTank(id: 0, name: '', remainingLiters: 0, totalLiters: 0, status: ''),
    );

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
                  DropdownButtonFormField<WaterTank>(
                    value: selectedTanque,
                    decoration: const InputDecoration(labelText: 'Tanque de agua'),
                    items: _tanks
                        .map((tanque) => DropdownMenuItem(
                              value: tanque,
                              child: Text(tanque.name),
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
                      final index = _crops.indexWhere((c) => c.id == cultivo.id);
                      if (index != -1 && selectedTanque != null) {
                        _crops[index] = Crop(
                          id: cultivo.id,
                          name: nombreController.text,
                          waterTankId: selectedTanque!.id,
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
                  _crops.removeWhere((c) => c.id == cultivo.id);
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
    final screenHeight = MediaQuery.of(context).size.height;
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
      body: _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: screenHeight * 0.74,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Nombre')),
                      DataColumn(label: Text('Acciones')),
                    ],
                    rows: _crops.map((cultivo) {
                      return DataRow(cells: [
                        DataCell(Text(cultivo.id.toString())),
                        DataCell(Text(cultivo.name)),
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF092C4C),
        onPressed: _showAddDialog,
        tooltip: 'Añadir',
        child: const Icon(Icons.add, color: Colors.white),
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}