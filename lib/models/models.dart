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
    // Map fragrances to specific themed images from Unsplash
    if (name.contains('Vanilla')) {
      return 'https://images.unsplash.com/photo-1610889556528-9a770e32642f?w=400&h=400&fit=crop'; // Vanilla pods
    } else if (name.contains('Blue Temptation')) {
      return 'https://images.unsplash.com/photo-1615634260167-c8cdede054de?w=400&h=400&fit=crop'; // Blue ocean/fresh
    } else if (name.contains('Vibrant Leather')) {
      return 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=400&h=400&fit=crop'; // Leather texture
    } else if (name.contains('Fashionably London')) {
      return 'https://images.unsplash.com/photo-1490750967868-88aa4486c946?w=400&h=400&fit=crop'; // Roses
    } else if (name.contains('Ebony Wood')) {
      return 'https://images.unsplash.com/photo-1513506003901-1e6a229e2d15?w=400&h=400&fit=crop'; // Dark wood
    } else if (name.contains('Tobacco')) {
      return 'https://images.unsplash.com/photo-1606131731446-db36c988e11a?w=400&h=400&fit=crop'; // Tobacco/warm
    } else if (name.contains('Sunrise') || name.contains('Red Sun')) {
      return 'https://images.unsplash.com/photo-1495216875107-c6c043eb703f?w=400&h=400&fit=crop'; // Desert sunset
    } else if (name.contains('Oud') && name.contains('Leather')) {
      return 'https://images.unsplash.com/photo-1585386959984-a4155224a1ad?w=400&h=400&fit=crop'; // Luxury oud
    } else if (name.contains('Shahin Gold')) {
      return 'https://images.unsplash.com/photo-1610375461246-83df859d849d?w=400&h=400&fit=crop'; // Gold/luxury
    } else if (name.contains('Al Qiyam')) {
      return 'https://images.unsplash.com/photo-1587318043452-0821e9072e52?w=400&h=400&fit=crop'; // Incense smoke
    } else if (name.contains('Night Pool')) {
      return 'https://images.unsplash.com/photo-1519046904884-53103b34b206?w=400&h=400&fit=crop'; // Dark water/pool
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
