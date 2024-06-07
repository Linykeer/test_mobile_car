import 'dart:async';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:test_mobile_car/app/modules/home/controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.get<HomeController>();
  @override
  void initState() {
    const duration = Duration(minutes: 5);
    Timer.periodic(duration, (timer) async {
      await controller.fetchCarsDatabase();
      if (controller.listLeads.isNotEmpty) {
        await controller.sendLeads();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: SingleChildScrollView(child: Observer(
          builder: (_) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: controller.listCars.map((car) {
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
                                  width: controller.idSelectedCar == car.id
                                      ? 3
                                      : 1),
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
                                      const TextSpan(
                                          text: "Data de Cadastro: "),
                                      TextSpan(
                                        text: DateFormat('dd/MM/yyyy HH:mm:ss')
                                            .format(DateTime
                                                .fromMillisecondsSinceEpoch(
                                                    car.timestampCadastro! *
                                                        1000))
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
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Observer(
                  builder: (_) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff191b54)),
                        onPressed: controller.idSelectedCar == null
                            ? null
                            : () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Form(
                                      key: controller.formKey,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              "Para continuar, digite os dados do usúario",
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15),
                                              child: TextFormField(
                                                controller: controller.name,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: "Digite seu nome",
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'O Nome é obrigatório.';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            TextFormField(
                                              controller: controller.email,
                                              decoration: const InputDecoration(
                                                hintText: "Digite seu e-mail",
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'O email é obrigatório.';
                                                }
                                                return null;
                                              },
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15),
                                              child: TextFormField(
                                                controller: controller.phone,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: "Digite seu phone",
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'O Telefone é obrigatório.';
                                                  }
                                                  return null;
                                                },
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                  TelefoneInputFormatter(),
                                                ],
                                              ),
                                            ),
                                            Text(
                                              'Deseja salvar os dados do modelo ${controller.nameSelectedCar}?',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red),
                                        onPressed: () {
                                          controller.cleanInputs();
                                        },
                                        child: const Text('Não, fechar'),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green),
                                        onPressed: () async {
                                          if (controller.formKey.currentState!
                                              .validate()) {
                                            await controller.addLeads();
                                          }
                                        },
                                        child: const Text('Sim, salvar'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                        child: const Text(
                          "Eu quero",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        )));
  }
}
