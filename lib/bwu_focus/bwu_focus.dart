library bwu_angular.bwu_focus;

import 'dart:html' as dom;
import 'package:angular/angular.dart' as ng;

/**
 * Set the focus to the element with the `bwu-focus` attribute.
 * If more than one element has this attribute it is undefined which one of these
 * will get the focus.
 */
@ng.Decorator(selector: '[bwu-focus]')
class BwuFocus implements ng.AttachAware{
  dom.HtmlElement _element;

  BwuFocus(this._element);

  @override
  void attach() {
    _element.focus();
  }
}