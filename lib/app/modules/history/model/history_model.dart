class History {
  History(
      {required this.title,
      required this.dateTime,
      required this.result,
      this.isChecked = false,
      this.id});

  String title;
  final DateTime dateTime;
  final double result;
  final int? id;
  bool isChecked;
}
