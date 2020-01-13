import 'package:Pasaporte_2020/data/data_manager.dart' as dataManager;
import 'package:Pasaporte_2020/model/content.dart';

class _ContentProvider {
  bool _loaded = false;
  List<Content> _content;

  Future<List<Content>> _checkContent() async {
    if (!_loaded) {
      print('[CP] Cargando lista de contenido al ContentProvider');
      _content = await dataManager.getContent();
      _loaded = true;
    }
    return _content;
  }

  Future<List<Content>> getRootContent() async {
    List<Content> content = await _checkContent();
    if (content == null) return null;
    return content.where((i) => i.root != null && i.root == true).toList();
  }

  Future<List<Content>> getSearchContent(String search) async {
    List<Content> content = await _checkContent();
    if (content == null) return null;
    return content
        .where((i) =>
            i.search != null &&
            i.search.toLowerCase().contains(search.toLowerCase()))
        .toList();
  }

  Future<Content> getContent(String id) async {
    List<Content> content = await _checkContent();
    if (content == null) return null;
    return content.firstWhere((i) => i.id != null && i.id == id);
  }
}

final contentProvider = new _ContentProvider();
