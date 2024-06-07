class CarModel {
  final int? id;
  final int? timestampCadastro;
  final int? modeloId;
  final int? ano;
  final String combustivel;
  final int? numPortas;
  final String cor;
  final String nomeModelo;
  final double? valor;
  CarModel({
    required this.id,
    required this.timestampCadastro,
    required this.modeloId,
    required this.ano,
    required this.combustivel,
    required this.numPortas,
    required this.cor,
    required this.nomeModelo,
    required this.valor,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'timestampCadastro': timestampCadastro,
      'modeloId': modeloId,
      'ano': ano,
      'combustivel': combustivel,
      'numPortas': numPortas,
      'cor': cor,
      'nomeModelo': nomeModelo,
      'valor': valor,
    };
  }

  factory CarModel.fromMap(Map<String, dynamic> map) {
    return CarModel(
      id: map['id'] as int,
      timestampCadastro: map['timestamp_cadastro'] as int,
      modeloId: map['modelo_id'] as int,
      ano: map['ano'] as int,
      combustivel: map['combustivel'] ?? '',
      numPortas: map['num_portas'] as int,
      cor: map['cor'] ?? '',
      nomeModelo: map['nome_modelo'] ?? '',
      valor: map['valor'] as double,
    );
  }
}
