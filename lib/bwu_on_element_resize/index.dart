library angular_observe_resize.main;

import 'dart:async' as async;
import 'dart:html' as dom;
import 'package:angular/angular.dart' as ng;
import 'package:angular/application_factory.dart' as ngaf;

// see http://stackoverflow.com/questions/19329530
// and this bug https://code.google.com/p/dart/issues/detail?id=18062
// source from http://www.backalleycoder.com/2013/03/18/cross-browser-event-based-element-resize-detection/

@ng.Decorator(selector: '[ng-observe-size]')
class NgObserveSizeDirective implements ng.AttachAware, ng.DetachAware {
  dom.Element _element;
  bool _hasAttacheEvent;

  NgObserveSizeDirective(this._element);

  void onSizeChange(dom.Event e) {
    _element.parent.scrollTop = _element.scrollHeight;
  }

  dom.HtmlElement _triggers;

  void resetTriggers() {
    var expand = _triggers.children[0];
    var contract = _triggers.children[_triggers.children.length - 1];
    var expandChild = expand.children[0];
    contract.scrollLeft = contract.scrollWidth;
    contract.scrollTop = contract.scrollHeight;
    expandChild.style.width = '${expand.offsetWidth + 1}px';
    expandChild.style.height = '${expand.offsetHeight + 1}px';
    expand.scrollLeft = expand.scrollWidth;
    expand.scrollTop = expand.scrollHeight;
  }

  int _resizeLastWidth;
  int _resizeLastHeight;

  bool checkTriggers() {
    return _element.offsetWidth != _resizeLastWidth ||
        _element.offsetHeight != _resizeLastHeight;
  }

  int _resizeRaf;


  void scrollListener(dom.Event e) {
    resetTriggers();
    if(_resizeRaf != null) {
      dom.window.cancelAnimationFrame(_resizeRaf);
    }
    _resizeRaf = dom.window.requestAnimationFrame((num highResTime){
      if(checkTriggers()) {
        _resizeLastWidth = _element.offsetWidth;
        _resizeLastHeight = _element.offsetHeight;
        onSizeChange(e);
      }
    });
  }

  @override
  void attach() {
    if(_element.getComputedStyle().position == 'static') {
      _element.style.position = 'relative';
    }

    _triggers = new dom.DivElement()
      ..classes.add('resize-triggers')
      ..append(new dom.DivElement()..classes.add('expand-trigger')..append(new dom.DivElement()))
      ..append(new dom.DivElement()..classes.add('contract-trigger'));
   _element.append(_triggers);

    new async.Future.delayed(new Duration(seconds: 1), () {
      //_triggers = _element.children[_element.children.length - 1];
      resetTriggers();

      dom.Element.scrollEvent.forTarget(_element, useCapture: true).listen(scrollListener);
    });
  }

  @override
  void detach() {
    _triggers.remove();
  }
}

class MyAppModule extends ng.Module {
  MyAppModule() {
    type(NgObserveSizeDirective);
  }
}

main() {
  print('main');
  ngaf.applicationFactory().addModule(new MyAppModule()).run();

  new async.Timer.periodic(new Duration(seconds: 1), (t) {
    var elt = (dom.querySelector('#my_sizable') as dom.HtmlElement);
    elt.append(new dom.Element.html('<div>${new DateTime.now()}</div>'));
  });
}
