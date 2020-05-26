import 'dart:convert';
import 'dart:io';


import 'package:bloqueador_universal/utils/share_preferences_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CommandButton extends StatefulWidget {
  final String buttonName;
  final String acommand;
  final Color buttonColor;

  CommandButton(this.buttonName, this.buttonColor, this.acommand);

  @override
  _CommandButtonState createState() => _CommandButtonState();
}

class _CommandButtonState extends State<CommandButton> {
  Map<String, dynamic> configuration;
  _sendSms(String phoneNumber, String message) async {
     String url;
      if(Platform.isAndroid){
        url ='sms:$phoneNumber?body=$message';
    } 
      else if(Platform.isIOS){
        url ='sms:$phoneNumber&body=$message';
    }
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Erro na url $url';
    }
  }

  @override
  void initState() {
    super.initState();
    SharedPreferencesUtil.load().then((value) {
      setState(() {
        if (value.isNotEmpty) {
          configuration = jsonDecode(value);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.buttonName != "telefone"
        ? RaisedButton(
            padding: const EdgeInsets.all(8.0),
            textColor: Colors.white,
            color: widget.buttonColor,
            onPressed: () async{
             await _sendSms(configuration['telefone'], widget.acommand);
              Get.snackbar(
                "Enviado",
                "Seu comando \"${widget.acommand}\" foi enviado",
                icon: Icon(Icons.sms),
                shouldIconPulse: true,
                snackPosition: SnackPosition.TOP,
                animationDuration: Duration(milliseconds: 500),
                barBlur: 20,
                isDismissible: true,
                duration: Duration(seconds: 3),
              );
              //print(widget.acommand);
            },
            child: new Text(widget.buttonName),
          )
        : Container();
  }
}
