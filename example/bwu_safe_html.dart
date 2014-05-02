library main;

import 'dart:html' as dom;
import 'package:angular/angular.dart' as ng;
import 'package:angular/application_factory.dart' as ngaf;

import 'package:bwu_angular/bwu_safe_html/bwu_safe_html.dart';
import 'package:bwu_angular/bwu_onscreen_keyboard/bwu_onscreen_keyboard.dart';

@ng.Controller(selector: '[my-ctrl]', publishAs: 'ctrl')
class MyController {
  MyController() {
    print('MyController');
  }
  String html =
      '''
<div><span>some inserted HTML:</span>
  <table>
    <th>A</th>
    <th>B</th>
    <th>C</th>
    <tr>
      <td>1</td>
      <td>2</td>
      <td>3</td>
    </tr>
    <tr>
      <td>4</td>
      <td>5</td>
      <td>6</td>
    </tr>
  </table>
</div>  
<bwu-onscreen-keyboard></bwu-onscreen-keyboard>
''';
}

class MyAppModule extends ng.Module {
  MyAppModule() {
    bind(dom.NodeValidator, toFactory: (_) => new dom.NodeValidatorBuilder()
        ..allowHtml5()
        ..allowCustomElement('bwu-onscreen-keyboard'));
    bind(MyController);
    bind(BwuSafeHtml);
    bind(BwuOnscreenKeyboard);
  }
}


void main() {
  print('main');
  ngaf.applicationFactory().addModule(new MyAppModule()).run();
}
