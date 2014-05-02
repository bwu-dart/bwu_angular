library main;

import 'package:angular/angular.dart' as ng;
import 'package:angular/application_factory.dart' as ngaf;

import 'package:bwu_angular/bwu_focus/bwu_focus.dart';

@ng.Component(
  selector: 'my-comp',
  publishAs: 'ctrl',
  template: '''
<style>
  :host {
    display: block;
    border: solid 1px gray;
    padding: 15px;
  }
</style>
<div>
  <div>
    <label for="inputFirstName">first name: </label>
    <input type="text" id="inputFirstName">
  </div>
  <div>
    <label for="inputLastName">last name:</label> 
    <input type="text" id="inputLastName" autofocus>
  </div>
  <div>
    <label for="inputEmail">e-mail:</label> 
    <input type="email" id="inputEmail">
  </div>
</div>'''
)
class MyComp {
  MyComp() {
    print('MyComp');
  }
}

class MyAppModule extends ng.Module {
  MyAppModule() {
    bind(BwuFocus);
    bind(MyComp);
  }
}


void main() {
  print('main');
  ngaf.applicationFactory().addModule(new MyAppModule()).run();
}

