import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:test_mobile_car/app/database/sqlite_connection.dart';
import 'package:test_mobile_car/app/modules/home/models/car_model.dart';
import 'package:test_mobile_car/app/modules/home/repository/home_repository.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  HomeControllerBase({required SqliteConnection database})
      : _database = database {
    fetchCars();
  }
  final _repository = Modular.get<HomeRepository>();
  final SqliteConnection _database;

  @observable
  ObservableList<CarModel> listCars = ObservableList();
  @observable
  int? idSelectedCar;
  @observable
  String nameSelectedCar = "";

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> listLeads = [];

  Future<void> fetchCars() async {
    try {
      final result = await _repository.fetchListCars();
      if (result.isNotEmpty) {
        listCars = ObservableList.of(result);
      }
    } catch (e) {
      BotToast.showText(
        contentColor: Colors.red,
        borderRadius: BorderRadius.circular(8),
        text: "Erro ao buscar lista de carros",
        duration: const Duration(seconds: 4),
      );
    }
  }

  @action
  void selectedCar(int id, String name) {
    if (id == idSelectedCar) {
      idSelectedCar = null;
      nameSelectedCar = "";
    } else {
      idSelectedCar = id;
      nameSelectedCar = name;
    }
  }

  @action
  Future<void> addLeads() async {
    try {
      CarModel car =
          listCars.firstWhere((element) => element.id == idSelectedCar);

      await _database.db.insert('cars', {
        'id_car': car.id,
        'modelo_id': car.modeloId,
        'timestamp_cadastro': car.timestampCadastro.toString(),
        'valor': car.valor,
        'combustivel': car.combustivel,
        'num_portas': car.numPortas,
        'nome_modelo': car.nomeModelo,
        'nome_user': name.text,
        'email_user': email.text,
        'phone_user': phone.text,
      });
      cleanInputs();
      idSelectedCar = null;
      nameSelectedCar = "";
      BotToast.showText(
        contentColor: Colors.green,
        borderRadius: BorderRadius.circular(8),
        text: 'Lead adicionado com sucesso!',
        duration: const Duration(seconds: 4),
      );
    } on Exception catch (_) {
      BotToast.showText(
        contentColor: Colors.red,
        borderRadius: BorderRadius.circular(8),
        text: "Ops! tivemos um problema ai salvar seu lead",
        duration: const Duration(seconds: 4),
      );
    }
  }

  @action
  Future<void> sendLeads() async {
    try {
      await _repository.sendLeads(listLeads);
      await _database.db.execute('DELETE FROM cars');
      BotToast.showText(
        contentColor: Colors.green,
        borderRadius: BorderRadius.circular(8),
        text: 'Leads enviados com sucesso!',
        duration: const Duration(seconds: 4),
      );
    } catch (e) {
      BotToast.showText(
        contentColor: Colors.red,
        borderRadius: BorderRadius.circular(8),
        text: "Ops! tivemos um problema ai enviar seus leads",
        duration: const Duration(seconds: 4),
      );
    }
  }

  @action
  Future<void> fetchCarsDatabase() async {
    listLeads = await _database.db.query('cars');
  }

  @action
  void cleanInputs() {
    email.clear();
    phone.clear();
    name.clear();
    Modular.to.pop();
  }
}
