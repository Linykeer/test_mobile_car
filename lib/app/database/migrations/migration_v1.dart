import 'package:sqflite/sqflite.dart';
import 'package:test_mobile_car/app/database/migrations/migration.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
        create table cars(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          id_car INTEGER NOT NULL,
          modelo_id INTEGER NOT NULL,
          timestamp_cadastro STRING NOT NULL,
          valor REAL NOT NULL,
          combustivel TEXT NOT NULL,
          num_portas INTEGER NOT NULL,
          nome_modelo TEXT NOT NULL,
          nome_user TEXT NOT NULL,
          email_user TEXT NOT NULL,
          phone_user TEXT NOT NULL
        )
    ''');
  }

  @override
  void update(Batch batch) {}
}
