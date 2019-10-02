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
    String _return = "";

    if (_valorDigitado.isEmpty) {
      _return = "Digite algo";
    } else {

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("nome", _valorDigitado); // setString() precisa do await

      _campoTexto.text = "";
      _return = "Dados salvos!";

      // Dismiss keyboard
      FocusScope.of(context).requestFocus(new FocusNode());

    }

    setState(() {
      _texto = _return;
    });
  }

  _ler() async {

    final prefs = await SharedPreferences.getInstance();
    String _return = "";

    if (prefs.containsKey("nome")) {
      _return = prefs.getString("nome"); // getString() não precisa do await
    } else {
      _return = "Nada para ler";
    }

    setState(() {
      _texto = _return;
    });

  }

  _remover() async {

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("nome"); // remove() precisa do await

    setState(() {
      _texto = "Removido";
    });

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