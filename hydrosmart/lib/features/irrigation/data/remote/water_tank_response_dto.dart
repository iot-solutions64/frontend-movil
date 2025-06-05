import 'package:hydrosmart/features/irrigation/domain/water_tank.dart';

class WaterTankResponseDto {
  final int id;
  final String name;
  final double waterAmountRemaining;
  final double maxWaterCapacity;
  final String status;

  WaterTankResponseDto({
    required this.id,
    required this.name,
    required this.waterAmountRemaining,
    required this.maxWaterCapacity,
    required this.status,
  });

  factory WaterTankResponseDto.fromJson(Map<String, dynamic> json) {
    return WaterTankResponseDto(
      id: json['id'],
      name: json['name'],
      waterAmountRemaining: json['waterAmountRemaining'].toDouble(),
      maxWaterCapacity: json['maxWaterCapacity'].toDouble(),
      status: json['status'],
    );
  }

  WaterTank toWaterTank() {
    return WaterTank(
      id: id,
      name: name,
      remainingLiters: waterAmountRemaining,
      totalLiters: maxWaterCapacity,
      status: status,
    );
  }

}