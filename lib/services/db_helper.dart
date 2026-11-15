import 'package:dsw60352test/models/item_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Klasa odpowiadająca za połączenie z bazą danych i operacje CRUD.
class DatabaseHelper {
  // Prywatny konstruktor zapobiega tworzeniu wielu instancji (Wzorzec Singleton)
  new _privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  // Pobiera aktualną bazę lub inicjalizuje nową, jeśli jej nie ma
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Funkcja tworząca plik bazy danych i podstawową tabelę
  Future<Database> _initDatabase() async {
    // Określa domyślny systemowy folder na dane aplikacji
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    // Otwiera bazę i tworzy tabelę 'items' w wersji 1
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Definicja tabeli SQL
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL
      )
    ''');
  }

  // ======================
  // OPERACJE CRUD
  // ======================

  // C - Create (Zapis elementu do bazy)
  Future<int> insertItem(Item item) async {
    final db = await instance.database;
    return db.insert('items', item.toMap());
  }

  // R - Read (Odczyt wszystkich elementów)
  Future<List<Item>> getItems() async {
    final db = await instance.database;
    // Zapytanie SQL zwracające posortowane elementy
    final items = await db.query('items', orderBy: 'id DESC');
    return items.map(Item.fromMap).toList();
  }

  // U - Update (Aktualizacja modyfikowanego elementu)
  Future<int> updateItem(Item item) async {
    final db = await instance.database;
    return db.update(
      'items',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  // D - Delete (Usunięcie elementu o konkretnym ID)
  Future<int> deleteItem(int id) async {
    final db = await instance.database;
    return db.delete(
      'items',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
