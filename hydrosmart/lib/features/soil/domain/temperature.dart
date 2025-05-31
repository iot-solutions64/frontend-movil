class Temperature {
  final int id;
  final double temperature;
  final double minThreshold;
  final double maxThreshold;
  final String status;

  Temperature({
    this.id = 0,
    this.temperature = 0.0,
    this.minThreshold = 0.0,
    this.maxThreshold = 0.0,
    this.status = '',
  });
}