import 'package:flutter/material.dart';
import 'package:starter_lib/src/core/constants/app_sizes.dart';
import 'package:starter_lib/src/widgets/cards/app_section_card.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSizes.pagePadding),
      children: [
        Text('Explore', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: AppSizes.itemSpacing),
        Text(
          'Use reusable cards for discovery sections in new projects.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSizes.sectionSpacing),
        const AppSectionCard(
          title: 'Popular Near You',
          subtitle: 'Reusable card with title/subtitle content.',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ExploreInfoRow(
                icon: Icons.local_fire_department_outlined,
                text: 'Trending services in your city',
              ),
              SizedBox(height: AppSizes.itemSpacing),
              _ExploreInfoRow(
                icon: Icons.delivery_dining_outlined,
                text: 'Fastest providers available now',
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.itemSpacing),
        const AppSectionCard(
          title: 'Try Search',
          child: _ExploreInfoRow(
            icon: Icons.search,
            text: 'Attach your search widget and filters in this card.',
          ),
        ),
      ],
    );
  }
}

class _ExploreInfoRow extends StatelessWidget {
  const _ExploreInfoRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
