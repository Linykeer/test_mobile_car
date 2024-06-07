import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_mobile_car/app/modules/splash/pages/splash_page.dart';

class SplashModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (context, args) => const SplashPage(),
        )
      ];
}
