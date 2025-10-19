# Signature Scent Wardrobe

A professional Flutter application for fragrance enthusiasts to explore, layer, and manage perfume combinations. Built with Material Design 3 and modern UI/UX principles.

## Overview

Signature Scent Wardrobe helps users discover and create sophisticated fragrance layering combinations. The app provides detailed information about fragrance types, concentrations, longevity, and projection, making it an educational tool for both novice and experienced perfume lovers.

## Key Features

### Fragrance Management
- **Extensive Fragrance Library**: Browse 20+ curated fragrance combinations
- **Detailed Fragrance Information**: View concentration levels (EDC, EDT, EDP, Parfum, Oil), longevity (1-24 hours), and projection strength
- **Layering System**: Combine base fragrances (Vanilla, Cold Caramel) with top fragrances for unique scent profiles
- **Fragrance Notes**: Explore comprehensive note breakdowns for each fragrance

### Smart Filtering & Organization
- **Season Toggle**: Switch between Summer and Winter fragrance recommendations
- **Mood-Based Filtering**: Filter combinations by mood categories (Confident, Romantic, Mysterious, Everyday, Luxury, Chill, Adventurous, Regal, Calm)
- **Combination Browser**: View all available fragrance pairings in a clean grid layout
- **Individual Fragrance View**: Access detailed pages for each fragrance and combination

### User Experience
- **Clean Minimalist Design**: White card-based interface with subtle shadows and professional typography
- **Seasonal Backgrounds**: Dynamic background images that adapt to selected season (beach for summer, snowy landscapes for winter)
- **Responsive Layout**: Optimized for various Android screen sizes
- **Intuitive Navigation**: Easy-to-use bottom navigation and clear information hierarchy

### Educational Content
- **Fragrance Type System**: Learn about five fragrance concentration types with detailed specifications
- **Professional Terminology**: Understand industry-standard terms like concentration percentage, longevity, and sillage/projection
- **Layering Guidance**: Discover which fragrances work well together and why

## Technical Specifications

### Technology Stack
- **Framework**: Flutter 3.35.2 (Dart 3.9.0)
- **UI Design**: Material Design 3
- **Platform**: Android (with cross-platform capabilities)
- **Minimum Android Version**: 5.0 (Lollipop) / API Level 21

### Architecture
- **State Management**: StatefulWidget with local state
- **Data Layer**: Seed data with structured models
- **Navigation**: MaterialPageRoute with custom transitions
- **Persistence**: SharedPreferences for favorites management

### Project Structure
```
lib/
├── main.dart                       # Application entry point
├── models/
│   └── models.dart                 # Data models (Fragrance, Combo, FragranceType)
├── data/
│   └── seed_data.dart              # Fragrance and combination database
├── pages/
│   ├── home_page.dart              # Main combinations grid view
│   ├── combo_detail_page.dart      # Combination detail view
│   ├── fragrance_detail_page.dart  # Individual fragrance details
│   ├── fragrance_library_page.dart # All fragrances browser
│   └── favorites_page.dart         # User favorites collection
├── theme/
│   └── app_theme.dart              # Theme definitions and color schemes
├── widgets/
│   └── animated_effects.dart       # Reusable UI effect widgets
└── utils/
    └── favorites_manager.dart      # Favorites persistence logic
```

## Installation

### Prerequisites
- Flutter SDK 3.35.2 or higher
- Android Studio or VS Code with Flutter extensions
- Android device or emulator (Android 5.0+)
- Git for version control

### Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/Iviwe01/Signature-Scent-Wardrobe.git
   cd Signature-Scent-Wardrobe
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   # Development mode
   flutter run

   # Release mode (optimized)
   flutter run --release
   ```

4. **Build APK for distribution**
   ```bash
   flutter build apk --release
   ```
   The APK will be located at: `build/app/outputs/flutter-apk/app-release.apk`

## Fragrance Type Reference

### EDC (Eau de Cologne)
- Concentration: 2-5%
- Longevity: 1-2 hours
- Projection: Light
- Best for: Quick refreshment, hot weather

### EDT (Eau de Toilette)
- Concentration: 5-15%
- Longevity: 2-4 hours
- Projection: Moderate
- Best for: Daily wear, office environments

### EDP (Eau de Parfum)
- Concentration: 15-20%
- Longevity: 4-8 hours
- Projection: Strong
- Best for: Evening wear, special occasions

### Parfum (Pure Perfume)
- Concentration: 20-40%
- Longevity: 8-12+ hours
- Projection: Very Strong
- Best for: All-day wear, maximum impact

### Oil (Fragrance Oil)
- Concentration: 15-100%
- Longevity: 12-24+ hours
- Projection: Intimate to Very Strong
- Best for: Close, personal scent experiences

## Featured Fragrances

### Base Fragrances
- **Zara Vanilla** (EDT): Sweet, warm vanilla base for layering
- **Zara Cold Caramel** (EDT): Cool caramel notes for unique combinations

### Top Fragrances (Sample)
- **Blue Temptation** (EDP): Fresh aquatic with citrus notes
- **Rich Warm Addictive** (EDP): Spicy oriental with amber
- **Fashionably London** (EDP): Floral with urban sophistication
- **Sunrise on Red Sun Dunes** (Parfum): Intense oud and spices
- **Oud Vibrant Leather Elixir** (Parfum): Bold leather with oud

## Development

### Code Style
- Follow Flutter/Dart style guidelines
- Use meaningful variable and function names
- Document complex logic with comments
- Maintain consistent indentation (2 spaces)

### Testing
```bash
# Run unit tests
flutter test

# Run widget tests
flutter test test/widget_test.dart

# Analyze code for issues
flutter analyze
```

### Building for Production

**Android Release Build**
```bash
flutter build apk --release --split-per-abi
```

**Android App Bundle (for Google Play)**
```bash
flutter build appbundle --release
```

## Contributing

Contributions are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Version History

### Version 1.0.0 (October 2025)
- Initial release
- 20+ fragrance combinations
- Season-based filtering
- Mood-based organization
- Fragrance type information system
- Clean minimalist UI design
- Seasonal background images

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Flutter team for the excellent framework
- Material Design team for design guidelines
- Unsplash for background images
- Fragrance community for inspiration and knowledge

## Contact

**Developer**: Iviwe01  
**Email**: andyrosecpt@gmail.com  
**Repository**: [https://github.com/Iviwe01/Signature-Scent-Wardrobe](https://github.com/Iviwe01/Signature-Scent-Wardrobe)

## Roadmap

### Planned Features
- Advanced search functionality with filters
- User authentication and cloud sync
- Personal fragrance collection management
- Custom combination creator
- Fragrance review and rating system
- Social sharing capabilities
- Fragrance wheel visualization
- Price tracking and shopping integration
- Seasonal recommendations algorithm
- Fragrance longevity tracker
- Wear history and statistics
- Dark mode support
- Multi-language support
- iOS version

### Performance Optimizations
- Image caching improvements
- Lazy loading for large lists
- State management refactoring
- Database integration for offline access

## Support

For issues, questions, or suggestions:
- Open an issue on GitHub
- Email: andyrosecpt@gmail.com

---

**Signature Scent Wardrobe** - Your Personal Fragrance Companion

