import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_mobile_car/app/database/sqlite_connection.dart';
import 'package:test_mobile_car/app/modules/home/home_module.dart';
import 'package:test_mobile_car/app/modules/splash/splash_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton(
          (i) => SqliteConnection()..init(),
        ),
      ];
  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: SplashModule()),
        ModuleRoute('/home', module: HomeModule()),
      ];
}
