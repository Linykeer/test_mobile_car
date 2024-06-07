import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_mobile_car/app/app_module.dart';
import 'package:test_mobile_car/app/app_widget.dart';

void main() {
  Modular.setObservers([
    BotToastNavigatorObserver(),
    routeObserver,
  ]);

  runApp(
    ModularApp(module: AppModule(), child: const AppWidget()),
  );
}

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
