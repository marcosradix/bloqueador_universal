import 'package:bloqueador_universal/states_manager/screen_change.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final Color backgroundColor = Color(0xFF4A4A58);

class DashBoard extends StatefulWidget {
  BuildContext context;
  double screenWidth, screenHeight;
  Duration duration;
  Animation<double> scaleAnimation;
  Animation<double> menuScaleAnimation;
  Animation<Offset> slideAnimation;
  DashBoard(
    this.context,
    this.screenWidth,
    this.screenHeight,
    this.duration,
    this.scaleAnimation,
    this.menuScaleAnimation,
    this.slideAnimation,
  );
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    context = widget.context;
    return GetBuilder<ScreenChange>(
        init: ScreenChange(),
        initState: (_) => ScreenChange.to.widgetw,
        builder: (_) {
          return AnimatedPositioned(
            duration: widget.duration,
            top: 0,
            bottom: 0,
            left: _.isCollapsed ? 0 : 0.6 * widget.screenWidth,
            right: _.isCollapsed ? 0 : -0.2 * widget.screenWidth,
            child: ScaleTransition(
              scale: widget.scaleAnimation,
              child: Material(
                animationDuration: widget.duration,
                borderRadius: BorderRadius.all(Radius.circular(40)),
                elevation: 8,
                color: backgroundColor,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 48),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              child: Icon(Icons.menu, color: Colors.black54),
                              onTap: () {
                                setState(() {
                                  if (_.isCollapsed)
                                    _.controller.forward();
                                  else
                                    _.controller.reverse();
                                  _.isCollapsed = !_.isCollapsed;
                                });
                              },
                            ),
                            Flexible(
                              child: Text("Bloqueador universal",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 24, color: Colors.black54)),
                            ),
                            SizedBox(height: 50),
                          ],
                        ),
                        SizedBox(height: 50),
                        _.widgetw,
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
