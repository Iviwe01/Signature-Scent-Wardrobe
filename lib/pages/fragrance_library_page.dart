import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/models.dart';
import '../data/seed_data.dart';
import 'fragrance_detail_page.dart';

class FragranceLibraryPage extends StatefulWidget {
  const FragranceLibraryPage({super.key});

  @override
  State<FragranceLibraryPage> createState() => _FragranceLibraryPageState();
}

class _FragranceLibraryPageState extends State<FragranceLibraryPage> {
  String _selectedCategory = 'All';
  String _searchQuery = '';

  List<Fragrance> get _allFragrances {
    final Set<Fragrance> uniqueFragrances = {};
    for (var combo in allCombos) {
      uniqueFragrances.add(combo.base);
      uniqueFragrances.add(combo.top);
    }
    return uniqueFragrances.toList();
  }

  List<Fragrance> get _baseFragrances => _allFragrances.where((f) => f.isBase).toList();
  List<Fragrance> get _topFragrances => _allFragrances.where((f) => !f.isBase).toList();

  List<Fragrance> get _filteredFragrances {
    List<Fragrance> fragrances;
    switch (_selectedCategory) {
      case 'Base':
        fragrances = _baseFragrances;
        break;
      case 'Top':
        fragrances = _topFragrances;
        break;
      default:
        fragrances = _allFragrances;
    }
    if (_searchQuery.isEmpty) return fragrances;
    return fragrances.where((f) =>
        f.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        f.brand.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        f.notes.any((n) => n.toLowerCase().contains(_searchQuery.toLowerCase()))).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('My Collection', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: theme.colorScheme.primary),
            onPressed: () => _showCollectionStats(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search fragrances...',
                prefixIcon: Icon(Icons.search, color: theme.colorScheme.primary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: theme.dividerColor.withValues(alpha: 0.3)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: theme.dividerColor.withValues(alpha: 0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
                ),
                filled: true,
                fillColor: const Color(0xFFF5F7FA),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.1, end: 0),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Row(
              children: [
                _buildCategoryChip(theme, 'All'),
                const SizedBox(width: 10),
                _buildCategoryChip(theme, 'Base'),
                const SizedBox(width: 10),
                _buildCategoryChip(theme, 'Top'),
              ],
            ),
          ).animate().fadeIn(delay: 100.ms, duration: 300.ms),
          Expanded(
            child: _filteredFragrances.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 80, color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.3)),
                        const SizedBox(height: 20),
                        Text('No fragrances found', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Text('Try adjusting your search or filters', style: theme.textTheme.bodyMedium?.copyWith(color: theme.textTheme.bodySmall?.color)),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),
                    itemCount: _filteredFragrances.length,
                    itemBuilder: (context, index) {
                      final fragrance = _filteredFragrances[index];
                      return Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        elevation: 0,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FragranceDetailPage(fragrance: fragrance),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: theme.dividerColor.withValues(alpha: 0.2), width: 1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        theme.colorScheme.primary.withValues(alpha: 0.1),
                                        theme.colorScheme.primary.withValues(alpha: 0.05),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      fragrance.name[0],
                                      style: theme.textTheme.displayMedium?.copyWith(
                                        color: theme.colorScheme.primary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  fragrance.name,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    height: 1.2,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  fragrance.brand,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary.withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    fragrance.isBase ? 'Base' : 'Top',
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ).animate().fadeIn(
                        delay: (50 * index).ms,
                        duration: 400.ms,
                      ).scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1));
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(ThemeData theme, String category) {
    final isSelected = _selectedCategory == category;
    return Expanded(
      child: Material(
        color: isSelected ? theme.colorScheme.primary : Colors.white,
        borderRadius: BorderRadius.circular(12),
        elevation: 0,
        child: InkWell(
          onTap: () => setState(() => _selectedCategory = category),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? theme.colorScheme.primary : theme.dividerColor.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            child: Center(
              child: Text(
                category,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: isSelected ? Colors.white : theme.textTheme.bodyMedium?.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showCollectionStats(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.insights, color: theme.colorScheme.primary, size: 24),
            ),
            const SizedBox(width: 12),
            const Text('Collection Stats'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildStatRow(theme, Icons.inventory_2, 'Total Fragrances', _allFragrances.length.toString()),
            const SizedBox(height: 12),
            _buildStatRow(theme, Icons.layers, 'Base Fragrances', _baseFragrances.length.toString()),
            const SizedBox(height: 12),
            _buildStatRow(theme, Icons.auto_awesome, 'Top Fragrances', _topFragrances.length.toString()),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(ThemeData theme, IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: theme.textTheme.bodyMedium),
          ),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
