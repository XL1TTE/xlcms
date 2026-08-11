import 'dart:collection';

import 'package:xlcms/src/cms_content.dart';
import 'package:xlcms/src/contracts/content_manager.dart';

final class ContentManager implements IContentManager{

  final List<int> _generations = [];
  final Queue<int> _freeIndexes = Queue<int>();

  ({int id, int generation}) extractIdentity() {
    int index;
    if(_freeIndexes.isNotEmpty){
      index = _freeIndexes.removeFirst();
    }
    else{
      index = _generations.length;
      _generations.add(0);
    }

    return (id: index, generation: _generations[index]);
  }

  @override
  CmsContent createContent() {
    final (:id, :generation) = extractIdentity();
    return CmsContent(id:id, generation: generation);
  }

  @override
  bool deleteContent(CmsContent content) {

    if(exist(content) == false) {return false;}

    _generations[content.id]++;
    _freeIndexes.add(content.id);
    return true;
  }

  @override
  bool exist(CmsContent content) {

    if (content.id >= _generations.length) {
      return false;
    }

    return _generations[content.id] == content.generation;
  }

}