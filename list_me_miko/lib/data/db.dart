part of 'data.dart';

class ListDB {
  Map<int, String> migrateScript = {
    1:'CREATE TABLE list('
        'id INTEGER PRIMARY KEY,'
        'activity TEXT,'
        'date TEXT,'
        'time TEXT'
      ')'
  };

  ListDB._();

  Database? _database;

  static final ListDB provider = ListDB._();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: migrateScript.length, onOpen: (db) {},
        onCreate: createTable, onUpgrade: onUpgrade);
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) async {
    for (int i = oldVersion + 1; i <= newVersion; i++) {
      await database.execute(migrateScript[i]!);
    }
  }

  void createTable(Database database, int version) async {
    for (int i = 1; i <= migrateScript.length; i++) {
      await database.execute(migrateScript[i]!);
    }
  }
}
