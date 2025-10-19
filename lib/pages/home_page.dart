import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/models.dart';
import '../data/seed_data.dart';
import 'combo_detail_page.dart';

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
      final okMood = _selectedMoods.isEmpty || c.moods.any((m) => _selectedMoods.contains(m));
      return okSeason && okMood;
    }).toList();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Signature Scent Wardrobe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {},
            tooltip: 'Search',
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              _season == Season.summer
                  ? 'https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=800'
                  : 'https://images.unsplash.com/photo-1491002052546-bf38f186af56?w=800',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: _season == Season.summer ? const Color(0xFFFFE8D6) : const Color(0xFFE8F4F8),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: _season == Season.summer
                      ? [
                          Colors.orange.withValues(alpha: 0.3),
                          Colors.white.withValues(alpha: 0.85),
                          Colors.white.withValues(alpha: 0.95),
                        ]
                      : [
                          Colors.black.withValues(alpha: 0.5),
                          Colors.black.withValues(alpha: 0.75),
                          Colors.black.withValues(alpha: 0.85),
                        ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _season == Season.summer ? Colors.white : const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _season == Season.summer 
                          ? theme.dividerColor.withValues(alpha: 0.3)
                          : Colors.white.withValues(alpha: 0.15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _season == Season.summer
                            ? Colors.black.withValues(alpha: 0.08)
                            : Colors.black.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: _SeasonButton(
                          label: 'Summer',
                          icon: Icons.wb_sunny_outlined,
                          isSelected: _season == Season.summer,
                          isDarkTheme: _season == Season.winter,
                          onTap: () => setState(() => _season = Season.summer),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _SeasonButton(
                          label: 'Winter',
                          icon: Icons.ac_unit_outlined,
                          isSelected: _season == Season.winter,
                          isDarkTheme: _season == Season.winter,
                          onTap: () => setState(() => _season = Season.winter),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.2, end: 0),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  height: 56,
                  decoration: BoxDecoration(
                    color: _season == Season.summer ? Colors.white : const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _season == Season.summer
                          ? theme.dividerColor.withValues(alpha: 0.3)
                          : Colors.white.withValues(alpha: 0.15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _season == Season.summer
                            ? Colors.black.withValues(alpha: 0.08)
                            : Colors.black.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: Mood.values.map((mood) {
                      final isSelected = _selectedMoods.contains(mood);
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(_moodText(mood)),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedMoods.add(mood);
                              } else {
                                _selectedMoods.remove(mood);
                              }
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ).animate().fadeIn(delay: 100.ms, duration: 300.ms),
                const SizedBox(height: 8),
                Expanded(
                  child: filtered.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.sentiment_dissatisfied_outlined, size: 64),
                              const SizedBox(height: 16),
                              Text('No combinations found', style: theme.textTheme.titleMedium),
                            ],
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            return _ComboCard(
                              combo: filtered[index],
                              isDarkTheme: _season == Season.winter,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ComboDetailPage(combo: filtered[index]),
                                  ),
                                );
                              },
                            ).animate().fadeIn(
                              delay: (50 * index).ms,
                              duration: 400.ms,
                            ).slideY(begin: 0.1, end: 0);
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _moodText(Mood mood) {
    return mood.toString().split('.').last[0].toUpperCase() +
           mood.toString().split('.').last.substring(1);
  }
}

class _SeasonButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final bool isDarkTheme;
  final VoidCallback onTap;

  const _SeasonButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.isDarkTheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonColor = isSelected 
        ? theme.colorScheme.primary 
        : (isDarkTheme ? const Color(0xFF2A2A2A) : Colors.white);
    final textColor = isSelected 
        ? theme.colorScheme.onPrimary 
        : (isDarkTheme ? Colors.white : theme.textTheme.bodyMedium?.color);
    
    return Material(
      color: buttonColor,
      borderRadius: BorderRadius.circular(12),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected 
                  ? theme.colorScheme.primary 
                  : (isDarkTheme 
                      ? Colors.white.withValues(alpha: 0.15) 
                      : theme.dividerColor.withValues(alpha: 0.3)),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: textColor),
              const SizedBox(width: 8),
              Text(
                label,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ComboCard extends StatelessWidget {
  final Combo combo;
  final bool isDarkTheme;
  final VoidCallback? onTap;

  const _ComboCard({
    required this.combo, 
    required this.isDarkTheme,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = isDarkTheme ? const Color(0xFF1A1A1A) : Colors.white;
    final textColor = isDarkTheme ? Colors.white : theme.textTheme.bodyMedium?.color;
    
    return Material(
      color: cardColor,
      borderRadius: BorderRadius.circular(12),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDarkTheme 
                  ? Colors.white.withValues(alpha: 0.15) 
                  : theme.dividerColor.withValues(alpha: 0.3), 
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: isDarkTheme ? 0.15 : 0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(child: Text(combo.emoji, style: const TextStyle(fontSize: 40))),
              ),
              const SizedBox(height: 12),
              Text(
                combo.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600, 
                  height: 1.2,
                  color: textColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                combo.base.name + ' +',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: textColor?.withValues(alpha: 0.7),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                combo.top.name,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              if (combo.moods.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: isDarkTheme ? 0.2 : 0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    combo.moods.first.toString().split('.').last,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: isDarkTheme ? Colors.white : theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
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
