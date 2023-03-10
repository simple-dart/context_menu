import 'dart:async';

import 'package:simple_dart_label/simple_dart_label.dart';
import 'package:simple_dart_modal_controller/simple_dart_modal_controller.dart';
import 'package:simple_dart_ui_core/simple_dart_ui_core.dart';

class ContextMenu {
  ContextMenu();

  Panel menuPanel = Panel()
    ..addCssClass('ContextMenu')
    ..vertical = true;

  Completer<String> completer = Completer<String>();

  set maxHeight(String maxHeight) {
    menuPanel.element.style.maxHeight = maxHeight;
  }

  String get maxHeight => menuPanel.element.style.maxHeight;

  Future<String> showContextMenu(List<String> actions, int x, int y) {
    for (final action in actions) {
      final actionElement = Label()
        ..addCssClass('ContextMenuAction')
        ..caption = action;
      actionElement.onClick.listen((event) {
        completer.complete(action);
        closeMenu();
      });
      menuPanel.add(actionElement);
    }
    menuPanel.element.style.overflow = 'auto';
    modalController.showModal(menuPanel, left: '${x}px', top: '${y}px');
    return completer.future;
  }

  void closeMenu() {
    completer = Completer();
    menuPanel.clear();
    modalController.close();
  }
}
