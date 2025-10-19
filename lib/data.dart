import 'models.dart';

// Fragrances
const fVanillaPlain = Fragrance(
  brand: 'Zara',
  name: 'Vanilla (Plain)',
  isBase: true,
  notes: ['Vanilla', 'Creamy', 'Soft Sweetness'],
);

const fVanillaCaramel = Fragrance(
  brand: 'Zara Heritage Selection',
  name: 'Vanilla Cold Caramel (V2)',
  isBase: true,
  notes: ['Vanilla', 'Caramel', 'Warm Gourmand'],
);

const fBlueTemptation = Fragrance(
  brand: 'Zara',
  name: 'Blue Temptation EDP',
  notes: ['Fresh', 'Citrus', 'Marine'],
);

const fVibrantLeatherSummer = Fragrance(
  brand: 'Zara',
  name: 'Vibrant Leather Summer',
  notes: ['Woody', 'Fresh', 'Leather'],
);

const fFashionablyLondon = Fragrance(
  brand: 'Zara',
  name: 'Fashionably London',
  notes: ['Rose', 'Musk', 'Powdery'],
);

const fEbonyWood = Fragrance(
  brand: 'Zara',
  name: 'Ebony Wood',
  notes: ['Smoky', 'Woody'],
);

const fRichWarmAddictive = Fragrance(
  brand: 'Zara Tobacco Collection',
  name: 'Rich Warm Addictive',
  notes: ['Tobacco', 'Rum', 'Coconut', 'Vanilla'],
);

const fSunriseRedSunDunes = Fragrance(
  brand: 'Zara',
  name: 'Sunrise on the Red Sun Dunes Intense',
  notes: ['Spicy', 'Amber', 'Warm'],
);

const fOudVibrantLeatherElixir = Fragrance(
  brand: 'Zara',
  name: 'Oud Vibrant Leather Elixir',
  notes: ['Oud', 'Leather', 'Amber'],
);

const fNightPoolWinter = Fragrance(
  brand: 'Zara Heritage Selection',
  name: 'Night Pool Home Ray 2 (Winter Edition)',
  notes: ['Deep Aquatic', 'Cool', 'Mysterious'],
);

const fShahinGold = Fragrance(
  brand: 'Shahin',
  name: 'Gold',
  notes: ['Oriental', 'Warm', 'Opulent'],
);

const fAlQiyamGold = Fragrance(
  brand: 'Latafa',
  name: 'Al Qiyam Gold',
  notes: ['Oud', 'Incense', 'Amber'],
);

// Combos
final List<Combo> allCombos = [
  // Summer
  Combo(
    id: 'summer_confident_bt',
    season: Season.summer,
    moods: const [Mood.confident, Mood.everyday],
    base: fVanillaPlain,
    top: fBlueTemptation,
    title: 'Creamy Fresh',
    description:
        'Blue Temptation over vanilla turns a bright marine-citrus into a smooth, addictive summer breeze.',
    when: 'Daytime meetings, lunch dates, summer evenings',
    tips: const [
      'Apply vanilla to pulse points, wait 45s, then mist Blue Temptation on neck and shirt collar.',
      'Go lighter in high heat — 2 sprays vanilla, 2 sprays top.',
    ],
  ),
  Combo(
    id: 'summer_chill_vls',
    season: Season.summer,
    moods: const [Mood.chill, Mood.everyday],
    base: fVanillaCaramel,
    top: fVibrantLeatherSummer,
    title: 'Sweet-Salty Breeze',
    description:
        'Cold Caramel vanilla adds a gourmand lift to the crisp leather freshness for effortless cool.',
    when: 'Beach days, casual hangouts, daily wear',
    tips: const [
      'Vanilla on skin, Vibrant Leather Summer lightly on clothes for projection.',
    ],
  ),
  Combo(
    id: 'summer_romantic_fl',
    season: Season.summer,
    moods: const [Mood.romantic, Mood.everyday],
    base: fVanillaPlain,
    top: fFashionablyLondon,
    title: 'Rose Cream',
    description:
        'Powdery rose and musk wrapped in soft vanilla — understated but memorable.',
    when: 'Brunches, daytime dates, evenings out',
    tips: const [
      'Try hair-mist trick with the top fragrance for a soft trail.',
    ],
  ),
  Combo(
    id: 'summer_mysterious_ew',
    season: Season.summer,
    moods: const [Mood.mysterious, Mood.luxury],
    base: fVanillaCaramel,
    top: fEbonyWood,
    title: 'Smoked Caramel Wood',
    description:
        'Smoky woods with a creamy caramel twist — niche-style “quiet luxury.”',
    when: 'Late summer evenings, rooftop lounges',
    tips: const [
      'Vanilla on chest + Ebony Wood on outer clothing creates a perfect contrast.',
    ],
  ),

  // Winter
  Combo(
    id: 'winter_seductive_rwa',
    season: Season.winter,
    moods: const [Mood.bold, Mood.romantic],
    base: fVanillaCaramel,
    top: fRichWarmAddictive,
    title: 'Golden Warmth',
    description:
        'Tobacco, rum, coconut & vanilla blend into a cozy, magnetic cloud — dangerously inviting.',
    when: 'Cold evenings, winter dates, nights in',
    tips: const [
      'Vanilla on skin, Rich Warm Addictive on sweater for layered waves as you move.',
    ],
  ),
  Combo(
    id: 'winter_bold_ovle',
    season: Season.winter,
    moods: const [Mood.confident, Mood.luxury, Mood.bold],
    base: fVanillaPlain,
    top: fOudVibrantLeatherElixir,
    title: 'Leather Dream',
    description:
        'Opulent oud-leather smoothed by vanilla — refined power with a welcoming edge.',
    when: 'Classy dinners, special occasions, black-tie',
    tips: const [
      '2 sprays vanilla on skin, 1-2 sprays top on coat/scarf for elegant projection.',
    ],
  ),
  Combo(
    id: 'winter_adventurous_sunrise',
    season: Season.winter,
    moods: const [Mood.adventurous, Mood.bold],
    base: fVanillaCaramel,
    top: fSunriseRedSunDunes,
    title: 'Amber Desert',
    description:
        'Warm spices and amber glow fused with caramel vanilla — exotic and unforgettable.',
    when: 'Late afternoons, cultural events, cozy indoor settings',
    tips: const [
      'Test indoors first — vanilla sweetness amplifies with heat.',
    ],
  ),
  Combo(
    id: 'winter_regal_shahin',
    season: Season.winter,
    moods: const [Mood.regal, Mood.luxury],
    base: fVanillaCaramel,
    top: fShahinGold,
    title: 'Royal Caramel Oud',
    description:
        'Golden oud richness lifted by creamy sweetness — pure celebration energy.',
    when: 'Celebrations, evening parties',
    tips: const [
      'Go easy: 1 spray vanilla + 1 spray Shahin Gold can be plenty indoors.',
    ],
  ),
  Combo(
    id: 'winter_elegant_alqiyam',
    season: Season.winter,
    moods: const [Mood.luxury, Mood.confident],
    base: fVanillaPlain,
    top: fAlQiyamGold,
    title: 'Silken Incense',
    description:
        'Rich oud and incense blended with vanilla for a luxurious, enveloping aura.',
    when: 'Cold nights, luxurious settings',
    tips: const [
      'Try one spray vanilla on scarf — vanilla clings beautifully to fabric.',
    ],
  ),
  Combo(
    id: 'winter_calm_nightpool',
    season: Season.winter,
    moods: const [Mood.calm, Mood.mysterious],
    base: fVanillaCaramel,
    top: fNightPoolWinter,
    title: 'Icy Glow',
    description:
        'Deep aquatic cool wrapped in gentle sweetness — a serene winter signature.',
    when: 'Quiet evenings, rainy cold days, night walks',
    tips: const [
      'Keep sprays light on clothing to preserve the aquatic depth.',
    ],
  ),
];
