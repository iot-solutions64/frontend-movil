import 'package:hydrosmart/features/soil/domain/crop.dart';

class CropResponseDto {
  final int cropId;
  final int userId;
  final int temperatureId;
  final int humidityId;
  final int waterTankId;
  final String cropName;


  CropResponseDto({
    required this.cropId,
    required this.userId,
    required this.temperatureId,
    required this.humidityId,
    required this.waterTankId,
    required this.cropName,
  });

  factory CropResponseDto.fromJson(Map<String, dynamic> json) {
    return CropResponseDto(
      cropId: json['cropId'],
      userId: json['userId'],
      temperatureId: json['temperatureId'],
      humidityId: json['humidityId'],
      waterTankId: json['waterTankId'],
      cropName: json['cropName'],
    );
  }

  Crop toCrop() {
    return Crop(
      id: cropId,
      name: cropName,
      waterTankId: waterTankId,
    );
  }

}