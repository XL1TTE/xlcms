import 'package:xlcms/src/cms_content.dart';
import 'package:xlcms/src/contracts/stash_manager.dart';

final class StashManager implements IStashManager{

  @override
  TComponent attach<TComponent>(CmsContent content) {
    // TODO: implement attach
    throw UnimplementedError();
  }

  @override
  TComponent get<TComponent>(CmsContent content) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  bool has<TComponent>(CmsContent content) {
    // TODO: implement has
    throw UnimplementedError();
  }

  @override
  bool unattach<TComponent>(CmsContent content) {
    // TODO: implement unattach
    throw UnimplementedError();
  }
}