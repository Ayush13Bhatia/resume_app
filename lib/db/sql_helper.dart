import '../db/db_query.dart';
import '../model/resume_model.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class SQLHelper {
  static Future<void> createTable(Database db) async {
    await db.execute(Query.createResumeTable);
  }

  static Future<Database> initializeSqlDB() async {
    var path = await getDatabasesPath();
    Database db = await openDatabase(
      "$path/person.db",
      version: Query.dbVersion,
      password: "123",
      onCreate: (db, value) async {
        await createTable(db);
      },
    );
    return db;
  }

  static Future<int> insertPerson(Resume resume) async {
    Database db = await initializeSqlDB();
    final id = db.insert(Query.resumeTable, resume.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Resume>> personQuery({String? query}) async {
    Database db = await initializeSqlDB();
    var pr = [];
    if (query != null && query.isNotEmpty) {
      pr = await db.rawQuery("SELECT * FROM ${Query.resumeTable} WHERE name LIKE '%${query.toLowerCase()}%'");
    } else {
      pr = await db.query(Query.resumeTable);
    }
    return pr.map((e) => Resume.fromJson(e)).toList();
  }

  static Future<int> countResumeTable() async {
    Database db = await initializeSqlDB();
    var cnt = await db.rawQuery('SELECT COUNT(*) as count FROM ${Query.resumeTable}');
    return int.tryParse(cnt.first['count'].toString()) ?? 0;
  }

  static Future<List<Resume>> findPerson() async {
    Database db = await initializeSqlDB();
    final pr = await db.query(Query.resumeTable);
    return pr.map((e) => Resume.fromJson(e)).toList();
  }

  static Future<void> deleteDB() async {
    Database db = await initializeSqlDB();
    await db.delete(Query.resumeTable);
  }

  static Future<void> deleteItem(int id) async {
    Database db = await initializeSqlDB();
    await db.delete(Query.resumeTable, where: "id=$id");
  }
}
