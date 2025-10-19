import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
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
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isFavorite ? 'Added to favorites' : 'Removed from favorites'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Combo Details'),
        actions: [
          IconButton(
            icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
            onPressed: _toggleFavorite,
            color: _isFavorite ? Colors.red : null,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareCombo(widget.combo),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.dividerColor, width: 1),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(widget.combo.emoji, style: const TextStyle(fontSize: 64)),
                const SizedBox(height: 12),
                Text(
                  widget.combo.title,
                  style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.combo.season.name.toUpperCase(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildSection(
            theme,
            'The Blend',
            Icons.layers,
            Column(
              children: [
                _buildFragranceRow(theme, 'Base', widget.combo.base),
                const SizedBox(height: 8),
                Icon(Icons.add, color: theme.colorScheme.primary),
                const SizedBox(height: 8),
                _buildFragranceRow(theme, 'Top', widget.combo.top),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildSection(
            theme,
            'Why it works',
            Icons.lightbulb_outline,
            Text(widget.combo.description, style: theme.textTheme.bodyLarge?.copyWith(height: 1.5)),
          ),
          const SizedBox(height: 16),
          _buildSection(
            theme,
            'When to wear',
            Icons.access_time,
            Text(widget.combo.whenToWear, style: theme.textTheme.bodyLarge?.copyWith(height: 1.5)),
          ),
          const SizedBox(height: 16),
          _buildSection(
            theme,
            'Pro Layering Tips',
            Icons.tips_and_updates,
            Text(widget.combo.layeringTips, style: theme.textTheme.bodyLarge?.copyWith(height: 1.5)),
          ),
          const SizedBox(height: 16),
          _buildSection(
            theme,
            'Vibes',
            Icons.mood,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.combo.moods.map((m) {
                return Chip(
                  label: Text(_moodLabel(m)),
                  backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(ThemeData theme, String title, IconData icon, Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor, width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: theme.colorScheme.primary),
              const SizedBox(width: 8),
              Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildFragranceRow(ThemeData theme, String label, Fragrance frag) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.5), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(label, style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(frag.name, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                Text(frag.brand, style: theme.textTheme.bodySmall),
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
    Share.share(text.toString());
  }

  String _moodLabel(Mood m) {
    return m.toString().split('.').last[0].toUpperCase() + m.toString().split('.').last.substring(1);
  }
}
