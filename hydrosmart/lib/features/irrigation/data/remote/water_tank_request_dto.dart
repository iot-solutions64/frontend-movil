class WaterTankRequestDto {
  final String name;
  final double maxWaterCapacity;
  final int userId;

  WaterTankRequestDto({
    required this.name,
    required this.maxWaterCapacity,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'maxWaterCapacity': maxWaterCapacity,
      'userId': userId,
    };
  }

}