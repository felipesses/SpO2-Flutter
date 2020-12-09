import 'package:SpO2/app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () {
                Modular.to.pushReplacementNamed('/process');
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
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Image.asset(
                'assets/images/estimador.png',
                width: 100,
                height: 100,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Text(
                  "Projeto do GIA, GSORT e PIS/Instituto Federal da Bahia (IFBA) - baseado no HealthWatcher e no método de Kanva et al. (2014) - Referência: https://ieeexplore.ieee.org/abstract/document/6959086. \n\n Este é um protótipo de APP em construção/validação. Não deve ser utilizado para monitoramento e apoio ao diagnóstico, use um oxímetro com selo ANVISA.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Image.asset('assets/images/sintomas.jpg'),
          ),
        ],
      ),
    );
  }
}
