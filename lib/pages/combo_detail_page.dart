import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:share_plus/share_plus.dart';
import 'package:vibration/vibration.dart';
import '../models/models.dart';
import '../utils/favorites_manager.dart';

class ComboDetailPage extends StatefulWidget {
  final Combo combo;
  const ComboDetailPage({super.key, required this.combo});

  @override
  State<ComboDetailPage> createState() => _ComboDetailPageState();
}

class _ComboDetailPageState extends State<ComboDetailPage> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final isFav = await FavoritesManager.isFavorite(widget.combo.id);
    setState(() => _isFavorite = isFav);
  }

  Future<void> _toggleFavorite() async {
    await FavoritesManager.toggleFavorite(widget.combo.id);
    setState(() => _isFavorite = !_isFavorite);

    HapticFeedback.mediumImpact();
    Vibration.vibrate(duration: 50);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite ? 'Added to favorites ❤️' : 'Removed from favorites',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface.withValues(alpha: 0.8),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Icon(
              Icons.arrow_back_rounded,
              color: theme.colorScheme.onSurface,
            ),
          ),
          onPressed: () {
            HapticFeedback.lightImpact();
            Vibration.vibrate(duration: 30);
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withValues(alpha: 0.8),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Icon(
                _isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: _isFavorite ? Colors.red : theme.colorScheme.primary,
              ),
            ),
            onPressed: _toggleFavorite,
          ),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Share',
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface.withValues(alpha: 0.8),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.share_rounded,
                color: theme.colorScheme.onSurface,
              ),
            ),
            onPressed: () {
              HapticFeedback.lightImpact();
              Vibration.vibrate(duration: 40);
              _shareCombo(widget.combo);
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: widget.combo.season == Season.summer
                    ? [
                        const Color(0xFFFFF9F5),
                        const Color(0xFFE8F9F5),
                        const Color(0xFFFFE8D6),
                      ]
                    : [
                        const Color(0xFF0A0E1A),
                        const Color(0xFF1A1D2E),
                        const Color(0xFF16213E),
                      ],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hero card with emoji and title
                        Hero(
                          tag: 'combo_${widget.combo.id}',
                          child: _EnhancedHeroCard(combo: widget.combo),
                        ),
                        const SizedBox(height: 24),

                        // Blend section
                        _SectionCard(
                          icon: Icons.layers_rounded,
                          title: 'The Blend',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _BlendLayer(
                                label: 'Base',
                                fragrance: widget.combo.base,
                                emoji: '🌰',
                              ),
                              const SizedBox(height: 12),
                              Center(
                                child: Icon(
                                  Icons.add_circle_outline_rounded,
                                  color: theme.colorScheme.primary,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(height: 12),
                              _BlendLayer(
                                label: 'Top',
                                fragrance: widget.combo.top,
                                emoji: '✨',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Why it works
                        _SectionCard(
                          icon: Icons.psychology_alt_rounded,
                          title: 'Why it works',
                          child: Text(
                            widget.combo.description,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              height: 1.6,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // When to wear
                        _SectionCard(
                          icon: Icons.access_time_rounded,
                          title: 'When to wear',
                          child: Text(
                            widget.combo.whenToWear,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              height: 1.6,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Layering tips
                        _SectionCard(
                          icon: Icons.tips_and_updates_rounded,
                          title: 'Pro Layering Tips',
                          child: Text(
                            widget.combo.layeringTips,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              height: 1.6,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Moods
                        Text('Vibes', style: theme.textTheme.titleMedium),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: widget.combo.moods.map((m) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    theme.colorScheme.primary.withValues(
                                      alpha: 0.15,
                                    ),
                                    theme.colorScheme.tertiary.withValues(
                                      alpha: 0.1,
                                    ),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: theme.colorScheme.primary.withValues(
                                    alpha: 0.3,
                                  ),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                _moodLabel(m),
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _shareCombo(Combo combo) {
    final text = StringBuffer()
      ..writeln('Signature Scent Blend: ${combo.title}')
      ..writeln('${combo.base.label} + ${combo.top.label}')
      ..writeln('Season: ${combo.season.name}')
      ..writeln('Why it works: ${combo.description}')
      ..writeln('When to wear: ${combo.whenToWear}')
      ..writeln('Layering tips: ${combo.layeringTips}');
    // ignore: deprecated_member_use
    Share.share(text.toString());
  }

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

class _EnhancedHeroCard extends StatelessWidget {
  final Combo combo;
  const _EnhancedHeroCard({required this.combo});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.2),
            theme.colorScheme.tertiary.withValues(alpha: 0.15),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.2),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: theme.brightness == Brightness.light
                  ? Colors.white.withValues(alpha: 0.7)
                  : Colors.black.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      _getComboEmoji(combo),
                      style: const TextStyle(fontSize: 56),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _SeasonPill(season: combo.season),
                          const SizedBox(height: 8),
                          Text(
                            combo.title,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getComboEmoji(Combo combo) {
    if (combo.moods.contains(Mood.romantic)) return '💕';
    if (combo.moods.contains(Mood.luxury)) return '✨';
    if (combo.moods.contains(Mood.mysterious)) return '🌙';
    if (combo.moods.contains(Mood.confident)) return '⚡';
    if (combo.moods.contains(Mood.chill)) return '🌊';
    if (combo.moods.contains(Mood.adventurous)) return '🔥';
    if (combo.moods.contains(Mood.regal)) return '👑';
    if (combo.moods.contains(Mood.calm)) return '🌌';
    return '🌸';
  }
}

class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;
  const _SectionCard({
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? Colors.white.withValues(alpha: 0.7)
            : Colors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: theme.colorScheme.primary, size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _BlendLayer extends StatelessWidget {
  final String label;
  final Fragrance fragrance;
  final String emoji;
  const _BlendLayer({
    required this.label,
    required this.fragrance,
    required this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.1),
            theme.colorScheme.secondary.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 32)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  fragrance.label,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (fragrance.notes.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 4,
                    children: fragrance.notes.take(3).map((note) {
                      return Text(
                        note,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SeasonPill extends StatelessWidget {
  final Season season;
  const _SeasonPill({required this.season});

  @override
  Widget build(BuildContext context) {
    final bg = season == Season.summer
        ? Colors.teal.shade100
        : Colors.blueGrey.shade700;
    final fg = season == Season.summer
        ? Colors.teal.shade900
        : Colors.blueGrey.shade50;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: [
          Icon(
            season == Season.summer ? Icons.wb_sunny : Icons.ac_unit,
            size: 16,
            color: fg,
          ),
          const SizedBox(width: 6),
          Text(
            season.name,
            style: TextStyle(color: fg, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
