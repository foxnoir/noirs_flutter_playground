import 'package:meta/meta.dart';

@immutable
class Item {
  const Item({required this.id, required this.title, required this.subtitle});

  final int id;
  final String title;
  final String subtitle;

  @override
  bool operator ==(Object other) {
    return other is Item &&
        other.id == id &&
        other.title == title &&
        other.subtitle == subtitle;
  }

  @override
  int get hashCode => Object.hash(id, title, subtitle);
}
