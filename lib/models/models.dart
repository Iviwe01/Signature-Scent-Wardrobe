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
  
  // Get a unique image URL based on fragrance characteristics
  String get imageUrl {
    // Map fragrances to specific perfume bottle images from Unsplash
    if (name.contains('Vanilla')) {
      return 'https://images.unsplash.com/photo-1592945403244-b3fbafd7f539?w=400&h=400&fit=crop'; // Amber perfume bottle
    } else if (name.contains('Blue Temptation')) {
      return 'https://images.unsplash.com/photo-1588405748880-12d1d2a59d75?w=400&h=400&fit=crop'; // Blue cologne bottle
    } else if (name.contains('Vibrant Leather')) {
      return 'https://images.unsplash.com/photo-1594035910387-fea47794261f?w=400&h=400&fit=crop'; // Modern cologne bottle
    } else if (name.contains('Fashionably London')) {
      return 'https://images.unsplash.com/photo-1587017539504-67cfbddac569?w=400&h=400&fit=crop'; // Elegant perfume bottle
    } else if (name.contains('Ebony Wood')) {
      return 'https://images.unsplash.com/photo-1565650722405-a8f32a6c1f9b?w=400&h=400&fit=crop'; // Dark woody perfume
    } else if (name.contains('Tobacco')) {
      return 'https://images.unsplash.com/photo-1615634260167-c8cdede054de?w=400&h=400&fit=crop'; // Dark luxury bottle
    } else if (name.contains('Sunrise') || name.contains('Red Sun')) {
      return 'https://images.unsplash.com/photo-1541643600914-78b084683601?w=400&h=400&fit=crop'; // Luxury perfume collection
    } else if (name.contains('Oud') && name.contains('Leather')) {
      return 'https://images.unsplash.com/photo-1523293182086-7651a899d37f?w=400&h=400&fit=crop'; // Niche perfume bottle
    } else if (name.contains('Shahin Gold')) {
      return 'https://images.unsplash.com/photo-1547887537-6158d64c35b3?w=400&h=400&fit=crop'; // Gold luxury perfume
    } else if (name.contains('Al Qiyam')) {
      return 'https://images.unsplash.com/photo-1563170351-be82bc888aa4?w=400&h=400&fit=crop'; // Arabian perfume bottle
    } else if (name.contains('Night Pool')) {
      return 'https://images.unsplash.com/photo-1590736969955-71cc94901144?w=400&h=400&fit=crop'; // Dark aquatic perfume
    } else {
      // Default perfume bottle image
      return 'https://images.unsplash.com/photo-1541643600914-78b084683601?w=400&h=400&fit=crop';
    }
  }
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
