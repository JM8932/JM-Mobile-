// Model reprezentujący pojedynczy element w bazie danych SQLite.
class Item {
  const new({
    required this.title,
    required this.description,
    this.id,
  });

  // Tworzy obiekt Item na podstawie danych z bazy (Słownik Map)
  factory fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  final int? id;
  final String title;
  final String description;

  // Konwertuje obiekt Item na format zrozumiały dla bazy SQLite (Słownik Map)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
