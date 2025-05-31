import 'package:flutter/material.dart';
import 'package:hydrosmart/features/irrigation/domain/monthly_water_usage.dart';

class IrrigationPage extends StatefulWidget {
  const IrrigationPage({super.key});

  @override
  State<IrrigationPage> createState() => _IrrigationPageState();
}

class _IrrigationPageState extends State<IrrigationPage> {
  int _remainingLiters = 0;
  int _totalLiters = 0;
  String _resultMessage = '';
  List<MonthlyWaterUsage> _monthlyHistory = [];

  @override
  void initState() {
    super.initState();
    _fetchWaterData();
  }

  void _fetchWaterData() {
    // TODO: Implement the logic to fetch items from a service
    setState(() {
      _remainingLiters = 15000;
      _totalLiters = 20000;
      _resultMessage = 'El agua restante es suficiente para el riego.';
      _monthlyHistory = [
        MonthlyWaterUsage(mes: 'Noviembre 2024', cantidad: 69000),
        MonthlyWaterUsage(mes: 'Diciembre 2024', cantidad: 125000),
        MonthlyWaterUsage(mes: 'Enero 2025', cantidad: 110250),
        MonthlyWaterUsage(mes: 'Febrero 2025', cantidad: 134500),
        MonthlyWaterUsage(mes: 'Marzo 2025', cantidad: 95000),
      ];
    });
  }

  void _goToTanks() {
    Navigator.of(context).pushNamed('/tanks');
  }

  void _gotToWaterGraph() {
    Navigator.of(context).pushNamed('/water_graph');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Gestión de Agua',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 20.0,
              runSpacing: 20.0,
              children: [
                // Tank Data Section
                SizedBox(
                  width: screenWidth > 960 ? screenWidth * 0.45 : screenWidth * 0.9, // lg:w-5, w-10
                  child: Column(
                    children: [
                      const Text(
                        'Datos de tanques',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16), // mb-5 for card

                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: 150, // h-15rem approx
                            maxWidth: 400, // max-w-40rem approx
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Water Drop Icon
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF1856C3).withOpacity(0.3),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.water_drop_outlined,
                                            size: 40, color: Color(0xFF1856C3)),
                                      ),
                                    ),
                                    const SizedBox(width: 20), // xl:gap-5, gap-1

                                    // Water Data
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Total de agua restante',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF1856C3),
                                          ),
                                        ),
                                        Text(
                                          '$_remainingLiters / $_totalLiters L',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 25,
                                            color: Theme.of(context).textTheme.bodyLarge?.color,
                                          ),
                                        ),
                                        // This text is conditionally hidden on smaller screens
                                        if (screenWidth > 768) // @media (max-width: 768px) { display: none; }
                                          ConstrainedBox(
                                            constraints: const BoxConstraints(maxWidth: 250),
                                            child: Text(
                                              _resultMessage.isNotEmpty ? 'Resultado: $_resultMessage' : '',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                                // Result message visible on small screens (footer equivalent)
                                if (screenWidth <= 768 && _resultMessage.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: Text(
                                      'Resultado: $_resultMessage',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 180, // w-15rem approx
                        child: ElevatedButton(
                          onPressed: _goToTanks,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color(0xFF1856C3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text('Ver tanques'),
                        ),
                      ),
                    ],
                  ),
                ),

                // Monthly History Section
                SizedBox(
                  width: screenWidth > 960 ? screenWidth * 0.45 : screenWidth * 0.9, // lg:w-5, w-10
                  child: Column(
                    children: [
                      const Text(
                        'Historial mensual',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16), // mb-5 for table
                      SingleChildScrollView( 
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: screenWidth * (screenWidth > 960 ? 0.45 : 0.9),
                          ),
                          child: DataTable(
                            columnSpacing: 24.0,
                            dataRowMinHeight: 48,
                            dataRowMaxHeight: 60,
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Mes',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Cantidad utilizada (L)',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            rows: _monthlyHistory.map((data) {
                              return DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(data.mes)),
                                  DataCell(Text('${data.cantidad}')),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16), // Margin after table
                      SizedBox(
                        width: 250, // w-15rem approx, slightly wider for "Ver historial detallado"
                        child: ElevatedButton(
                          onPressed: _gotToWaterGraph,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color(0xFF1856C3),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text('Ver historial detallado'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}