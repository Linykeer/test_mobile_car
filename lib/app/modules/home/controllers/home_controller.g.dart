// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on HomeControllerBase, Store {
  late final _$listCarsAtom =
      Atom(name: 'HomeControllerBase.listCars', context: context);

  @override
  ObservableList<CarModel> get listCars {
    _$listCarsAtom.reportRead();
    return super.listCars;
  }

  @override
  set listCars(ObservableList<CarModel> value) {
    _$listCarsAtom.reportWrite(value, super.listCars, () {
      super.listCars = value;
    });
  }

  late final _$idSelectedCarAtom =
      Atom(name: 'HomeControllerBase.idSelectedCar', context: context);

  @override
  int? get idSelectedCar {
    _$idSelectedCarAtom.reportRead();
    return super.idSelectedCar;
  }

  @override
  set idSelectedCar(int? value) {
    _$idSelectedCarAtom.reportWrite(value, super.idSelectedCar, () {
      super.idSelectedCar = value;
    });
  }

  late final _$nameSelectedCarAtom =
      Atom(name: 'HomeControllerBase.nameSelectedCar', context: context);

  @override
  String get nameSelectedCar {
    _$nameSelectedCarAtom.reportRead();
    return super.nameSelectedCar;
  }

  @override
  set nameSelectedCar(String value) {
    _$nameSelectedCarAtom.reportWrite(value, super.nameSelectedCar, () {
      super.nameSelectedCar = value;
    });
  }

  late final _$addLeadsAsyncAction =
      AsyncAction('HomeControllerBase.addLeads', context: context);

  @override
  Future<void> addLeads() {
    return _$addLeadsAsyncAction.run(() => super.addLeads());
  }

  late final _$sendLeadsAsyncAction =
      AsyncAction('HomeControllerBase.sendLeads', context: context);

  @override
  Future<void> sendLeads() {
    return _$sendLeadsAsyncAction.run(() => super.sendLeads());
  }

  late final _$fetchCarsDatabaseAsyncAction =
      AsyncAction('HomeControllerBase.fetchCarsDatabase', context: context);

  @override
  Future<void> fetchCarsDatabase() {
    return _$fetchCarsDatabaseAsyncAction.run(() => super.fetchCarsDatabase());
  }

  late final _$HomeControllerBaseActionController =
      ActionController(name: 'HomeControllerBase', context: context);

  @override
  void selectedCar(int id, String name) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.selectedCar');
    try {
      return super.selectedCar(id, name);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void cleanInputs() {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.cleanInputs');
    try {
      return super.cleanInputs();
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listCars: ${listCars},
idSelectedCar: ${idSelectedCar},
nameSelectedCar: ${nameSelectedCar}
    ''';
  }
}
