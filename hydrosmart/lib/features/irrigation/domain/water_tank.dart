class WaterTank {
  int id;
  final String name;
  final double remainingLiters;
  final double totalLiters;
  final String status;

  WaterTank({
    required this.id,
    required this.name,
    required this.remainingLiters,
    required this.totalLiters,
    required this.status,
  });


  bool get isFull => remainingLiters == totalLiters;

  factory WaterTank.empty() {
    return WaterTank(id: 0, name: '', remainingLiters: 0.0, totalLiters: 0.0, status: 'DEACTIVATED');
  }

}