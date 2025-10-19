enum Season { summer, winter }

enum Mood { confident, romantic, mysterious, everyday, luxury, chill, bold, regal, calm, adventurous }

class Fragrance {
  final String brand;
  final String name;
  final bool isBase;
  final List<String> notes;

  const Fragrance({
    required this.brand,
    required this.name,
    this.isBase = false,
    this.notes = const [],
  });

  String get label => "$brand $name";
}

class Combo {
  final String id;
  final Season season;
  final List<Mood> moods;
  final Fragrance base;
  final Fragrance top;
  final String title;
  final String description;
  final String when;
  final List<String> tips;

  const Combo({
    required this.id,
    required this.season,
    required this.moods,
    required this.base,
    required this.top,
    required this.title,
    required this.description,
    required this.when,
    this.tips = const [],
  });
}
