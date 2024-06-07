import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_mobile_car/app/modules/home/controllers/home_controller.dart';
import 'package:test_mobile_car/app/modules/home/pages/home_page.dart';
import 'package:test_mobile_car/app/modules/home/repository/home_repository.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton(
          (i) => HomeController(database: i()),
        ),
        Bind(
          (i) => HomeRepository(),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const HomePage(),
        )
      ];
}
