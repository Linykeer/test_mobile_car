import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:test_mobile_car/app/modules/home/controllers/home_controller.dart';
import 'package:test_mobile_car/app/modules/home/widgets/loading_shimmer.dart';

class ListCars extends StatelessWidget {
  const ListCars({super.key, required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (controller.listCars.isEmpty) {
        return Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 30),
          child: SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (context, index) {
                return const LoadingShimmer();
              },
            ),
          ),
        );
      } else {
        return Container(
          margin: const EdgeInsets.only(top: 15, bottom: 30),
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 8,
              );
            },
            itemCount: controller.listCars.length,
            itemBuilder: (context, index) {
              final car = controller.listCars[index];
              return Observer(
                builder: (_) {
                  return GestureDetector(
                    onTap: () {
                      controller.selectedCar(car.id!, car.nomeModelo);
                    },
                    child: Container(
                      height: 300,
                      width: 300,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: controller.idSelectedCar == car.id
                                ? const Color(0xff191b54)
                                : Colors.grey,
                            width: controller.idSelectedCar == car.id ? 3 : 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(color: Colors.black),
                              children: [
                                const TextSpan(text: "Modelo: "),
                                TextSpan(
                                  text: car.nomeModelo,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(color: Colors.black),
                              children: [
                                const TextSpan(text: "Ano: "),
                                TextSpan(
                                  text: car.ano.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(color: Colors.black),
                              children: [
                                const TextSpan(text: "Cor: "),
                                TextSpan(
                                  text: car.cor,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(color: Colors.black),
                              children: [
                                const TextSpan(text: "Combustivel: "),
                                TextSpan(
                                  text: car.combustivel,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(color: Colors.black),
                              children: [
                                const TextSpan(text: "Qtd de Portas: "),
                                TextSpan(
                                  text: car.numPortas.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(color: Colors.black),
                              children: [
                                const TextSpan(text: "Preço: "),
                                TextSpan(
                                  text: car.valor.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(color: Colors.black),
                              children: [
                                const TextSpan(text: "Data de Cadastro: "),
                                TextSpan(
                                  text: DateFormat('dd/MM/yyyy HH:mm:ss')
                                      .format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              car.timestampCadastro! * 1000))
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      }
    });
  }
}
