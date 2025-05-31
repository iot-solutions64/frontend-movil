import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hydrosmart/features/irrigation/domain/monthly_water_usage.dart';

class WaterGraphPage extends StatefulWidget {
  const WaterGraphPage({super.key});

  @override
  State<WaterGraphPage> createState() => _WaterGraphPageState();
}

class _WaterGraphPageState extends State<WaterGraphPage> {
  List<MonthlyWaterUsage> _monthlyHistory = [];

  BarChartData? _barChartData;

  @override
  void initState() {
    super.initState();
    _fetchMonthlyHistory();
  }

  void _fetchMonthlyHistory() {
    // TODO: Implement the logic to fetch items from a service
    setState(() {
      _monthlyHistory = [
        MonthlyWaterUsage(mes: 'Noviembre 2024', cantidad: 69000),
        MonthlyWaterUsage(mes: 'Diciembre 2024', cantidad: 125000),
        MonthlyWaterUsage(mes: 'Enero 2025', cantidad: 110250),
        MonthlyWaterUsage(mes: 'Febrero 2025', cantidad: 134500),
        MonthlyWaterUsage(mes: 'Marzo 2025', cantidad: 95000),
      ];
      _barChartData = _setChartDataAndOptions();
    });
  }

  BarChartData _setChartDataAndOptions() {
    final List<String> labels = _monthlyHistory.map((item) => item.mes).toList();
    final List<double> data = _monthlyHistory.map((item) => item.cantidad.toDouble()).toList();

    double maxY = data.isNotEmpty ? data.reduce((a, b) => a > b ? a : b) : 100.0;
    maxY = (maxY * 1.2).ceilToDouble();

    Widget getBottomTitles(double value, TitleMeta meta) {
      const style = TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      );
      String text = '';
      if (value.toInt() >= 0 && value.toInt() < labels.length) {
        text = labels[value.toInt()];
      }
      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 10,
        child: RotatedBox(
          quarterTurns: 3,
          child: Text(text, style: style, textAlign: TextAlign.center),
        ),
      );
    }


    Widget getLeftTitles(double value, TitleMeta meta) {
      const style = TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      );

      String text = '${value.toInt()} L';
      if (value > 1000) {
        text = '${(value / 1000).toInt()}k L';
      }
      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 10,
        child: Text(text, style: style),
      );
    }

    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: maxY,
      minY: 0,
      barTouchData: BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            final month = labels[group.x.toInt()];
            return BarTooltipItem(
              '$month\n',
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: '${rod.toY.toStringAsFixed(0)} L',
                  style: const TextStyle(
                    color: Color(0xFF95BCF3),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getBottomTitles,
            reservedSize: 60,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getLeftTitles,
            reservedSize: 50,
            interval: maxY / 4,
          ),
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey.shade300,
            strokeWidth: 1,
          );
        },
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(_monthlyHistory.length, (index) {
        final item = _monthlyHistory[index];
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: item.cantidad.toDouble(),
              color: const Color.fromARGB(255, 42, 104, 212),
              width: 20,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Volver',
        ),
        title: const Text(
          'Historial de consumo',
          style: TextStyle(fontWeight: FontWeight.bold),
          ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Litros de agua consumidos por mes',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Center( 
              child: SizedBox(
                width: screenWidth > 960 ? screenWidth * 0.55 : screenWidth * 0.9, 
                height: 300,
                child: _barChartData == null
                    ? const Center(child: CircularProgressIndicator())
                    : BarChart(
                        _barChartData!,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}