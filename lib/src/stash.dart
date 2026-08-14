
import 'package:xlcms/src/cms_content.dart';
import 'package:xlcms/src/contracts/stash.dart';
import 'package:xlcms/src/utility/smart_buffer.dart';

final class Stash<TComponent> implements IStash{
  static const int _bufferInitialLenght = 32;

  final SmartBuffer<TComponent?> _components = SmartBuffer(_bufferInitialLenght);
  
  int get size => _components.length;
  bool get isEmpty => _components.length == 0;

  bool has(CmsContent content) {
    if(_components.length <= content.id) return false;

    return _components[content.id] != null;
  }

  TComponent get(CmsContent content) {
    if(has(content) == false){
      throw Exception('Component of type ${TComponent.runtimeType} is not attached to the ${content.toString()}. \nUse method - has() to check if component is attached before trying to get it.');
    }
    // null-assertion operator is fine here, because of has() check above.
    return _components[content.id]!;
  }

  TComponent add(CmsContent content, TComponent value){
    // null-assertion operator is approved here, because of has() check.
    if(has(content)) return _components[content.id]!;

    _components[content.id] = value;
    return value;
  }

  bool remove(CmsContent content){
    if(has(content) == false) return true;
    
    _components[content.id] = null;
    return true;
  }
}