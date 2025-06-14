import 'package:flutter/material.dart';
import 'package:hydrosmart/core/resource.dart';
import 'package:hydrosmart/features/irrigation/data/repository/irrigation_repository.dart';
import 'package:hydrosmart/features/irrigation/domain/water_tank.dart';
import 'package:hydrosmart/features/irrigation/presentation/widgets/tank_card.dart';

class TanksPage extends StatefulWidget {
  const TanksPage({super.key});

  @override
  State<TanksPage> createState() => _TanksPageState();
}

class _TanksPageState extends State<TanksPage> {
  List<WaterTank> _tanks = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchTanks(); // Load initial data
  }

  void _fetchTanks() {
    setState(() {
      _isLoading = true;
    });
    IrrigationRepository().getWaterTanks().then((result) {
      if (result is Success) {
        setState(() {
          _tanks = result.data!;
          _isLoading = false;
        });
      } else if (result is Error) {
        setState(() {
          _isLoading = false;
        });
        //_showCustomToast(result.message!, backgroundColor: Colors.red);
      }
    });
  }

  void _showCustomToast(String message, {Color backgroundColor = Colors.black, Color textColor = Colors.white}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: textColor)),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating, // Makes it float instead of occupying space
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16), // Gives it some margin
      ),
    );
  }

  // --- DIALOG FUNCTIONS ---
  void _showAddTankDialog() {
    final nameController = TextEditingController();
    final capacityController = TextEditingController();
    final formKey = GlobalKey<FormState>(); // Key for form validation

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar Nuevo Tanque'),
          content: Form(
            key: formKey, // Assign the form key
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nombre del Tanque'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese un nombre';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: capacityController,
                  decoration: const InputDecoration(labelText: 'Capacidad (Litros)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la capacidad';
                    }
                    if (double.tryParse(value) == null || double.parse(value) <= 0) {
                      return 'Ingrese un número válido y positivo';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xB41856C3),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xB41856C3),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) { // Validate the form
                  final newTank = WaterTank(
                    id: 0,
                    name: nameController.text,
                    remainingLiters: double.parse(capacityController.text),
                    totalLiters: double.parse(capacityController.text),
                    status: 'ACTIVATED'
                  );
                  _saveTank(newTank); // Call the save function in _TanksPageState
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _showEditTankDialog(WaterTank tankToEdit) {
    final nameController = TextEditingController(text: tankToEdit.name);
    final remainingLitersController = TextEditingController(text: tankToEdit.remainingLiters.toStringAsFixed(0));
    final capacityLitersController = TextEditingController(text: tankToEdit.totalLiters.toStringAsFixed(0));
    bool isActivated = tankToEdit.status == 'ACTIVATED';
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Editar Tanque'),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Nombre del Tanque'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese un nombre';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: remainingLitersController,
                      decoration: const InputDecoration(labelText: 'Litros Restantes'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese los litros restantes';
                        }
                        final double? liters = double.tryParse(value);
                        if (liters == null || liters < 0) {
                          return 'Ingrese un número válido y no negativo';
                        }
                        final currentCapacity = double.tryParse(capacityLitersController.text) ?? 0.0;
                        if (liters > currentCapacity) {
                          return 'Los litros restantes no pueden exceder la capacidad';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: isActivated,
                          onChanged: (val) {
                            setStateDialog(() {
                              isActivated = val ?? false;
                            });
                          },
                          activeColor: Colors.blue,
                          checkColor: Colors.white,
                        ),
                        const Text('Tanque activado'),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xB41856C3),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xB41856C3),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final updatedTank = WaterTank(
                        id: tankToEdit.id,
                        name: nameController.text,
                        remainingLiters: double.parse(remainingLitersController.text),
                        totalLiters: double.parse(capacityLitersController.text),
                        status: isActivated ? 'ACTIVATED' : 'DEACTIVATED',
                      );
                      _editTank(updatedTank);
                      Navigator.of(context).pop();
                    }
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

  void _showDeleteTankDialog(WaterTank tankToDelete) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar Tanque'),
          content: Text('¿Estás seguro de que quieres eliminar el tanque "${tankToDelete.name}"?'),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xB4000000),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteTank(tankToDelete.id); // Call the delete function in _TanksPageState
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Eliminar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _saveTank(WaterTank newTank) {
    setState(() {
      IrrigationRepository().addWaterTank(newTank.name, newTank.totalLiters).then((result) {
        if (result is Success) {
          _showCustomToast("Tanque agregado exitosamente!", backgroundColor: Colors.green);
          _fetchTanks();
        } else if (result is Error) {
          _showCustomToast(result.message!, backgroundColor: Colors.red);
        }
      });
    });
  }

  void _editTank(WaterTank updatedTank) {
    setState(() {
      IrrigationRepository().patchName(updatedTank).then((result) {
        if (result is Success) {
          IrrigationRepository().patchRemainingWater(updatedTank).then((res) {
            if (res is Success) {
              IrrigationRepository().patchStatus(updatedTank).then((r) {
                if (r is Success) {
                  _fetchTanks();
                  _showCustomToast("Tanque actualizado exitosamente!", backgroundColor: Colors.green);
                } else if (r is Error) {
                  _showCustomToast(r.message!, backgroundColor: Colors.red);
                }
              });
            } else if (res is Error) {
              _showCustomToast(result.message!, backgroundColor: Colors.red);
            }
          });
        } else if (result is Error) {
          _showCustomToast(result.message!, backgroundColor: Colors.red);
        }
      });
      
    });
  }

  void _deleteTank(int id) {
    setState(() {
      IrrigationRepository().deleteWaterTank(id).then((result) {
        if (result is Success) {
          _fetchTanks();
          _showCustomToast("Tanque eliminado exitosamente!", backgroundColor: Colors.green);
        } else if (result is Error) {
          _showCustomToast(result.message!, backgroundColor: Colors.red);
        }
      });
    });
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
          'Tanques',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: _tanks.isEmpty
                        ? const Center(child: Text('No hay tanques registrados.'))
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            itemCount: _tanks.length,
                            itemBuilder: (context, index) {
                              final tank = _tanks[index];
                              return TankCard(
                                tank: tank,
                                onEdit: _showEditTankDialog,
                                onDelete: _showDeleteTankDialog,
                              );
                            },
                          ),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF092C4C),
        onPressed: _showAddTankDialog,
        tooltip: 'Añadir',
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

}

