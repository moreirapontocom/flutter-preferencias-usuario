import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _texto = "";
  TextEditingController _campoTexto = TextEditingController();

  _salvar() async {

    String _valorDigitado = _campoTexto.text;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("nome", _valorDigitado);

    _campoTexto.text = "";

    setState(() {
      _texto = "Dados salvos!";
    });

    // Dismiss keyboard
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  _ler() {

  }

  _remover() {

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Manipulação de dados'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[

            Text(_texto,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25
              ),
            ),

            TextField(
              keyboardType: TextInputType.text,
              controller: _campoTexto,
              decoration: InputDecoration(
                labelText: "Digite algo"
              ),
            ),

            Row(
              children: <Widget>[

                RaisedButton(
                  color: Colors.blue,
                  child: Text("Salvar", style: TextStyle(color: Colors.white),),
                  onPressed: _salvar,
                ),
                RaisedButton(
                  color: Colors.blue,
                  child: Text("Ler", style: TextStyle(color: Colors.white),),
                  onPressed: _ler,
                ),
                RaisedButton(
                  color: Colors.blue,
                  child: Text("Remover", style: TextStyle(color: Colors.white),),
                  onPressed: _remover,
                )

              ],
            )

          ],
        ),
      ),
    );

  }
}