class Record {
  final int id;
  final String date;
  final int humidity;
  final String humidityStatus;
  final int temperature;
  final String temperatureStatus;

  Record({
    required this.id,
    required this.date,
    required this.humidity,
    required this.humidityStatus,
    required this.temperature,
    required this.temperatureStatus,
  });
}