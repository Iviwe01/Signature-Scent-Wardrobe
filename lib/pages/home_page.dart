import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:vibration/vibration.dart';
import '../models/models.dart';
import '../data/seed_data.dart';
import 'combo_detail_page.dart';
import 'favorites_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Season _season = Season.summer;
  final Set<Mood> _selectedMoods = {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filtered = allCombos.where((c) {
      final okSeason = c.season == _season;
      final okMood =
          _selectedMoods.isEmpty ||
          c.moods.any((m) => _selectedMoods.contains(m));
      return okSeason && okMood;
    }).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Signature Scent Wardrobe',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Search',
            onPressed: () {
              HapticFeedback.lightImpact();
              Vibration.vibrate(duration: 50);
              // TODO: Search
            },
            icon: const Icon(Icons.search_rounded),
          ),
          IconButton(
            tooltip: 'Favorites',
            onPressed: () {
              HapticFeedback.lightImpact();
              Vibration.vibrate(duration: 50);
              // TODO: Favorites
            },
            icon: const Icon(Icons.favorite_border_rounded),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Seasonal background image
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 1000),
            child: Container(
              key: ValueKey(_season),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    _season == Season.summer
                        ? 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=1200&q=80' // Tropical beach
                        : 'https://images.unsplash.com/photo-1482938289607-e9573fc25ebb?w=1200&q=80', // Winter snowy scene
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    _season == Season.summer
                        ? Colors.white.withValues(alpha: 0.3)
                        : Colors.black.withValues(alpha: 0.5),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
          ),

          // Gradient overlay for readability
          AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOutCubic,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: _season == Season.summer
                    ? [
                        const Color(0xFFFFF9F5).withValues(alpha: 0.7),
                        const Color(0xFFFFE8D6).withValues(alpha: 0.5),
                        const Color(0xFFE8F9F5).withValues(alpha: 0.7),
                      ]
                    : [
                        const Color(0xFF0A0E1A).withValues(alpha: 0.8),
                        const Color(0xFF1A1D2E).withValues(alpha: 0.6),
                        const Color(0xFF16213E).withValues(alpha: 0.8),
                      ],
              ),
            ),
          ).animate().fadeIn(duration: 600.ms),

          // Content with safe area
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 16),
                _SeasonToggle(
                  season: _season,
                  onChanged: (s) {
                    HapticFeedback.selectionClick();
                    Vibration.vibrate(duration: 30);
                    setState(() => _season = s);
                  },
                ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.1, end: 0),
                const SizedBox(height: 16),
                _MoodChips(
                  selected: _selectedMoods,
                  onChanged: (m) {
                    HapticFeedback.selectionClick();
                    Vibration.vibrate(duration: 20);
                    setState(() {
                      if (_selectedMoods.contains(m)) {
                        _selectedMoods.remove(m);
                      } else {
                        _selectedMoods.add(m);
                      }
                    });
                  },
                ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.1, end: 0),
                const SizedBox(height: 16),
                Expanded(
                  child: filtered.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.psychology_alt_rounded,
                                size: 80,
                                color: theme.colorScheme.primary.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No combos match your vibe',
                                style: theme.textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Try adjusting your filters',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ).animate().fadeIn().scale(),
                        )
                      : AnimationLimiter(
                          child: GridView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  childAspectRatio: 0.72,
                                ),
                            itemCount: filtered.length,
                            itemBuilder: (context, i) {
                              final combo = filtered[i];
                              return AnimationConfiguration.staggeredGrid(
                                position: i,
                                duration: const Duration(milliseconds: 600),
                                columnCount: 2,
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: _ComboCard(
                                      combo: combo,
                                      onTap: () {
                                        HapticFeedback.mediumImpact();
                                        Vibration.vibrate(duration: 40);
                                        Navigator.of(context).push(
                                          PageRouteBuilder(
                                            pageBuilder:
                                                (
                                                  context,
                                                  animation,
                                                  secondaryAnimation,
                                                ) => ComboDetailPage(
                                                  combo: combo,
                                                ),
                                            transitionsBuilder:
                                                (
                                                  context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child,
                                                ) {
                                                  const begin = Offset(
                                                    0.0,
                                                    0.1,
                                                  );
                                                  const end = Offset.zero;
                                                  const curve =
                                                      Curves.easeOutCubic;
                                                  var tween =
                                                      Tween(
                                                        begin: begin,
                                                        end: end,
                                                      ).chain(
                                                        CurveTween(
                                                          curve: curve,
                                                        ),
                                                      );
                                                  return SlideTransition(
                                                    position: animation.drive(
                                                      tween,
                                                    ),
                                                    child: FadeTransition(
                                                      opacity: animation,
                                                      child: child,
                                                    ),
                                                  );
                                                },
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          HapticFeedback.mediumImpact();
          Vibration.vibrate(duration: 50);
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => _QuickActionsSheet(),
          );
        },
        icon: const Icon(Icons.tune_rounded),
        label: const Text('Customize'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 8,
      ),
    );
  }
}

class _SeasonToggle extends StatelessWidget {
  final Season season;
  final ValueChanged<Season> onChanged;
  const _SeasonToggle({required this.season, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: SegmentedButton<Season>(
              segments: [
                ButtonSegment(
                  value: Season.summer,
                  label: const Text('☀️ Summer'),
                  icon: const Icon(Icons.wb_sunny_rounded),
                ),
                ButtonSegment(
                  value: Season.winter,
                  label: const Text('❄️ Winter'),
                  icon: const Icon(Icons.ac_unit_rounded),
                ),
              ],
              selected: {season},
              onSelectionChanged: (s) => onChanged(s.first),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return season == Season.summer
                        ? const Color(0xFF4ECDC4).withValues(alpha: 0.9)
                        : const Color(0xFF5E6FA3).withValues(alpha: 0.9);
                  }
                  return Colors.white.withValues(alpha: 0.6);
                }),
                foregroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.white;
                  }
                  return Colors.black87;
                }),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MoodChips extends StatelessWidget {
  final Set<Mood> selected;
  final ValueChanged<Mood> onChanged;
  const _MoodChips({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    const items = [
      Mood.confident,
      Mood.romantic,
      Mood.mysterious,
      Mood.everyday,
      Mood.luxury,
      Mood.chill,
      Mood.adventurous,
      Mood.regal,
      Mood.calm,
    ];
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final m = items[index];
          final isSelected = selected.contains(m);
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => onChanged(m),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? LinearGradient(
                            colors: [
                              Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.9),
                              Theme.of(
                                context,
                              ).colorScheme.tertiary.withValues(alpha: 0.8),
                            ],
                          )
                        : null,
                    color: isSelected
                        ? null
                        : Theme.of(context).brightness == Brightness.light
                        ? Colors.white.withValues(alpha: 0.7)
                        : Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _getMoodEmoji(m),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _moodLabel(m),
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Theme.of(context).colorScheme.onSurface,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _getMoodEmoji(Mood m) => switch (m) {
    Mood.confident => '⚡',
    Mood.romantic => '💕',
    Mood.mysterious => '🌙',
    Mood.everyday => '🌸',
    Mood.luxury => '✨',
    Mood.chill => '🌊',
    Mood.adventurous => '🔥',
    Mood.regal => '👑',
    Mood.calm => '🌌',
  };

  String _moodLabel(Mood m) => switch (m) {
    Mood.confident => 'Confident',
    Mood.romantic => 'Romantic',
    Mood.mysterious => 'Mysterious',
    Mood.everyday => 'Everyday',
    Mood.luxury => 'Luxury',
    Mood.chill => 'Chill',
    Mood.adventurous => 'Adventurous',
    Mood.regal => 'Regal',
    Mood.calm => 'Calm',
  };
}

class _QuickActionsSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Actions',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                _ActionTile(
                  icon: Icons.favorite_rounded,
                  title: 'My Favorites',
                  subtitle: 'View saved combinations',
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavoritesPage(),
                      ),
                    );
                  },
                ),
                _ActionTile(
                  icon: Icons.add_circle_outline_rounded,
                  title: 'Create Custom Blend',
                  subtitle: 'Mix your own combination',
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Navigator.pop(context);
                  },
                ),
                _ActionTile(
                  icon: Icons.insights_rounded,
                  title: 'Scent Analysis',
                  subtitle: 'Learn about fragrance notes',
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.brightness == Brightness.light
                  ? Colors.white.withValues(alpha: 0.7)
                  : Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.colorScheme.primary.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary.withValues(alpha: 0.2),
                        theme.colorScheme.tertiary.withValues(alpha: 0.15),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: theme.colorScheme.primary, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ComboCard extends StatefulWidget {
  final Combo combo;
  final VoidCallback? onTap;
  const _ComboCard({required this.combo, this.onTap});

  @override
  State<_ComboCard> createState() => _ComboCardState();
}

class _ComboCardState extends State<_ComboCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: (_) => _scaleController.forward(),
        onTapUp: (_) {
          _scaleController.reverse();
          widget.onTap?.call();
        },
        onTapCancel: () => _scaleController.reverse(),
        child: Hero(
          tag: 'combo_${widget.combo.id}',
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon/Emoji representing the combo
                Container(
                  width: double.infinity,
                  height: 96,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      widget.combo.emoji,
                      style: const TextStyle(fontSize: 46),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Title
                Text(
                  widget.combo.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                    fontSize: 14,
                    color: Color(0xFF1A1D2E),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                // Base + Top
                Text(
                  '${widget.combo.base.name} +',
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 10,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 1),
                Text(
                  widget.combo.top.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color: Color(0xFF374151),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                // Mood chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: widget.combo.moods.take(2).map((m) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            _moodShort(m),
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 9,
                              color: Color(0xFF4B5563),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _moodShort(Mood m) => switch (m) {
    Mood.confident => 'Confident',
    Mood.romantic => 'Romantic',
    Mood.mysterious => 'Mystery',
    Mood.everyday => 'Daily',
    Mood.luxury => 'Luxury',
    Mood.chill => 'Chill',
    Mood.adventurous => 'Adventure',
    Mood.regal => 'Regal',
    Mood.calm => 'Calm',
  };
}
