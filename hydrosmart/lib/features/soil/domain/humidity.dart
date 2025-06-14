class Humidity {
  final double humidity;
  final double minThreshold;
  final double maxThreshold;
  final String status;

  Humidity({
    this.humidity = 0.0,
    this.minThreshold = 0.0,
    this.maxThreshold = 0.0,
    this.status = '',
  });
}