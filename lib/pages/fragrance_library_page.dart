import 'package:flutter/material.dart';
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
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('My Collection'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showCollectionStats(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search fragrances...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: theme.colorScheme.surface,
              ),
            ),
          ),
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildCategoryChip(theme, 'All'),
                const SizedBox(width: 8),
                _buildCategoryChip(theme, 'Base'),
                const SizedBox(width: 8),
                _buildCategoryChip(theme, 'Top'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _filteredFragrances.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: theme.textTheme.bodySmall?.color),
                        const SizedBox(height: 16),
                        Text('No fragrances found', style: theme.textTheme.titleMedium),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: _filteredFragrances.length,
                    itemBuilder: (context, index) {
                      final fragrance = _filteredFragrances[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Material(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(12),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FragranceDetailPage(fragrance: fragrance),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: theme.dividerColor, width: 1),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        fragrance.name[0],
                                        style: theme.textTheme.headlineSmall?.copyWith(
                                          color: theme.colorScheme.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          fragrance.name,
                                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(fragrance.brand, style: theme.textTheme.bodySmall),
                                        const SizedBox(height: 8),
                                        Wrap(
                                          spacing: 4,
                                          runSpacing: 4,
                                          children: fragrance.notes.take(3).map((note) {
                                            return Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: theme.colorScheme.primary.withValues(alpha: 0.08),
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                note,
                                                style: theme.textTheme.labelSmall?.copyWith(
                                                  color: theme.colorScheme.primary,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(Icons.chevron_right, color: theme.textTheme.bodySmall?.color),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(ThemeData theme, String category) {
    final isSelected = _selectedCategory == category;
    return FilterChip(
      label: Text(category),
      selected: isSelected,
      onSelected: (selected) => setState(() => _selectedCategory = category),
    );
  }

  void _showCollectionStats(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Collection Stats'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Fragrances: ${_allFragrances.length}', style: theme.textTheme.bodyLarge),
            const SizedBox(height: 8),
            Text('Base Fragrances: ${_baseFragrances.length}', style: theme.textTheme.bodyLarge),
            const SizedBox(height: 8),
            Text('Top Fragrances: ${_topFragrances.length}', style: theme.textTheme.bodyLarge),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }
}
