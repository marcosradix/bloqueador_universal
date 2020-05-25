import 'package:bloqueador_universal/states_manager/screen_change.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  BuildContext context;
  final Animation<double> menuScaleAnimation;
  final Animation<Offset> slideAnimation;
  Menu(this.context, this.menuScaleAnimation, this.slideAnimation);
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    widget.context = context;
    return SlideTransition(
      position: widget.slideAnimation,
      child: ScaleTransition(
        scale: widget.menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.settings),
                        SizedBox(
                          width: 15,
                        ),
                        Text("Configuração",
                            style:
                                TextStyle(color: Colors.white, fontSize: 22)),
                      ],
                    ),
                  ),
                  onTap: () {
                    ScreenChange.to.changeScreen("Configuração");
                    print("Configuração");
                  },
                ),
                SizedBox(height: 10),
                Divider(),
                InkWell(
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.code),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Comandos",
                            style:
                                TextStyle(color: Colors.white, fontSize: 22)),
                      ],
                    ),
                  ),
                  onTap: () {
                    ScreenChange.to.changeScreen("Comandos");
                    print("Comandos");
                  },
                ),
                SizedBox(height: 10),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
