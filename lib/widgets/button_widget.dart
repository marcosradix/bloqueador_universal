
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class CommandButton extends StatelessWidget {
  final String buttonName;
  final String acommand;
  final Color buttonColor;

CommandButton(this.buttonName, this.buttonColor, this.acommand);
  @override
  Widget build(BuildContext context) {
   return buttonName != "telefone" ? RaisedButton(
          padding: const EdgeInsets.all(8.0),
          textColor: Colors.white,
          color: buttonColor,
          onPressed: () {
              Get.snackbar(
               "Enviado", 
               "Seu comando \"$acommand\" foi enviado",
              icon: Icon(Icons.sms), 
              shouldIconPulse: true,
              snackPosition: SnackPosition.TOP,
              animationDuration: Duration(milliseconds: 500),
              barBlur: 20,
              isDismissible: true,
              duration: Duration(seconds: 3),
            );
            print(acommand);
          },
          child: new Text(buttonName),
        ): Container();
  }

}