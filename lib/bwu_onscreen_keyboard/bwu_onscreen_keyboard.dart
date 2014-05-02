library bwu_angular.bwu_onscreen_keyboard;

import 'dart:html' as dom;
import 'package:angular/angular.dart' as ng;

@ng.Component(selector: 'bwu-onscreen-keyboard', publishAs: 'cmp', templateUrl:
    'bwu_onscreen_keyboard.html', cssUrl:
    'packages/bwu_angular/bwu_onscreen_keyboard/bwu_onscreen_keyboard.css')
class BwuOnscreenKeyboard {

  @ng.NgTwoWay('value')
  String text = "";
  bool get isShift => isLeftShift || isRightShift || isCapsLock;
  bool isLeftShift = false;
  bool isRightShift = false;
  bool isCapsLock = false;

  BwuOnscreenKeyboard() {
    print('BwuOnscreenKeyboard');
  }

  void onClick(dom.MouseEvent e) {
    // workaround for null assigned by AngularDart
    if (text == null) {
      text = "";
    }
    var elm = (e.target as dom.HtmlElement);

    if (elm is dom.SpanElement) {
      elm = elm.parent;
    }

    String key;
    if (elm.classes.contains('symbol')) {
      key = elm.querySelector('.off').innerHtml;
      text += key;
    } else {
      key = elm.innerHtml;
    }

    if (elm.classes.contains('delete') && elm.classes.contains('lastitem')) {
      if (text.length > 0) {
        text = text.substring(0, text.length - 1);
      }
    }

    if (elm.classes.contains('tab')) {
      text += '\t';
    }

    if (elm.classes.contains('return')) {
      text += '\n';
    }

    if (elm.classes.contains('space')) {
      text += ' ';
    }

    if (elm.classes.contains('letter')) {
      if (isShift) {
        text += key.toUpperCase();
      } else {
        text += key;
      }
    }

    if (elm.classes.contains('capslock')) {
      isCapsLock = !isCapsLock;
    }

    if (elm.classes.contains('left-shift')) {
      isCapsLock = false;
      isRightShift = false;
      isLeftShift = !isLeftShift;
    }

    if (elm.classes.contains('right-shift')) {
      isCapsLock = false;
      isLeftShift = false;
      isRightShift = !isRightShift;
    }

    if (!(elm.classes.contains('left-shift') || elm.classes.contains(
        'right-shift'))) {
      isLeftShift = false;
      isRightShift = false;
    }
  }
}
