import 'package:flutter/material.dart';
import 'package:hydrosmart/features/irrigation/domain/tank.dart';
import 'package:hydrosmart/features/irrigation/presentation/widgets/tank_card.dart';

class TanksPage extends StatefulWidget {
  const TanksPage({super.key});

  @override
  State<TanksPage> createState() => _TanksPageState();
}

class _TanksPageState extends State<TanksPage> {
  List<Tank> _tanks = [];
  int _nextTankId = 1; // Simple ID management for demo

  @override
  void initState() {
    super.initState();
    _fetchTanks(); // Load initial data
  }

  void _fetchTanks() {
    // TODO: Implement the logic to fetch items from a service
    setState(() {
      _tanks = [
        Tank(id: 1, name: 'Tanque A', remainingLiters: 7000, totalLiters: 8000),
        Tank(id: 2, name: 'Tanque B', remainingLiters: 800, totalLiters: 2000),
        Tank(id: 3, name: 'Tanque C', remainingLiters: 7200, totalLiters: 10000),
      ];
      // Set _nextTankId based on fetched data
      if (_tanks.isNotEmpty) {
        _nextTankId = _tanks.map((e) => e.id).reduce((a, b) => a > b ? a : b) + 1;
      } else {
        _nextTankId = 1;
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
                    if (double.tryParse(value) == null || double.parse(value!) <= 0) {
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
                  final newTank = Tank(
                    id: 0, // ID will be assigned by the parent page
                    name: nameController.text,
                    remainingLiters: double.parse(capacityController.text), // New tank starts full
                    totalLiters: double.parse(capacityController.text),
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

  void _showEditTankDialog(Tank tankToEdit) {
    // Initialize controllers with current tank data
    final nameController = TextEditingController(text: tankToEdit.name);
    final remainingLitersController = TextEditingController(text: tankToEdit.remainingLiters.toStringAsFixed(0));
    final capacityLitersController = TextEditingController(text: tankToEdit.totalLiters.toStringAsFixed(0));
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
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
                  controller: capacityLitersController,
                  decoration: const InputDecoration(labelText: 'Capacidad (Litros)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la capacidad';
                    }
                    if (double.tryParse(value) == null || double.parse(value!) <= 0) {
                      return 'Ingrese un número válido y positivo';
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
                    // Validate against current capacity being edited, NOT the _capacityLitersController.text (potential issue)
                    // It's safer to read the capacity from the controller *at the time of validation*
                    final currentCapacity = double.tryParse(capacityLitersController.text) ?? 0.0;
                    if (liters > currentCapacity) {
                      return 'Los litros restantes no pueden exceder la capacidad';
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
                if (formKey.currentState!.validate()) {
                  final updatedTank = Tank(
                    id: tankToEdit.id, // Keep original ID
                    name: nameController.text,
                    remainingLiters: double.parse(remainingLitersController.text),
                    totalLiters: double.parse(capacityLitersController.text),
                  );
                  _editTank(updatedTank); // Call the edit function in _TanksPageState
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

  void _showDeleteTankDialog(Tank tankToDelete) {
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

  // --- CRUD OPERATIONS (unchanged from previous version) ---
  void _saveTank(Tank newTank) {
    setState(() {
      newTank.id = _nextTankId++;
      _tanks.add(newTank);
    });
    _showCustomToast("Tanque agregado exitosamente!", backgroundColor: Colors.green);
  }

  void _editTank(Tank updatedTank) {
    setState(() {
      final index = _tanks.indexWhere((t) => t.id == updatedTank.id);
      if (index != -1) {
        _tanks[index] = updatedTank;
      }
    });
    _showCustomToast("Tanque editado exitosamente!", backgroundColor: Colors.blue);
  }

  void _deleteTank(int id) {
    setState(() {
      _tanks.removeWhere((t) => t.id == id);
    });
    _showCustomToast("Tanque eliminado exitosamente!", backgroundColor: Colors.red);
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
        child: Column(
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
                          onEdit: _showEditTankDialog, // Call the dialog function directly
                          onDelete: _showDeleteTankDialog, // Call the dialog function directly
                        );
                      },
                    ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0), // <-- Margen inferior
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF092C4C),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    tooltip: 'Añadir',
                    onPressed: _showAddTankDialog,
                  ),
                ),
              ),
            ),
          ],
        ),
        
      ),
    );
  }
}

