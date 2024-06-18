class Event {
  final String title;
  final DateTime date;

  Event({
    required this.title,
    required this.date,
  });

  // Override equality and hashcode
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Event && other.title == title && other.date == date;
  }

  @override
  int get hashCode => title.hashCode ^ date.hashCode;
}
