import 'package:hydrosmart/features/soil/domain/crop_detailed.dart';

class CropDetailedResponseDto {
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
  final String waterTankName;
  final double waterAmountRemaining;
  final double maxWaterCapacity;
  final String waterTankStatus;
  final int irrigationHourFrequency;
  final String irrigationStartDate;
  final String irrigationStartTime;
  final String irrigationDisallowedStartTime;
  final String irrigationDisallowedEndTime;
  final int irrigationDurationInMinutes;
  final String irrigationStatus;
  final double irrigationMaxWaterUsage;

  CropDetailedResponseDto({
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
    required this.waterTankName,
    required this.waterAmountRemaining,
    required this.maxWaterCapacity,
    required this.waterTankStatus,
    required this.irrigationHourFrequency,
    required this.irrigationStartDate,
    required this.irrigationStartTime,
    required this.irrigationDisallowedStartTime,
    required this.irrigationDisallowedEndTime,
    required this.irrigationDurationInMinutes,
    required this.irrigationStatus,
    required this.irrigationMaxWaterUsage,
  });

  factory CropDetailedResponseDto.fromJson(Map<String, dynamic> json) {
    return CropDetailedResponseDto(
      cropId: json['cropId'],
      cropName: json['cropName'],
      userId: json['userId'],
      temperatureMinThreshold: json['temperatureMinThreshold'],
      temperatureMaxThreshold: json['temperatureMaxThreshold'],
      temperature: json['temperature'],
      temperatureStatus: json['temperatureStatus'],
      humidityMinThreshold: json['humidityMinThreshold'],
      humidityMaxThreshold: json['humidityMaxThreshold'],
      humidity: json['humidity'],
      humidityStatus: json['humidityStatus'],
      waterTankName: json['waterTankName'] ?? '',
      waterAmountRemaining: json['waterAmountRemaining'],
      maxWaterCapacity: json['maxWaterCapacity'],
      waterTankStatus: json['waterTankStatus'] ?? '',
      irrigationHourFrequency: json['irrigationHourFrequency'],
      irrigationStartDate: json['irrigationStartDate'] ?? '',
      irrigationStartTime: json['irrigationStartTime'] ?? '',
      irrigationDisallowedStartTime: json['irrigationDisallowedStartTime'],
      irrigationDisallowedEndTime: json['irrigationDisallowedEndTime'],
      irrigationDurationInMinutes: json['irrigationDurationInMinutes'],
      irrigationStatus: json['irrigationStatus'],
      irrigationMaxWaterUsage: json['irrigationMaxWaterUsage'],
    );
  }

  CropDetailed toCropDetailed() {
    return CropDetailed(
      cropId: cropId,
      cropName: cropName,
      userId: userId,
      temperatureMinThreshold: temperatureMinThreshold,
      temperatureMaxThreshold: temperatureMaxThreshold,
      temperature: temperature,
      temperatureStatus: temperatureStatus,
      humidityMinThreshold: humidityMinThreshold,
      humidityMaxThreshold: humidityMaxThreshold,
      humidity: humidity,
      humidityStatus: humidityStatus,
      waterTankName: waterTankName,
      waterAmountRemaining: waterAmountRemaining,
      maxWaterCapacity: maxWaterCapacity,
      waterTankStatus: waterTankStatus,
      irrigationHourFrequency: irrigationHourFrequency,
      irrigationStartDate: irrigationStartDate,
      irrigationStartTime: irrigationStartTime,
      irrigationDisallowedStartTime: irrigationDisallowedStartTime,
      irrigationDisallowedEndTime: irrigationDisallowedEndTime,
      irrigationDurationInMinutes: irrigationDurationInMinutes,
      irrigationStatus: irrigationStatus,
      irrigationMaxWaterUsage: irrigationMaxWaterUsage,
    );
  }

}