library accorto_prototype.directives.ac_bind_html;

import 'dart:html' as dom;
import 'package:angular/angular.dart' as ng;

import 'package:logging/logging.dart' show Logger;
final _log = new Logger('accorto_prototype.directives.ac_bind_html');

/**
 * Creates a binding that will innerHTML the result of evaluating the
 * `expression` bound to `bwu-safe-html` into the current element in a secure
 * way.  This expression must evaluate to a string.  The innerHTML-ed content
 * will be sanitized using a default [NodeValidator] constructed as `new
 * dom.NodeValidatorBuilder.common()`.  In a future version, when Strict
 * Contextual Escaping support has been added to Angular.dart, this directive
 * will allow one to bypass the sanitizaton and innerHTML arbitrary trusted
 * HTML.
 *
 * Example:
 *
 *     <div bwu-safe-html="htmlVar"></div>
 */
@ng.Decorator(
  selector: '[bwu-safe-html]'
)
class BwuSafeHtml {
  dom.NodeValidator _validator;

  dom.Element _element;
  ng.Compiler _compiler;
  ng.Injector _injector;
  ng.DirectiveMap _directiveMap;

  BwuSafeHtml(this._element, this._validator, this._injector, this._compiler, this._directiveMap) {
    _log.fine('BwuSafeHtml');
    print('BwuSafeHtml');
  }

  /**
   * Parsed expression from the `bwu-safe-html` attribute.  The result of this
   * expression is innerHTML'd according to the rules specified in this class'
   * documention.
   */
  @ng.NgOneWay('bwu-safe-html')
  set value(value) {
    if(value == null) {
      _element.nodes.clear();
      return;
    }
    _element.setInnerHtml((value == null ? '' : value.toString()),
                                             validator: _validator);
    if(value != null) {
      _compiler(_element.childNodes, _directiveMap)(_injector, _element.childNodes);
    }
  }
}
