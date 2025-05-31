import 'package:hydrosmart/features/system/domain/subsystem.dart';

class System {
  final int id;
  final String name;
  final int cropId;
  final int batteryLevel;
  final List<Subsystem> subsystems;

  System({
    this.id = 0,
    this.name = '',
    this.cropId = 0,
    this.batteryLevel = 0,
    List<Subsystem>? subsystems,
  }) : subsystems = subsystems ?? [];
}