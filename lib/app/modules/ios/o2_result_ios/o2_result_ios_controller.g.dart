// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'o2_result_ios_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$O2ResultIosController on _O2ResultIosControllerBase, Store {
  final _$valueAtom = Atom(name: '_O2ResultIosControllerBase.value');

  @override
  int get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(int value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  final _$_O2ResultIosControllerBaseActionController =
      ActionController(name: '_O2ResultIosControllerBase');

  @override
  void increment() {
    final _$actionInfo = _$_O2ResultIosControllerBaseActionController
        .startAction(name: '_O2ResultIosControllerBase.increment');
    try {
      return super.increment();
    } finally {
      _$_O2ResultIosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
