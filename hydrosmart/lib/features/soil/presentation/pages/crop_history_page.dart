import 'package:flutter/material.dart';
import 'package:hydrosmart/features/soil/domain/record.dart';
import 'package:hydrosmart/features/soil/constants/humidity_suggestions.dart';
import 'package:hydrosmart/features/soil/constants/temperature_suggestions.dart';

class CropHistoryPage extends StatefulWidget {
  const CropHistoryPage({super.key});

  @override
  State<CropHistoryPage> createState() => _CropHistoryPageState();
}

class _CropHistoryPageState extends State<CropHistoryPage> {
  late bool _isShortHistory;
  List<Record> _history = [];
  List<Record> _limitedHistory = [];
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final arguments = ModalRoute.of(context)?.settings.arguments;

      if (arguments is Map && arguments['cropId'] is int) {
        _isShortHistory = arguments['short'] == true;
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No se pudo cargar el historial. Volviendo...')),
          );
          Navigator.of(context).pop();
        });
        return;
      }

      _initialized = true;
      _fetchHistory();
    }
  }

  void _fetchHistory() {
    // For now, use the hardcoded data from your Vue example
    _history = [
      Record(id: 1, date: '24-04-2025', humidity: 67, humidityStatus: 'FAVORABLE', temperature: 24, temperatureStatus: 'FAVORABLE'),
      Record(id: 2, date: '25-04-2025', humidity: 72, humidityStatus: 'FAVORABLE', temperature: 30, temperatureStatus: 'FAVORABLE'),
      Record(id: 3, date: '26-04-2025', humidity: 65, humidityStatus: 'FAVORABLE', temperature: 28, temperatureStatus: 'FAVORABLE'),
      Record(id: 4, date: '27-04-2025', humidity: 70, humidityStatus: 'FAVORABLE', temperature: 26, temperatureStatus: 'FAVORABLE'),
      Record(id: 5, date: '28-04-2025', humidity: 82, humidityStatus: 'SLIGHTLY_UNFAVORABLE_UNDER', temperature: 32, temperatureStatus: 'SLIGHTLY_UNFAVORABLE_UNDER'),
      Record(id: 6, date: '29-04-2025', humidity: 75, humidityStatus: 'FAVORABLE', temperature: 29, temperatureStatus: 'FAVORABLE'),
      Record(id: 7, date: '30-04-2025', humidity: 80, humidityStatus: 'SLIGHTLY_UNFAVORABLE_OVER', temperature: 31, temperatureStatus: 'SLIGHTLY_UNFAVORABLE_OVER'),
      Record(id: 8, date: '01-05-2025', humidity: 78, humidityStatus: 'FAVORABLE', temperature: 27, temperatureStatus: 'FAVORABLE'),
      Record(id: 9, date: '02-05-2025', humidity: 74, humidityStatus: 'FAVORABLE', temperature: 25, temperatureStatus: 'FAVORABLE'),
      Record(id: 10, date: '03-05-2025', humidity: 71, humidityStatus: 'FAVORABLE', temperature: 25, temperatureStatus: 'FAVORABLE'),
      Record(id: 11, date: '04-05-2025', humidity: 69, humidityStatus: 'FAVORABLE', temperature: 22, temperatureStatus: 'FAVORABLE'),
      Record(id: 12, date: '05-05-2025', humidity: 66, humidityStatus: 'FAVORABLE', temperature: 26, temperatureStatus: 'FAVORABLE'),
      Record(id: 13, date: '06-05-2025', humidity: 64, humidityStatus: 'FAVORABLE', temperature: 20, temperatureStatus: 'FAVORABLE'),
      Record(id: 14, date: '07-05-2025', humidity: 63, humidityStatus: 'FAVORABLE', temperature: 23, temperatureStatus: 'FAVORABLE'),
      Record(id: 15, date: '08-05-2025', humidity: 62, humidityStatus: 'FAVORABLE', temperature: 24, temperatureStatus: 'FAVORABLE'),
      Record(id: 16, date: '09-05-2025', humidity: 61, humidityStatus: 'FAVORABLE', temperature: 28, temperatureStatus: 'FAVORABLE'),
      Record(id: 17, date: '10-05-2025', humidity: 60, humidityStatus: 'FAVORABLE', temperature: 42, temperatureStatus: 'UNFAVORABLE_OVER'),
      Record(id: 18, date: '11-05-2025', humidity: 59, humidityStatus: 'FAVORABLE', temperature: 24, temperatureStatus: 'FAVORABLE'),
      Record(id: 19, date: '12-05-2025', humidity: 58, humidityStatus: 'FAVORABLE', temperature: 23, temperatureStatus: 'FAVORABLE'),
      Record(id: 20, date: '13-05-2025', humidity: 57, humidityStatus: 'FAVORABLE', temperature: 20, temperatureStatus: 'FAVORABLE'),
      Record(id: 21, date: '14-05-2025', humidity: 56, humidityStatus: 'FAVORABLE', temperature: 25, temperatureStatus: 'FAVORABLE'),
      Record(id: 22, date: '15-05-2025', humidity: 55, humidityStatus: 'FAVORABLE', temperature: 25, temperatureStatus: 'FAVORABLE'),
      Record(id: 23, date: '16-05-2025', humidity: 54, humidityStatus: 'FAVORABLE', temperature: 22, temperatureStatus: 'FAVORABLE'),
      Record(id: 24, date: '17-05-2025', humidity: 53, humidityStatus: 'FAVORABLE', temperature: 26, temperatureStatus: 'FAVORABLE'),
      Record(id: 25, date: '18-05-2025', humidity: 52, humidityStatus: 'FAVORABLE', temperature: 24, temperatureStatus: 'FAVORABLE'),
      Record(id: 26, date: '19-05-2025', humidity: 51, humidityStatus: 'FAVORABLE', temperature: 23, temperatureStatus: 'FAVORABLE'),
      Record(id: 27, date: '20-05-2025', humidity: 50, humidityStatus: 'FAVORABLE', temperature: 22, temperatureStatus: 'FAVORABLE'),
      Record(id: 28, date: '21-05-2025', humidity: 20, humidityStatus: 'UNFAVORABLE_UNDER', temperature: 5, temperatureStatus: 'FREEZING'),
      Record(id: 29, date: '22-05-2025', humidity: 49, humidityStatus: 'FAVORABLE', temperature: 21, temperatureStatus: 'FAVORABLE'),
      Record(id: 30, date: '23-05-2025', humidity: 48, humidityStatus: 'FAVORABLE', temperature: 24, temperatureStatus: 'FAVORABLE'),
      Record(id: 31, date: '24-05-2025', humidity: 47, humidityStatus: 'FAVORABLE', temperature: 23, temperatureStatus: 'FAVORABLE'),
      Record(id: 32, date: '25-05-2025', humidity: 46, humidityStatus: 'FAVORABLE', temperature: 25, temperatureStatus: 'FAVORABLE'),
      Record(id: 33, date: '26-05-2025', humidity: 45, humidityStatus: 'FAVORABLE', temperature: 24, temperatureStatus: 'FAVORABLE'),
      Record(id: 34, date: '27-05-2025', humidity: 44, humidityStatus: 'FAVORABLE', temperature: 26, temperatureStatus: 'FAVORABLE'),
      Record(id: 35, date: '28-05-2025', humidity: 43, humidityStatus: 'FAVORABLE', temperature: 27, temperatureStatus: 'FAVORABLE'),
    ];

    setState(() {
      if (_isShortHistory) {
        _limitedHistory = _history.sublist(
          (_history.length > 30 ? _history.length - 30 : 0),
        ).reversed.toList();
      } else {
        _limitedHistory = _history.reversed.toList();
      }
    });
  }

  String _getHumidityTitle(String key) {
    return humiditySuggestions[key]?['title'] ?? key;
  }

  String _getTemperatureTitle(String key) {
    return temperatureSuggestions[key]?['title'] ?? key;
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
          _isShortHistory ? 'Historial de cultivo' : 'Historial detallado de cultivo',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0), 
            child: Text(
              _isShortHistory ? 'Datos de los últimos 30 días (promedio diario)' : 'Datos completos (promedio diario)',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                  child: DataTable(
                    columnSpacing: 16.0,
                    dataRowMinHeight: 48,
                    dataRowMaxHeight: 60,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          'Fecha',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Humedad (%)',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Estado de Humedad',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Temperatura (°C)',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Estado de Temperatura',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    rows: _limitedHistory.map((record) {
                      return DataRow(
                        cells: <DataCell>[
                          DataCell(Text(record.date)),
                          DataCell(Text('${record.humidity}%')),
                          DataCell(Text(_getHumidityTitle(record.humidityStatus))),
                          DataCell(Text('${record.temperature}°C')),
                          DataCell(Text(_getTemperatureTitle(record.temperatureStatus))),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}