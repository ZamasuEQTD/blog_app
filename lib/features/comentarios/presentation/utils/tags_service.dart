import 'dart:collection';

class TagService {
  static final RegExp _tag = RegExp(">>[A-Z0-9]{7}");

  const TagService._();

  static List<String> getTags(String texto) {
    List<String> tags = [];

    var matches = _tag.allMatches(texto);

    for (var match in matches) {
      String tag = match.group(0)!;
      tags.add(tag.substring(2));
    }

    return tags;
  }

  static HashSet<String> getTagsUnicos(String texto) =>
      HashSet.from(getTags(texto));
}
