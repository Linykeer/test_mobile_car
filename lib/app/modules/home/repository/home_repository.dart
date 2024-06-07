import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_mobile_car/app/modules/home/models/car_model.dart';

class HomeRepository {
  Future<List<CarModel>> fetchListCars() async {
    try {
      final response =
          await http.get(Uri.parse('https://wswork.com.br/cars.json'));

      List<CarModel> list = [];
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        for (var model in result['cars']) {
          list.add(CarModel.fromMap(model));
        }
      }
      return list;
    } on Exception catch (_) {
      throw Exception('Erro ao buscar lista de carros');
    }
  }

  Future<int> sendLeads(List<Map<String, dynamic>> leads) async {
    try {
      final response = await http.post(
        Uri.parse('https://www.wswork.com.br/cars/leads'),
        body: jsonEncode(leads),
      );

      return response.statusCode;
    } on Exception catch (_) {
      throw Exception('Erro ao enviar leads');
    }
  }
}
