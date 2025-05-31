class Tank {
  int id;
  final String name;
  final double remainingLiters;
  final double totalLiters;

  Tank({
    required this.id,
    required this.name,
    required this.remainingLiters,
    required this.totalLiters,
  });


  bool get isFull => remainingLiters == totalLiters;

  factory Tank.empty() {
    return Tank(id: 0, name: '', remainingLiters: 0.0, totalLiters: 0.0);
  }

}