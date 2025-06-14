class CropRequestDto {
  final String name;
  final int userId;
  final int waterTankId;
  final double temperatureMinThreshold;
  final double temperatureMaxThreshold;
  final double humidityMinThreshold;
  final double humidityMaxThreshold;
  final int hourFrequency;
  final String irrigationStartDate;
  final String irrigationStartTime;
  final String irrigationDisallowedStartTime;
  final String irrigationDisallowedEndTime;
  final int irrigationDurationInMinutes;
  final double irrigationMaxWaterUsage;

  CropRequestDto({
    required this.name,
    required this.userId,
    required this.waterTankId,
    required this.temperatureMinThreshold,
    required this.temperatureMaxThreshold,
    required this.humidityMinThreshold,
    required this.humidityMaxThreshold,
    required this.hourFrequency,
    required this.irrigationStartDate,
    required this.irrigationStartTime,
    required this.irrigationDisallowedStartTime,
    required this.irrigationDisallowedEndTime,
    required this.irrigationDurationInMinutes,
    required this.irrigationMaxWaterUsage,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'userId': userId,
      'waterTankId': waterTankId,
      'temperatureMinThreshold': temperatureMinThreshold,
      'temperatureMaxThreshold': temperatureMaxThreshold,
      'humidityMinThreshold': humidityMinThreshold,
      'humidityMaxThreshold': humidityMaxThreshold,
      'hourFrequency': hourFrequency,
      'irrigationStartDate': irrigationStartDate,
      'irrigationStartTime': irrigationStartTime,
      'irrigationDisallowedStartTime': irrigationDisallowedStartTime,
      'irrigationDisallowedEndTime': irrigationDisallowedEndTime,
      'irrigationDurationInMinutes': irrigationDurationInMinutes,
      'irrigationMaxWaterUsage': irrigationMaxWaterUsage,
    };
  }

}