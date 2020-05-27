import 'dart:convert';

import 'package:bloqueador_universal/utils/share_preferences_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.add_to_queue),
                    hintText: 'Telefone do rastreador',
                    labelText: 'Número do telefone',
                  ),
                  controller: _telefone,
                  keyboardType: TextInputType.number,
                ),
              ),
              Row(
                children: <Widget>[
                  Text("Atualizar"),
                  SizedBox(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          print(isSwitched);
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ),
                ],
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
                      if (isSwitched) {
                        if (_nomeBotao.text.isNotEmpty &&
                            _comando.text.isNotEmpty) {
                          configuration[_nomeBotao.text] = _comando.text;
                        }
                      } else {
                        configuration[_nomeBotao.text] = _comando.text;
                      }
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
                      if (isSwitched) {
                        if (_telefone.text.isNotEmpty) {
                          configuration["telefone"] = _telefone.text.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
                        }

                        SharedPreferencesUtil.load().then((data) {
                          Map<String, dynamic> newMap = {
                            ...jsonDecode(data),
                            ...configuration,
                          };

                          SharedPreferencesUtil.create(jsonEncode(newMap))
                              .then((value) {
                            setState(() {
                              _nomeBotao.clear();
                              _comando.clear();
                              _telefone.clear();
                            });
                          });
                        });
                      } else {
                        configuration["telefone"] = _telefone.text.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
                      }
                      SharedPreferencesUtil.remove();
                      SharedPreferencesUtil.create(jsonEncode(configuration))
                          .then((value) {
                        setState(() {
                          _nomeBotao.clear();
                          _comando.clear();
                          _telefone.clear();
                          Get.snackbar(
                            "Salvo",
                            "Dados salvos com sucesso",
                            icon: Icon(Icons.save),
                            shouldIconPulse: true,
                            snackPosition: SnackPosition.TOP,
                            animationDuration: Duration(milliseconds: 500),
                            barBlur: 20,
                            isDismissible: true,
                            duration: Duration(seconds: 3),
                          );
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
                        Get.defaultDialog(
                        textConfirm: "Sim",
                        textCancel: "Não",
                        title: "Alerta",
                        confirmTextColor: Colors.white,
                        cancelTextColor: Colors.red,
                        onConfirm: () {
                          Navigator.of(context).pop();
                          SharedPreferencesUtil.remove();
                        },
                        middleText: "Isso vai apagar toda a sua configuração, tem certeza?");
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
