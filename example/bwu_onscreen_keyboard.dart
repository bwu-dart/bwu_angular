library bwu_angular.example.bwu_onscreen_keyboard.main;

import 'package:angular/angular.dart' as ng;
import 'package:angular/application_factory.dart' as ngaf;

import 'package:bwu_angular/bwu_onscreen_keyboard/bwu_onscreen_keyboard.dart';

@ng.Controller(selector: '[ng-controller="text-ctrl"]', publishAs: 'ctrl')
class TextController {
  String text;
}

class MyAppModule extends ng.Module {
  MyAppModule() {
    bind(BwuOnscreenKeyboard);
    bind(TextController);
  }
}

main() {
  print('main');
  ngaf.applicationFactory().addModule(new MyAppModule()).run();
}
