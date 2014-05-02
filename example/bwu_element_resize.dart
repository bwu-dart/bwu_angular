library angular_observe_resize.main;

import 'dart:async' as async;
import 'dart:html' as dom;
import 'package:angular/angular.dart' as ng;
import 'package:angular/application_factory.dart' as ngaf;

import 'package:bwu_angular/bwu_element_resize/bwu_element_resize.dart';

class MyAppModule extends ng.Module {
  MyAppModule() {
    bind(BwuElementResize);
  }
}

main() {
  print('main');
  ngaf.applicationFactory().addModule(new MyAppModule()).run();

  new async.Timer.periodic(new Duration(seconds: 1), (t) {
    var elt = (dom.querySelector('#my-sizable') as dom.HtmlElement);
    elt.append(new dom.Element.html('<div>${new DateTime.now()}</div>'));
  });
}
