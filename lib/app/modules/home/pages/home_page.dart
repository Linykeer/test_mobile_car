import 'dart:async';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:test_mobile_car/app/modules/home/controllers/home_controller.dart';
import 'package:test_mobile_car/app/modules/home/widgets/list_cars.dart';

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
        title: const Text('Processo seletivo WS Work'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListCars(
              controller: controller,
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
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: TextFormField(
                                            controller: controller.name,
                                            decoration: const InputDecoration(
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
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: TextFormField(
                                            controller: controller.phone,
                                            decoration: const InputDecoration(
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
        ),
      ),
    );
  }
}
