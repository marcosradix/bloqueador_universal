import 'dart:convert';
import 'dart:math';
import 'package:bloqueador_universal/utils/share_preferences_util.dart';
import 'package:flutter/material.dart';
import '../button_widget.dart';


class PageControl extends StatefulWidget {
  @override
  _PageControlState createState() => _PageControlState();
}

class _PageControlState extends State<PageControl> {
  Map<String, dynamic> configuration;

  @override
  void initState() {
    super.initState();
    SharedPreferencesUtil.load()
        .then((value) {
          setState(() {
            if(value.isNotEmpty){
              configuration = jsonDecode(value);

            }
          });
          });
  }

  Widget getTextWidgets(List<String> strings){
    Random random =  Random();
    List<Color> colors = [Colors.purple, Colors.green, Colors.red, Colors.green, Colors.blueGrey, Colors.black54, Colors.blue, Colors.amber];
    List<Widget> list =  List<Widget>();
    for(var i = 0; i < strings.length; i++){
        list.add( CommandButton(strings[i], colors[random.nextInt(colors.length)],  configuration[strings[i]]));
    }
    return Column(children: list, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.stretch,);
  }
  @override
  Widget build(BuildContext context) {
    return  configuration == null ? Container(child: Center(child:Text("Sem configuração")),) 
    :  Column(
      children: <Widget>[
        Text("Telefone: ${configuration['telefone']}"),
        SizedBox(height: 3,),
        getTextWidgets(configuration.keys.toList())
      ],
      );
  }

  
}
