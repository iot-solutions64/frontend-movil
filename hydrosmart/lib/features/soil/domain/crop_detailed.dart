class CropDetailed {
  final int cropId;
  final String cropName;
  final int userId;
  final double temperatureMinThreshold;
  final double temperatureMaxThreshold;
  final double temperature;
  final String temperatureStatus;
  final double humidityMinThreshold;
  final double humidityMaxThreshold;
  final double humidity;
  final String humidityStatus;
  String waterTankName;
  double waterAmountRemaining;
  double maxWaterCapacity;
  String waterTankStatus;
  int irrigationHourFrequency;
  String irrigationStartDate;
  String irrigationStartTime;
  String irrigationDisallowedStartTime;
  String irrigationDisallowedEndTime;
  int irrigationDurationInMinutes;
  String irrigationStatus;
  double irrigationMaxWaterUsage;

  CropDetailed({
    required this.cropId,
    required this.cropName,
    required this.userId,
    required this.temperatureMinThreshold,
    required this.temperatureMaxThreshold,
    required this.temperature,
    required this.temperatureStatus,
    required this.humidityMinThreshold,
    required this.humidityMaxThreshold,
    required this.humidity,
    required this.humidityStatus,
    this.waterTankName = '',
    this.waterAmountRemaining = 0.0,
    this.maxWaterCapacity = 0.0,
    this.waterTankStatus = '',
    this.irrigationHourFrequency = 0,
    this.irrigationStartDate = '',
    this.irrigationStartTime = '',
    this.irrigationDisallowedStartTime = '',
    this.irrigationDisallowedEndTime = '',
    this.irrigationDurationInMinutes = 0,
    this.irrigationStatus = '',
    this.irrigationMaxWaterUsage = 0.0,
  });

}