enum Season { summer, winter }

enum Mood {
  confident,
  romantic,
  mysterious,
  everyday,
  luxury,
  chill,
  adventurous,
  regal,
  calm,
}

enum FragranceType {
  edc, // Eau de Cologne
  edt, // Eau de Toilette
  edp, // Eau de Parfum
  parfum, // Parfum / Extrait
  oil, // Perfume Oil
}

extension FragranceTypeDetails on FragranceType {
  String get name {
    switch (this) {
      case FragranceType.edc:
        return 'Eau de Cologne (EDC)';
      case FragranceType.edt:
        return 'Eau de Toilette (EDT)';
      case FragranceType.edp:
        return 'Eau de Parfum (EDP)';
      case FragranceType.parfum:
        return 'Parfum / Extrait';
      case FragranceType.oil:
        return 'Perfume Oil';
    }
  }

  String get concentration {
    switch (this) {
      case FragranceType.edc:
        return '2–5%';
      case FragranceType.edt:
        return '5–15%';
      case FragranceType.edp:
        return '15–20%';
      case FragranceType.parfum:
        return '20–40%';
      case FragranceType.oil:
        return '40–100%';
    }
  }

  String get longevity {
    switch (this) {
      case FragranceType.edc:
        return '1–2 hours';
      case FragranceType.edt:
        return '2–4 hours';
      case FragranceType.edp:
        return '4–8 hours';
      case FragranceType.parfum:
        return '8–12 hours+';
      case FragranceType.oil:
        return '8–24 hours';
    }
  }

  String get projection {
    switch (this) {
      case FragranceType.edc:
        return 'Light';
      case FragranceType.edt:
        return 'Moderate';
      case FragranceType.edp:
        return 'Strong';
      case FragranceType.parfum:
        return 'Very Strong';
      case FragranceType.oil:
        return 'Intimate';
    }
  }

  String get notes {
    switch (this) {
      case FragranceType.edc:
        return 'Light, fresh, fades fast';
      case FragranceType.edt:
        return 'Great for daytime';
      case FragranceType.edp:
        return 'Balanced projection';
      case FragranceType.parfum:
        return 'Very rich, intense';
      case FragranceType.oil:
        return 'Most concentrated form';
    }
  }
}

class Fragrance {
  final String brand;
  final String name;
  final bool isBase;
  final List<String> notes; // simple note tags
  final FragranceType type;

  const Fragrance({
    required this.brand,
    required this.name,
    this.isBase = false,
    this.notes = const [],
    this.type = FragranceType.edp, // Default to EDP
  });

  String get label => '$brand $name';
}

class Combo {
  final String id;
  final String title;
  final Season season;
  final List<Mood> moods;
  final Fragrance base;
  final Fragrance top;
  final String description;
  final String whenToWear;
  final String layeringTips;
  final String emoji;

  const Combo({
    required this.id,
    required this.title,
    required this.season,
    required this.moods,
    required this.base,
    required this.top,
    required this.description,
    required this.whenToWear,
    required this.layeringTips,
    this.emoji = '✨',
  });
}
