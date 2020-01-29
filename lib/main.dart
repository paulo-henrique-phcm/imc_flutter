import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void resetField() {
    //reseta os campos sempre que é chamado no reset da barra
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  String _infoText = "Informe seus dados";

  void calcula() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);
      double imc = weight / (height * height);
      print(imc);
      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else {
        _infoText = "Acima do peso (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //barra
      appBar: AppBar(
        //adiciona a barra superior
        title: Text("Calculador de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          //adiciona um filho de ação com o reset
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: resetField,
          )
        ],
      ),
      backgroundColor: Colors.white,

      //corpo
      body: SingleChildScrollView(
        //ativa uma rolagem da tela para não ficar nada atraz do teclado por exmplo
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          //crio um filho com esse form pois, ele tem a propriedade de tratar o erro de nao inserir dado
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //icone de pessoa
              Icon(Icons.person_pin_circle, size: 120.0, color: Colors.green),

              //texto peso
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(
                      color: Colors.green,
                    )),
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                textAlign: TextAlign.center,
                controller: weightController,
                //validator faz parte do form, ele chama essa funçao anonima e valida
                validator: (value) {
                  if (value.isEmpty) {
                    return "insira seu Peso";
                  }
                },
              ),

              //texto altura
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (metros)",
                    labelStyle: TextStyle(
                      color: Colors.green,
                    )),
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                textAlign: TextAlign.center,
                controller: heightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "insira sua Altura";
                  }
                },
              ),

              //botão
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(
                  //containar é pra poder definir altura pra caixa
                  height: 60.0,
                  child: RaisedButton(
                    //botão preenchido, o raised (botao) é filho do container
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        calcula();
                      }
                    },
                    child: Text(
                      //e o botao raised tem um filho chamado calcular
                      "calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Colors.green,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
