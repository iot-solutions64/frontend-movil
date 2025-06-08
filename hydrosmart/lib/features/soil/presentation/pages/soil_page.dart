import 'package:flutter/material.dart';
import 'package:hydrosmart/core/resource.dart';
import 'package:hydrosmart/features/irrigation/data/repository/irrigation_repository.dart';
import 'package:hydrosmart/features/irrigation/domain/water_tank.dart';
import 'package:hydrosmart/features/soil/constants/options.dart';
import 'package:hydrosmart/features/soil/data/repository/crop_repository.dart';
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
        });
      } else if (result is Error) {
        setState(() {
          _isLoading = false;
          _showCustomToast('Error al cargar los tanques de agua: ${result.message}', backgroundColor: Colors.red);
        });
      }
    });
    CropRepository().getCrops().then((res) {
      if (res is Success) {
        setState(() {
          _crops = res.data!;
          _isLoading = false;
        });
      } else if (res is Error) {
        setState(() {
          _isLoading = false;
          _showCustomToast('Error al cargar los cultivos: ${res.message}', backgroundColor: Colors.red);
        });
      }
    });
  }

  void _showCustomToast(String message, {Color backgroundColor = Colors.black, Color textColor = Colors.white}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: textColor)),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
  
  void _showAddDialog() {
    final nombreController = TextEditingController();
    WaterTank selectedTank = _tanks.isNotEmpty ? _tanks.first : WaterTank(id: 0, name: '', remainingLiters: 0, totalLiters: 0, status: '');

    String selectedHumidity = humidityOptions.keys.first;
    String selectedTemperature = temperatureOptions.keys.first;

    final irrigationDurationController = TextEditingController();
    final irrigationMaxWaterUsageController = TextEditingController();
    final hourFrequencyController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    int currentStep = 0;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            List<Widget> steps = [
              // Paso 1: Datos básicos
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nombreController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese un nombre';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<WaterTank>(
                    value: selectedTank,
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
                          selectedTank = value;
                        });
                      }
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedTemperature,
                    decoration: const InputDecoration(labelText: 'Tipo de temperatura'),
                    items: temperatureOptions.keys
                        .map((label) => DropdownMenuItem(
                              value: label,
                              child: Text(label),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setStateDialog(() {
                          selectedTemperature = value;
                        });
                      }
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedHumidity,
                    decoration: const InputDecoration(labelText: 'Tipo de humedad'),
                    items: humidityOptions.keys
                        .map((label) => DropdownMenuItem(
                              value: label,
                              child: Text(label),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setStateDialog(() {
                          selectedHumidity = value;
                        });
                      }
                    },
                  ),
                ],
              ),
              // Paso 2: Parámetros de irrigación
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: irrigationDurationController,
                    decoration: const InputDecoration(labelText: 'Duración de irrigación (minutos)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese la duración';
                      }
                      final int? minutes = int.tryParse(value);
                      if (minutes == null || minutes <= 0) {
                        return 'Ingrese un número mayor a 0';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: irrigationMaxWaterUsageController,
                    decoration: const InputDecoration(labelText: 'Uso máximo de agua (litros)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese el uso máximo de agua';
                      }
                      final double? liters = double.tryParse(value);
                      if (liters == null || liters <= 0) {
                        return 'Ingrese un número mayor a 0';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: hourFrequencyController,
                    decoration: const InputDecoration(labelText: 'Frecuencia de riego (horas)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese la frecuencia de riego';
                      }
                      final int? freq = int.tryParse(value);
                      if (freq == null || freq <= 0) {
                        return 'Ingrese un número mayor a 0';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ];

            return AlertDialog(
              title: const Text('Agregar Cultivo'),
              content: Form(
                key: formKey,
                child: steps[currentStep],
              ),
              actions: [
                if (currentStep == 0)
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xB41856C3),
                    ),
                  ),
                if (currentStep > 0)
                  TextButton(
                    onPressed: () {
                      setStateDialog(() {
                        currentStep--;
                      });
                    },
                    child: const Text('Anterior'),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xB41856C3),
                    ),
                  ),
                if (currentStep < steps.length - 1)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xB41856C3),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setStateDialog(() {
                          currentStep++;
                        });
                      }
                    },
                    child: const Text('Siguiente'),
                  ),
                if (currentStep == steps.length - 1)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xB41856C3),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          final tempRange = temperatureOptions[selectedTemperature]!;
                          final humRange = humidityOptions[selectedHumidity]!;
                          final now = DateTime.now();
                          final date = "${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
                          final hour = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
                          final crop = Crop(
                            id: _crops.length + 1,
                            name: nombreController.text,
                            waterTankId: selectedTank.id,
                            temperatureMinThreshold: tempRange[0],
                            temperatureMaxThreshold: tempRange[1],
                            humidityMinThreshold: humRange[0],
                            humidityMaxThreshold: humRange[1],
                            hourFrequency: int.tryParse(hourFrequencyController.text) ?? 1,
                            irrigationStartDate: date,
                            irrigationStartTime: hour,
                            irrigationDisallowedStartTime: '00:00:00',
                            irrigationDisallowedEndTime: '23:59:59',
                            irrigationDurationInMinutes: int.tryParse(irrigationDurationController.text) ?? 0,
                            irrigationMaxWaterUsage: double.tryParse(irrigationMaxWaterUsageController.text) ?? 0.0,
                          );
                          _saveCrop(crop);
                          Navigator.of(context).pop();
                        });
                      }
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

  void _showEditDialog(Crop crop) {
    String selectedHumidity = humidityOptions.entries
        .firstWhere(
          (e) =>
              e.value[0] == crop.humidityMinThreshold &&
              e.value[1] == crop.humidityMaxThreshold,
          orElse: () => humidityOptions.entries.first,
        )
        .key;

    String selectedTemperature = temperatureOptions.entries
        .firstWhere(
          (e) =>
              e.value[0] == crop.temperatureMinThreshold &&
              e.value[1] == crop.temperatureMaxThreshold,
          orElse: () => temperatureOptions.entries.first,
        )
        .key;

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
                  DropdownButtonFormField<String>(
                    value: selectedTemperature,
                    decoration: const InputDecoration(labelText: 'Tipo de temperatura'),
                    items: temperatureOptions.keys
                        .map((label) => DropdownMenuItem(
                              value: label,
                              child: Text(label),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setStateDialog(() {
                          selectedTemperature = value;
                        });
                      }
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedHumidity,
                    decoration: const InputDecoration(labelText: 'Tipo de humedad'),
                    items: humidityOptions.keys
                        .map((label) => DropdownMenuItem(
                              value: label,
                              child: Text(label),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setStateDialog(() {
                          selectedHumidity = value;
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
                      final tempRange = temperatureOptions[selectedTemperature]!;
                      final humRange = humidityOptions[selectedHumidity]!;
                      crop.temperatureMinThreshold = tempRange[0];
                      crop.temperatureMaxThreshold = tempRange[1];
                      crop.temperature = tempRange[0] + 1; // Placeholder for temperature, adjust as needed
                      crop.humidityMinThreshold = humRange[0];
                      crop.humidityMaxThreshold = humRange[1];
                      crop.humidity = humRange[0] + 1; // Placeholder for humidity, adjust as needed
                      _editCrop(crop);
                      Navigator.pop(context);
                    });
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

  void _showDeleteDialog(Crop crop) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar Cultivo'),
          content: Text('¿Seguro que deseas eliminar "${crop.name}"?'),
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
                  _deleteCrop(crop.id);
                  _showCustomToast('Cultivo eliminado exitosamente.', backgroundColor: Colors.green);
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

  void _saveCrop(Crop crop) {
    setState(() {
      CropRepository().addCrop(crop).then((result) {
        if (result is Success) {
          _fetchCrops();
          _showCustomToast('Cultivo guardado exitosamente.', backgroundColor: Colors.green);
        } else if (result is Error) {
          _showCustomToast('Error al guardar el cultivo: ${result.message}', backgroundColor: Colors.red);
        }
      });
    });
  }

  void _editCrop(Crop crop) {
    setState(() {
      CropRepository().putHumidity(crop).then((res) {
        if (res is Success) {
          CropRepository().putTemperature(crop).then((res) {
            if (res is Success) {
              _fetchCrops();
                _showCustomToast('Cultivo editado exitosamente.', backgroundColor: Colors.green);
            } else if (res is Error) {
              _showCustomToast('Error al editar la temperatura: ${res.message}', backgroundColor: Colors.red);
            }
          });
        } else if (res is Error) {
          _showCustomToast('Error al editar la humedad: ${res.message}', backgroundColor: Colors.red);
        }
      });
    });
  }

  void _deleteCrop(int id) {
    setState(() {
      CropRepository().deleteCrop(id).then((result) {
        if (result is Success) {
          _fetchCrops();
          _showCustomToast("Cultivo eliminado exitosamente!", backgroundColor: Colors.green);
        } else if (result is Error) {
          _showCustomToast(result.message!, backgroundColor: Colors.red);
        }
      });
    });
  }

  void _showCropDetail(Crop crop) {
    Navigator.pushNamed(context, '/crop_detail', arguments: crop);
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
                    rows: _crops.map((crop) {
                      return DataRow(cells: [
                        DataCell(Text(crop.id.toString())),
                        DataCell(Text(crop.name)),
                        DataCell(Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.search, color: Color(0xFF1856C3)),
                              onPressed: () => _showCropDetail(crop),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit, color: Color(0xFF27AE60)),
                              onPressed: () => _showEditDialog(crop),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Color(0xFFF84343)),
                              onPressed: () => _showDeleteDialog(crop),
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