class Crop {
  final int id;
  final String name;
  final int waterTankId;
  double temperatureMinThreshold;
  double temperatureMaxThreshold;
  double temperature;
  String temperatureStatus;
  double humidityMinThreshold;
  double humidityMaxThreshold;
  double humidity;
  String humidityStatus;
  final int hourFrequency;
  final String irrigationStartDate;
  final String irrigationStartTime;
  final String irrigationDisallowedStartTime;
  final String irrigationDisallowedEndTime;
  final int irrigationDurationInMinutes;
  final double irrigationMaxWaterUsage;

  Crop({
    required this.id,
    required this.name,
    required this.waterTankId,
    this.temperatureMinThreshold = 0.0,
    this.temperatureMaxThreshold = 0.0,
    this.temperature = 0.0,
    this.temperatureStatus = '',
    this.humidityMinThreshold = 0.0,
    this.humidityMaxThreshold = 0.0,
    this.humidity = 0.0,
    this.humidityStatus = '',
    this.hourFrequency = 0,
    this.irrigationStartDate = '',
    this.irrigationStartTime = '',
    this.irrigationDisallowedStartTime = '',
    this.irrigationDisallowedEndTime = '',
    this.irrigationDurationInMinutes = 0,
    this.irrigationMaxWaterUsage = 0.0,
  });

}