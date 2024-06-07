import 'package:test_mobile_car/app/database/migrations/migration.dart';
import 'package:test_mobile_car/app/database/migrations/migration_v1.dart';

class SqliteMigration {
  List<Migration> getCreateMigration() => [
        MigrationV1(),
      ];
  List<Migration> getUpdateMigration(int version) => [];
}
