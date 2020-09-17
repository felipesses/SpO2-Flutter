// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ResultController on _ResultControllerBase, Store {
  final _$isLoadingAtom = Atom(name: '_ResultControllerBase.isLoading');

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

  final _$successAtom = Atom(name: '_ResultControllerBase.success');

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

  final _$sendDataAsyncAction = AsyncAction('_ResultControllerBase.sendData');

  @override
  Future sendData(int o2, String obs, double r1) {
    return _$sendDataAsyncAction.run(() => super.sendData(o2, obs, r1));
  }

  final _$_ResultControllerBaseActionController =
      ActionController(name: '_ResultControllerBase');

  @override
  void changeLoading({bool loading}) {
    final _$actionInfo = _$_ResultControllerBaseActionController.startAction(
        name: '_ResultControllerBase.changeLoading');
    try {
      return super.changeLoading(loading: loading);
    } finally {
      _$_ResultControllerBaseActionController.endAction(_$actionInfo);
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
