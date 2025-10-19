import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';
import '../models/models.dart';
import '../data/seed_data.dart';

class FragranceDetailPage extends StatefulWidget {
  final Fragrance fragrance;

  const FragranceDetailPage({super.key, required this.fragrance});

  @override
  State<FragranceDetailPage> createState() => _FragranceDetailPageState();
}

class _FragranceDetailPageState extends State<FragranceDetailPage> {
  bool _isFavorite = false;

  List<Combo> get _compatibleCombos {
    return allCombos
        .where(
          (combo) =>
              combo.base.name == widget.fragrance.name ||
              combo.top.name == widget.fragrance.name,
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: theme.scaffoldBackgroundColor.withValues(alpha: 0.7),
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: _isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              HapticFeedback.mediumImpact();
              Vibration.vibrate(duration: 50);
              setState(() => _isFavorite = !_isFavorite);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            _buildHeroSection(theme, isDark),
            const SizedBox(height: 24),
            _buildInfoSection(theme),
            const SizedBox(height: 16),
            _buildNotesSection(theme),
            const SizedBox(height: 16),
            _buildCompatibleCombosSection(theme, isDark),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(ThemeData theme, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Text(
              widget.fragrance.isBase ? '🍯' : '✨',
              style: const TextStyle(fontSize: 80),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: widget.fragrance.isBase
                    ? const Color(0xFFFFF3E0)
                    : const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                widget.fragrance.isBase ? 'BASE FRAGRANCE' : 'TOP FRAGRANCE',
                style: TextStyle(
                  color: widget.fragrance.isBase
                      ? const Color(0xFFE65100)
                      : const Color(0xFF1565C0),
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.fragrance.brand,
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.fragrance.name,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Color(0xFF1A1D2E),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: const Color(0xFF4B5563),
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Text(
                  'About',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Color(0xFF1A1D2E),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _InfoRow(
              label: 'Type',
              value: widget.fragrance.type.name,
              icon: Icons.category_rounded,
            ),
            _InfoRow(
              label: 'Concentration',
              value: widget.fragrance.type.concentration,
              icon: Icons.water_drop_rounded,
            ),
            _InfoRow(
              label: 'Longevity',
              value: widget.fragrance.type.longevity,
              icon: Icons.schedule_rounded,
            ),
            _InfoRow(
              label: 'Projection',
              value: widget.fragrance.type.projection,
              icon: Icons.radio_button_checked_rounded,
            ),
            _InfoRow(
              label: 'Brand',
              value: widget.fragrance.brand,
              icon: Icons.business_rounded,
            ),
            _InfoRow(
              label: 'Layer Type',
              value: widget.fragrance.isBase ? 'Base Layer' : 'Top Layer',
              icon: Icons.layers_rounded,
            ),
            _InfoRow(
              label: 'Combinations',
              value: '${_compatibleCombos.length} available',
              icon: Icons.auto_awesome_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesSection(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.spa_rounded,
                  color: const Color(0xFF4B5563),
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Scent Notes',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Color(0xFF1A1D2E),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.fragrance.notes
                  .map(
                    (note) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        note,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Color(0xFF374151),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompatibleCombosSection(ThemeData theme, bool isDark) {
    if (_compatibleCombos.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                color: const Color(0xFF4B5563),
                size: 24,
              ),
              const SizedBox(width: 12),
              const Text(
                'Works Great With',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xFF1A1D2E),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _compatibleCombos.length,
            itemBuilder: (context, index) {
              final combo = _compatibleCombos[index];
              return _ComboChip(combo: combo, theme: theme, isDark: isDark);
            },
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: const Color(0xFF6B7280)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF374151),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ComboChip extends StatelessWidget {
  final Combo combo;
  final ThemeData theme;
  final bool isDark;

  const _ComboChip({
    required this.combo,
    required this.theme,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          Vibration.vibrate(duration: 30);
          // Could navigate to combo detail
        },
        child: Container(
          width: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(combo.emoji, style: const TextStyle(fontSize: 32)),
              const SizedBox(height: 8),
              Text(
                combo.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Color(0xFF1A1D2E),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: combo.season == Season.summer
                      ? const Color(0xFFFFF3E0)
                      : const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  combo.season == Season.summer ? 'Summer' : 'Winter',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: combo.season == Season.summer
                        ? const Color(0xFFE65100)
                        : const Color(0xFF1565C0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
