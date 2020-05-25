
import 'package:flutter/material.dart';

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
            print(acommand);
          },
          child: new Text(buttonName),
        ): Container();
  }
}