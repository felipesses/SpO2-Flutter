// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'o2_result_ios_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$O2ResultIosController on _O2ResultIosControllerBase, Store {
  final _$isLoadingAtom = Atom(name: '_O2ResultIosControllerBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$successAtom = Atom(name: '_O2ResultIosControllerBase.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$sendDataAsyncAction =
      AsyncAction('_O2ResultIosControllerBase.sendData');

  @override
  Future sendData(
      int o2, int mensured, String obs, double r1, Function onPressed) {
    return _$sendDataAsyncAction
        .run(() => super.sendData(o2, mensured, obs, r1, onPressed));
  }

  final _$_O2ResultIosControllerBaseActionController =
      ActionController(name: '_O2ResultIosControllerBase');

  @override
  void changeLoading({bool loading}) {
    final _$actionInfo = _$_O2ResultIosControllerBaseActionController
        .startAction(name: '_O2ResultIosControllerBase.changeLoading');
    try {
      return super.changeLoading(loading: loading);
    } finally {
      _$_O2ResultIosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
success: ${success}
    ''';
  }
}
