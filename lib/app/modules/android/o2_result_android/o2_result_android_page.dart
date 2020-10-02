import 'package:SpO2/app/controllers/result_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../../../app_module.dart';
import '../styles.dart';

class O2ResultAndroidPage extends StatefulWidget {
  final int o2;
  final int bpm;
  final double r1;

  const O2ResultAndroidPage(
      {Key key, @required this.o2, @required this.r1, @required this.bpm})
      : super(key: key);

  @override
  _O2ResultIosPageState createState() => _O2ResultIosPageState();
}

class _O2ResultIosPageState
    extends ModularState<O2ResultAndroidPage, ResultController> {
  //use 'controller' variable to access controller

  TextEditingController mensuredController = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  Key key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    var o2 = widget.o2;
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 5,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Modular.to.pushNamed('/o2ProcessIos');
                  },
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, color: primaryColor),
                      SizedBox(height: 50),
                      Text(
                        "     Retornar",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Text(
                  widget.o2 < 70 ? '< 70%' : '$o2%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: widget.o2 < 70
                        ? Colors.red
                        : Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: Text(
                  'Referência: 95 a 100%',
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  '* Este é um protótipo de APP em construção/validação. Não deve ser utilizado para monitoramento e apoio ao diagnóstico, use um oxímetro com selo ANVISA',
                  // textAlign: TextAlign,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Valor da oximetria\ndo monitor multiparamétrico: ',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20, left: 10),
                    child: Container(
                      height: 30,
                      child: Material(
                        elevation: 3.0,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: mensuredController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2),
                          ],
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 0),
                            hintText: '0',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.horizontal(),
                              borderSide: const BorderSide(color: primaryColor),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.horizontal(),
                              borderSide: const BorderSide(color: primaryColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.horizontal(),
                              borderSide: const BorderSide(color: primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Observações adicionais:',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 30,
                  child: TextFormField(
                    controller: controller.obs,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(),
                        borderSide: const BorderSide(color: primaryColor),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(),
                        borderSide: const BorderSide(color: primaryColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(),
                        borderSide: const BorderSide(color: primaryColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Observer(builder: (_) {
          return controller.isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: primaryColor,
                  ),
                )
              : RaisedButton(
                  color: primaryColor,
                  child: Text(
                    'ENVIAR DADOS',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.5,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                  onPressed: () async {
                    try {
                      controller.changeLoading(loading: true);

                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();

                        await controller.sendData(
                          widget.o2,
                          int.parse(mensuredController.text),
                          controller.obs.text,
                          widget.r1,
                          () {
                            Modular.to
                                .pushReplacementNamed('/o2ProcessAndroid');
                          },
                        );
                      }
                    } finally {
                      controller.changeLoading(loading: false);
                    }
                  },
                );
        }),
      ),
    );
  }
}
