import 'package:bloqueador_universal/widgets/pages/page_config.dart';
import 'package:bloqueador_universal/widgets/pages/page_control.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenChange extends GetController {
  static ScreenChange get to => Get.find();
  Widget widgetw = PageControl();
  bool isCollapsed = true;
  AnimationController controller;

  void changeScreen(String tela) async {
    switch (tela) {
      case "Configuração":
        widgetw = PageConfig();
        break;
      case "Comandos":
        widgetw = PageControl();
        break;
      default:
    }
    collapse();
    update(this);
  }

  void collapse() {
    if (isCollapsed) {
      controller.forward();
    } else {
      controller.reverse();
      isCollapsed = !isCollapsed;
    }
  }
}
