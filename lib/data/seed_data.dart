import '../models/models.dart';

// Fragrances with type/concentration info
const baseVanilla = Fragrance(
  brand: 'Zara',
  name: 'Vanilla (Plain)',
  isBase: true,
  notes: ['vanilla', 'gourmand', 'warm'],
  type: FragranceType.edt, // Light, great for layering
);

const baseColdCaramel = Fragrance(
  brand: 'Zara',
  name: 'Vanilla Cold Caramel',
  isBase: true,
  notes: ['vanilla', 'caramel', 'sweet'],
  type: FragranceType.edt,
);

const blueTemptation = Fragrance(
  brand: 'Zara',
  name: 'Blue Temptation EDP',
  notes: ['fresh', 'marine', 'citrus'],
  type: FragranceType.edp, // 4-8 hours longevity
);

const vibrantLeatherSummer = Fragrance(
  brand: 'Zara',
  name: 'Vibrant Leather Summer',
  notes: ['leather', 'fresh', 'woody'],
  type: FragranceType.edt,
);

const fashionablyLondon = Fragrance(
  brand: 'Zara',
  name: 'Fashionably London',
  notes: ['rose', 'floral', 'musk'],
  type: FragranceType.edp,
);

const ebonyWood = Fragrance(
  brand: 'Zara',
  name: 'Ebony Wood',
  notes: ['smoky', 'woody', 'spice'],
  type: FragranceType.edp,
);

const richWarmAddictive = Fragrance(
  brand: 'Zara',
  name: 'Tobacco Collection Rich Warm Addictive',
  notes: ['tobacco', 'rum', 'coconut'],
  type: FragranceType.edp,
);

const sunriseRedSunDunes = Fragrance(
  brand: 'Zara',
  name: 'Sunrise on the Red Sun Dunes (Intense)',
  notes: ['amber', 'spice', 'warm'],
  type: FragranceType.parfum, // Intense = Extrait/Parfum
);

const oudVibrantLeatherElixir = Fragrance(
  brand: 'Zara',
  name: 'Oud Vibrant Leather Elixir',
  notes: ['oud', 'leather', 'amber'],
  type: FragranceType.parfum, // Elixir = high concentration
);

const shahinGold = Fragrance(
  brand: 'Latafa',
  name: 'Shahin Gold',
  notes: ['oud', 'amber', 'spice'],
  type: FragranceType.edp,
);

const alQiyamGold = Fragrance(
  brand: 'Latafa',
  name: 'Al Qiyam Gold',
  notes: ['oud', 'incense', 'amber'],
  type: FragranceType.edp,
);

const nightPoolWinter = Fragrance(
  brand: 'Zara',
  name: 'Night Pool (Winter Edition)',
  notes: ['aquatic', 'deep', 'mossy'],
  type: FragranceType.edp,
);

// Combos
final allCombos = <Combo>[
  const Combo(
    id: 'summer_confident',
    title: 'Creamy Fresh Confidence',
    season: Season.summer,
    moods: [Mood.confident, Mood.everyday],
    base: baseVanilla,
    top: blueTemptation,
    description:
        'Vanilla softens the marine-citrus freshness into a smooth, addictive summer aura.',
    whenToWear: 'Daytime meetings, lunches, summer outings.',
    layeringTips:
        'Apply vanilla on pulse points, wait 45s, then Blue Temptation on neck and collar.',
    emoji: '⚡',
  ),
  const Combo(
    id: 'summer_chill',
    title: 'Sweet-Salty Breeze',
    season: Season.summer,
    moods: [Mood.chill, Mood.everyday],
    base: baseColdCaramel,
    top: vibrantLeatherSummer,
    description:
        'Crisp leather with a caramel glow — effortless cool with a warm undertone.',
    whenToWear: 'Beach days, sunny hangouts, daily wear.',
    layeringTips:
        'Cold Caramel on skin; light mist of Vibrant Leather Summer on shirt.',
    emoji: '🌊',
  ),
  const Combo(
    id: 'summer_romantic',
    title: 'Rose & Vanilla Veil',
    season: Season.summer,
    moods: [Mood.romantic, Mood.luxury],
    base: baseVanilla,
    top: fashionablyLondon,
    description:
        'Powdery rose wrapped in soft vanilla — understated and memorable.',
    whenToWear: 'Brunches, daytime dates, summer evenings.',
    layeringTips:
        'Vanilla on wrists and chest; Fashionably London higher on neck.',
    emoji: '💕',
  ),
  const Combo(
    id: 'summer_mysterious',
    title: 'Quiet Luxury Woods',
    season: Season.summer,
    moods: [Mood.mysterious, Mood.luxury],
    base: baseColdCaramel,
    top: ebonyWood,
    description: 'Smoky woods with a creamy twist — elegant and intriguing.',
    whenToWear: 'Cool evenings, rooftop lounges, transitional weather.',
    layeringTips:
        'Cold Caramel first; single spray of Ebony Wood to avoid overpowering.',
    emoji: '🌙',
  ),
  // Winter
  const Combo(
    id: 'winter_seductive',
    title: 'Cozy Tobacco Gourmand',
    season: Season.winter,
    moods: [Mood.romantic, Mood.everyday],
    base: baseColdCaramel,
    top: richWarmAddictive,
    description:
        'Tobacco, rum, coconut and caramel vanilla — dangerously cozy and magnetic.',
    whenToWear: 'Nights in, cold evenings, winter dates.',
    layeringTips:
        'Vanilla on skin; spray Rich Warm Addictive lightly on sweater for waves.',
    emoji: '🔥',
  ),
  const Combo(
    id: 'winter_bold',
    title: 'Leather Dream',
    season: Season.winter,
    moods: [Mood.confident, Mood.luxury],
    base: baseVanilla,
    top: oudVibrantLeatherElixir,
    description:
        'Deep leather and oud, smoothed by vanilla — niche-level sophistication.',
    whenToWear: 'Classy dinners, black-tie, winter nights.',
    layeringTips: 'Keep oud to 1–2 sprays; vanilla anchors the sharpness.',
    emoji: '✨',
  ),
  const Combo(
    id: 'winter_adventurous',
    title: 'Spiced Amber Glow',
    season: Season.winter,
    moods: [Mood.adventurous, Mood.luxury],
    base: baseColdCaramel,
    top: sunriseRedSunDunes,
    description: 'Desert warmth meets sweetness — exotic and unforgettable.',
    whenToWear: 'Late afternoons, cultural events, cozy indoor settings.',
    layeringTips: 'Caramel vanilla first; go easy on the spice to avoid clash.',
    emoji: '🌸',
  ),
  const Combo(
    id: 'winter_regal',
    title: 'Golden Majesty',
    season: Season.winter,
    moods: [Mood.regal, Mood.luxury],
    base: baseColdCaramel,
    top: shahinGold,
    description: 'Oud richness lifted by creamy sweetness — pure royalty.',
    whenToWear: 'Celebrations, evening parties, winter daytime.',
    layeringTips:
        'Two-spray max of Shahin Gold; vanilla on scarf enhances trail.',
    emoji: '👑',
  ),
  const Combo(
    id: 'winter_elegant',
    title: 'Silken Incense',
    season: Season.winter,
    moods: [Mood.luxury, Mood.confident],
    base: baseVanilla,
    top: alQiyamGold,
    description: 'Incense and oud wrapped in vanilla for a luxurious aura.',
    whenToWear: 'Cold nights, luxurious settings.',
    layeringTips: 'Vanilla on skin; Al Qiyam Gold on coat lining for aura.',
    emoji: '🌌',
  ),
  const Combo(
    id: 'winter_calm',
    title: 'Icy-Hot Serenity',
    season: Season.winter,
    moods: [Mood.calm, Mood.mysterious],
    base: baseColdCaramel,
    top: nightPoolWinter,
    description: 'Deep aquatic with caramel contrast — unique winter serenity.',
    whenToWear: 'Cold rainy days, evening walks, under a jacket.',
    layeringTips: 'Cold Caramel lightly; Night Pool as a mist over clothes.',
    emoji: '🌌',
  ),
];
