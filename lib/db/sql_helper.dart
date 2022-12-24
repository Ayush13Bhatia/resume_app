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

  static Future<List<Resume>> personQuery() async {
    Database db = await initializeSqlDB();
    final pr = await db.query(Query.resumeTable);
    // return pr
    return pr.map((e) => Resume.fromJson(e)).toList();
  }
}
