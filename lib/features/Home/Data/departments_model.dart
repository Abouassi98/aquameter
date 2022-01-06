class PlanOfWeek {
  PlanOfWeek({
    required this.id,
    required this.name,
    required this.selected,
    required this.day,
    required this.month,
    required this.dayCompare,
  });
  int? id;
  String? name;
  String? month;
  bool selected;
  String? day;
  String? dayCompare;
}
