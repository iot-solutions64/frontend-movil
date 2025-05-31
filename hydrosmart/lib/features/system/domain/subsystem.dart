class Subsystem {
  final int id;
  final String name;
  final double? value;
  final String status;
  final bool active;

  Subsystem({
    this.id = 0,
    this.name = '',
    this.value,
    this.status = '',
    this.active = false,
  });
}