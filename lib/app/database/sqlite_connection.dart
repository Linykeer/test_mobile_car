// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_mobile_car/app/database/sqlite_migration.dart';

class SqliteConnection {
  static const _version = 1;
  static const _databaseName = 'app_car.db';

  late Database db;

  Future<SqliteConnection> init() async {
    db = await _openConnection();
    return this;
  }

  Future<Database> _openConnection() async {
    var databasePath = await getDatabasesPath();
    var databaseFinal = join(databasePath, _databaseName);

    return db = await openDatabase(
      databaseFinal,
      version: _version,
      onConfigure: _onConfigure,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onDowngrade: _onDowngrade,
    );
  }
}

Future<void> _onConfigure(Database db) async {
  await db.execute('PRAGMA foreign_keys = ON');
}

Future<void> _onCreate(Database db, int version) async {
  var batch = db.batch();
  final migrations = SqliteMigration().getCreateMigration();
  for (var migration in migrations) {
    migration.create(batch);
  }
  batch.commit();
}

Future<void> _onUpgrade(Database db, int oldVersion, int version) async {
  var batch = db.batch();
  final migrations = SqliteMigration().getUpdateMigration(oldVersion);
  for (var migration in migrations) {
    migration.update(batch);
  }
  batch.commit();
}

Future<void> _onDowngrade(Database db, int oldVersion, int version) async {}
