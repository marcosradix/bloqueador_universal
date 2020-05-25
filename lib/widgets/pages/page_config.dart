import 'dart:convert';

import 'package:bloqueador_universal/utils/share_preferences_util.dart';
import 'package:flutter/material.dart';

class PageConfig extends StatefulWidget {
  @override
  _PageConfigState createState() => _PageConfigState();
}

class _PageConfigState extends State<PageConfig> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> configuration = Map<String, dynamic>();
  final TextEditingController _nomeBotao = TextEditingController();
  final TextEditingController _comando = TextEditingController();
  final TextEditingController _telefone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Container(
            width: double.infinity,
            child: TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.add_to_queue),
                hintText: 'Telefone do rastreador',
                labelText: 'Número do telefone',
              ),
              controller: _telefone,
            ),
          ),
          Container(
            width: double.infinity,
            child: TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.add_to_queue),
                hintText: 'Ex: Bloquear',
                labelText: 'Nome do botão',
              ),
              controller: _nomeBotao,
            ),
          ),
          Container(
            width: double.infinity,
            child: TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.add_to_queue),
                hintText: 'begin123456',
                labelText: 'Comando',
              ),
              controller: _comando,
            ),
          ),
 
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                     configuration[_nomeBotao.text] = _comando.text;
                    _nomeBotao.clear();
                    _comando.clear();
                },
                textColor: Colors.white,
                color: Colors.amber,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Adicionar",
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  configuration["telefone"] = _telefone.text;
                  SharedPreferencesUtil.remove();
                  SharedPreferencesUtil.create(jsonEncode(configuration))
                      .then((value) {
                    setState(() {
                      _nomeBotao.clear();
                      _comando.clear();
                      _telefone.clear();
                    });
                  });
                },
                textColor: Colors.white,
                color: Colors.blue,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Salvar",
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  SharedPreferencesUtil.remove();
                   //SharedPreferencesUtil.load().then((value) => print(value));
                },
                textColor: Colors.white,
                color: Colors.red,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Limpar configuração",
                ),
              ),
            ),
          ),
        ]));
  }
}
