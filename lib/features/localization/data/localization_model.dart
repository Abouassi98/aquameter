class LocalizationModel {
  int id;
  String label, image;
  bool selected = false;

  LocalizationModel(
      {required this.id,
      required this.label,
      this.selected = false,
      required this.image});
}
