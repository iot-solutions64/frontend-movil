import 'package:flutter/material.dart';
import 'package:hydrosmart/core/resource.dart';
import 'package:hydrosmart/features/soil/constants/humidity_suggestions.dart';
import 'package:hydrosmart/features/soil/constants/temperature_suggestions.dart';
import 'package:hydrosmart/features/soil/data/repository/crop_repository.dart';
import 'package:hydrosmart/features/soil/domain/crop.dart';
import 'package:hydrosmart/features/soil/domain/crop_detailed.dart';
import 'package:hydrosmart/features/soil/domain/humidity.dart';
import 'package:hydrosmart/features/soil/domain/temperature.dart';

class CropDetailPage extends StatefulWidget {

  const CropDetailPage({super.key});

  @override
  State<CropDetailPage> createState() => _CropDetailPageState();
}

class _CropDetailPageState extends State<CropDetailPage> {
  Crop? _crop;
  CropDetailed? _cropDetail;
  int _cropId = 0;
  Temperature _temperature = Temperature();
  Humidity _humidity = Humidity();
  bool _initialized = false;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Crop) {
        _crop = args;
        _cropId = _crop!.id;
        _fetchCropDetail();
        _initialized = true;
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No se pudo cargar el cultivo.')),
          );
          Navigator.of(context).pop();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void _fetchCropDetail() {
    setState(() {
      _isLoading = true;
    });

    if (!_initialized) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Crop) {
        _crop = args;
        _cropId = _crop!.id;
        CropRepository().getCropDetailed(_crop!.id).then((result) {
        if (result is Success) {
          setState(() {
            _cropDetail = result.data;
            
            _humidity = Humidity(humidity: _cropDetail!.humidity, minThreshold: _cropDetail!.humidityMinThreshold,
              maxThreshold: _cropDetail!.humidityMaxThreshold, status: _cropDetail!.humidityStatus);

            _temperature = Temperature(temperature: _cropDetail!.temperature, minThreshold: _cropDetail!.temperatureMinThreshold,
              maxThreshold: _cropDetail!.temperatureMaxThreshold, status: _cropDetail!.temperatureStatus);

            _isLoading = false;
          });
        } else if (result is Error) {
          setState(() {
            _isLoading = false;
          });
        }
      });
        _initialized = true;
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No se pudo cargar el cultivo.')),
          );
          Navigator.of(context).pop();
        });
      }
    }
  }

  void _goToTemperatureActions(int temperatureId) {
    Navigator.of(context).pushNamed('/recommended_actions', arguments: {'id': temperatureId, 'isHumidity': false});
  }

  void _goToHumidityActions(int humidityId) {
    Navigator.of(context).pushNamed('/recommended_actions', arguments: {'id': humidityId, 'isHumidity': true});
  }

  void _goToShortHistory() {
    Navigator.of(context).pushNamed('/crop_history', arguments: {'cropId': _cropId, 'short': true});
  }

  void _goToCompleteHistory() {
    Navigator.of(context).pushNamed('/crop_history', arguments: {'cropId': _cropId, 'short': false});
  }

  void _goToSystem() {
    Navigator.of(context).pop();
  }

  // Helper function for system info buttons (retained)
  Widget _buildSystemInfoButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required String subtitle,
    required VoidCallback onPressed,
  }) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: const Color(0xFF1856C3)),
              const SizedBox(height: 3),
              Flexible(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSensorCard({
    required BuildContext context,
    required String type, // "Humedad" or "Temperatura"
    required IconData icon,
    required Color iconColor,
    required String reading,
    required String statusTitle,
    required Color statusColor,
    required String statusMessage,
    required VoidCallback onRecommendationsPressed, 
    required bool showButton,
  }) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(icon, size: 30, color: iconColor),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        type,
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                      Text(
                        reading,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Tooltip(
                  message: statusMessage,
                  child: Text(
                    statusTitle,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
                Icon(
                  showButton ? Icons.close : Icons.check,
                  color: statusColor,
                  size: 24,
                ),
              ],
            ),
            if (showButton) 
              Column(
                children: [
                  const SizedBox(height: 24), // Spacer before the button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: onRecommendationsPressed,
                      label: const Text('Ver recomendaciones'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1856C3), // <-- Azul
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_cropDetail == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final humidityStatusDetails = HUMIDITY_SUGGESTIONS[_humidity.status];
    final temperatureStatusDetails = TEMPERATURE_SUGGESTIONS[_temperature.status];

    Color humidityStatusColor = Colors.green;
    bool humidityShowButton = true; // Assume true initially
    if (_humidity.status == 'SLIGHTLY_UNFAVORABLE_UNDER' || _humidity.status == 'SLIGHTLY_UNFAVORABLE_OVER') {
      humidityStatusColor = Colors.orange;
    } else if (_humidity.status == 'UNFAVORABLE_UNDER' || _humidity.status == 'UNFAVORABLE_OVER' || _humidity.status == 'FLOODED' || _humidity.status == 'DRY') {
      humidityStatusColor = Colors.red;
    } else if (_humidity.status == 'FAVORABLE') {
      humidityStatusColor = Colors.green;
      humidityShowButton = false; // Hide button if favorable
    }

    Color temperatureStatusColor = Colors.green;
    bool temperatureShowButton = true; // Assume true initially
    if (_temperature.status == 'SLIGHTLY_UNFAVORABLE_UNDER' || _temperature.status == 'SLIGHTLY_UNFAVORABLE_OVER') {
      temperatureStatusColor = Colors.orange;
    } else if (_temperature.status == 'UNFAVORABLE_UNDER' || _temperature.status == 'UNFAVORABLE_OVER' || _temperature.status == 'BURNING' || _temperature.status == 'FREEZING') {
      temperatureStatusColor = Colors.red;
    } else if (_temperature.status == 'FAVORABLE') {
      temperatureStatusColor = Colors.green;
      temperatureShowButton = false; // Hide button if favorable
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Volver',
        ),
        title: const Text(
          'Detalles de cultivo',
          style: TextStyle(fontWeight: FontWeight.bold),
          ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Información de los sensores',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Humidity Card
            _buildSensorCard(
              context: context,
              type: 'Humedad',
              icon: Icons.water_drop_outlined,
              iconColor: const Color(0xFF1856C3), // Blue color
              reading: '${_humidity.humidity}%',
              statusTitle: humidityStatusDetails?['title'] ?? 'N/A',
              statusColor: humidityStatusColor,
              statusMessage: humidityStatusDetails?['message'] ?? 'N/A',
              onRecommendationsPressed: () => _goToHumidityActions(humidityStatusDetails?['id'] ?? 0),
              showButton: humidityShowButton, // Pass the visibility flag
            ),
            const SizedBox(height: 16), // Space between cards

            // Temperature Card
            _buildSensorCard(
              context: context,
              type: 'Temperatura',
              icon: Icons.thermostat,
              iconColor: const Color(0xFFE1AF43), // Yellow color
              reading: '${_temperature.temperature}°C',
              statusTitle: temperatureStatusDetails?['title'] ?? 'N/A',
              statusColor: temperatureStatusColor,
              statusMessage: temperatureStatusDetails?['message'] ?? 'N/A',
              onRecommendationsPressed: () => _goToTemperatureActions(temperatureStatusDetails?['id'] ?? 0),
              showButton: temperatureShowButton, // Pass the visibility flag
            ),
            const SizedBox(height: 32),

            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Información del sistema',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),

            GridView.count(
              crossAxisCount: MediaQuery.of(context).size.width > 768 ? 3 : (MediaQuery.of(context).size.width > 480 ? 2 : 1),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              childAspectRatio: 2.5,
              children: [
                _buildSystemInfoButton(
                  context: context,
                  label: 'Visualizar historial de cultivos',
                  icon: Icons.calendar_today,
                  subtitle: 'Últimos 30 días',
                  onPressed: _goToShortHistory,
                ),
                _buildSystemInfoButton(
                  context: context,
                  label: 'Visualizar historial completo',
                  icon: Icons.history,
                  subtitle: 'Todo el tiempo',
                  onPressed: _goToCompleteHistory,
                ),
                _buildSystemInfoButton(
                  context: context,
                  label: 'Visualizar sistema de cultivo',
                  icon: Icons.settings,
                  subtitle: 'Datos del sistema',
                  onPressed: _goToSystem,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


}
