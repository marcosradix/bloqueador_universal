import 'package:bloqueador_universal/states_manager/screen_change.dart';
import 'package:bloqueador_universal/widgets/dashboar.dart';
import 'package:bloqueador_universal/widgets/menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final Color backgroundColor = Color(0xFF4A4A58);

void main() {
  runApp(GetMaterialApp(
    home: MenuDashboardPage(),
      title: 'Bloqueador universal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    ));
}

class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage>
    with SingleTickerProviderStateMixin {
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    Get.put<ScreenChange>(ScreenChange());
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    ScreenChange.to.controller = _controller;
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          Menu(context, _menuScaleAnimation, _slideAnimation),
          DashBoard(
            context,
            screenWidth,
            screenHeight,
            duration,
            _scaleAnimation,
            _menuScaleAnimation,
            _slideAnimation,
          ),
        ],
      ),
    );
  }
}
