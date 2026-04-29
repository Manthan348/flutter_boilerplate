import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter_lib/src/core/constants/app_sizes.dart';
import 'package:starter_lib/src/core/models/dynamic_dropdown_option.dart';
import 'package:starter_lib/src/core/models/dynamic_input_field_config.dart';
import 'package:starter_lib/src/core/models/dynamic_step_item.dart';
import 'package:starter_lib/src/features/home/controller/home_controller.dart';
import 'package:starter_lib/src/services/image/app_image_cache_service.dart';
import 'package:starter_lib/src/widgets/bottom_sheets/app_bottom_sheets.dart';
import 'package:starter_lib/src/widgets/buttons/app_primary_button.dart';
import 'package:starter_lib/src/widgets/cards/app_section_card.dart';
import 'package:starter_lib/src/widgets/forms/dynamic_dropdown_field.dart';
import 'package:starter_lib/src/widgets/forms/dynamic_input_field.dart';
import 'package:starter_lib/src/widgets/inputs/app_text_field.dart';
import 'package:starter_lib/src/widgets/lists/paginated_list_view.dart';
import 'package:starter_lib/src/widgets/media/app_fullscreen_image_view.dart';
import 'package:starter_lib/src/widgets/search/app_search_bar.dart';
import 'package:starter_lib/src/widgets/states/app_empty_state.dart';
import 'package:starter_lib/src/widgets/steps/dynamic_step_bar.dart';
import 'package:starter_lib/src/widgets/forms/app_date_time_picker_field.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSizes.pagePadding),
      children: [
        Text('Starter Home', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: AppSizes.itemSpacing),
        Text(
          'Reusable UI blocks for forms, cards, buttons, and states.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSizes.sectionSpacing),
        AppSectionCard(
          title: 'Quick Form',
          subtitle: 'Drop-in field style for fast screen setup.',
          child: const AppTextField(
            label: 'Search or enter a value',
            hint: 'Type here...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        const SizedBox(height: AppSizes.itemSpacing),
        AppSectionCard(
          title: 'Actions',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  'Counter: ${controller.counter.value}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(height: AppSizes.itemSpacing),
              AppPrimaryButton(
                label: 'Increment',
                onPressed: controller.increment,
              ),
              const SizedBox(height: AppSizes.itemSpacing),
              AppSecondaryButton(
                label: 'Open Reusable Bottom Sheet',
                onPressed: () {
                  AppBottomSheets.show<void>(
                    context,
                    title: 'Quick Actions',
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppPrimaryButton(
                          label: 'Create New Item',
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icons.add,
                        ),
                        const SizedBox(height: AppSizes.itemSpacing),
                        AppSecondaryButton(
                          label: 'Cancel',
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.itemSpacing),
        const AppSectionCard(
          title: 'Empty State Preview',
          child: AppEmptyState(
            title: 'No items yet',
            message: 'Use this widget for first-time or filtered-empty views.',
          ),
        ),
        const SizedBox(height: AppSizes.itemSpacing),
        const _DynamicComponentsDemo(),
        const SizedBox(height: AppSizes.itemSpacing),
        const _AdvancedReusableDemo(),
      ],
    );
  }
}

class _DynamicComponentsDemo extends StatefulWidget {
  const _DynamicComponentsDemo();

  @override
  State<_DynamicComponentsDemo> createState() => _DynamicComponentsDemoState();
}

class _DynamicComponentsDemoState extends State<_DynamicComponentsDemo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final List<DynamicStepItem> _steps = const <DynamicStepItem>[
    DynamicStepItem(title: 'Account'),
    DynamicStepItem(title: 'Profile'),
    DynamicStepItem(title: 'Review'),
  ];
  final List<DynamicDropdownOption<String>> _categories =
      const <DynamicDropdownOption<String>>[
        DynamicDropdownOption<String>(label: 'Home Services', value: 'home'),
        DynamicDropdownOption<String>(label: 'Automotive', value: 'auto'),
        DynamicDropdownOption<String>(label: 'Beauty', value: 'beauty'),
      ];
  final List<String> _demoNetworkImages = const <String>[
    'https://images.unsplash.com/photo-1497366216548-37526070297c?w=800',
    'https://images.unsplash.com/photo-1521791136064-7986c2920216?w=800',
    'https://images.unsplash.com/photo-1497215842964-222b430dc094?w=800',
  ];

  String? _selectedCategory;
  int _currentStep = 0;
  bool _isPrecached = false;

  @override
  void initState() {
    super.initState();
    AppImageCacheService.configureImageCache(
      maximumSize: 200,
      maximumSizeBytes: 80 * 1024 * 1024,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _precacheImages() async {
    await AppImageCacheService.precacheNetworkImages(
      context,
      _demoNetworkImages,
    );
    if (!mounted) {
      return;
    }

    setState(() {
      _isPrecached = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Demo images preloaded in cache')),
    );
  }

  void _nextStep() {
    setState(() {
      if (_currentStep < _steps.length - 1) {
        _currentStep++;
      }
    });
  }

  void _previousStep() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      title: 'Dynamic Components Demo',
      subtitle: 'Input fields, dropdown, step bar, and image precache.',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DynamicStepBar(steps: _steps, currentStep: _currentStep),
            const SizedBox(height: AppSizes.itemSpacing),
            Row(
              children: [
                Expanded(
                  child: AppSecondaryButton(
                    label: 'Back',
                    onPressed: _previousStep,
                  ),
                ),
                const SizedBox(width: AppSizes.itemSpacing),
                Expanded(
                  child: AppPrimaryButton(label: 'Next', onPressed: _nextStep),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.sectionSpacing),
            DynamicInputField(
              config: const DynamicInputFieldConfig(
                id: 'full_name',
                label: 'Full Name',
                hint: 'Enter your full name',
                type: DynamicInputType.text,
                required: true,
                textInputAction: TextInputAction.next,
                prefixIcon: Icon(Icons.person_outline),
              ),
              controller: _nameController,
            ),
            const SizedBox(height: AppSizes.itemSpacing),
            DynamicInputField(
              config: const DynamicInputFieldConfig(
                id: 'email',
                label: 'Email',
                hint: 'Enter your email',
                type: DynamicInputType.email,
                required: true,
                textInputAction: TextInputAction.done,
                prefixIcon: Icon(Icons.email_outlined),
              ),
              controller: _emailController,
              validator: (String? value) {
                if (value == null || !value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: AppSizes.itemSpacing),
            DynamicDropdownField<String>(
              label: 'Business Category',
              hint: 'Select a category',
              options: _categories,
              value: _selectedCategory,
              required: true,
              prefixIcon: const Icon(Icons.category_outlined),
              onChanged: (String? value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
            const SizedBox(height: AppSizes.itemSpacing),
            AppPrimaryButton(
              label: 'Validate Form',
              onPressed: () {
                final bool isValid = _formKey.currentState?.validate() ?? false;
                final String msg = isValid
                    ? 'Dynamic form is valid'
                    : 'Please fix validation errors';
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(msg)));
              },
            ),
            const SizedBox(height: AppSizes.sectionSpacing),
            Row(
              children: [
                Expanded(
                  child: AppPrimaryButton(
                    label: _isPrecached ? 'Images Cached' : 'Precache Images',
                    onPressed: _isPrecached ? null : _precacheImages,
                    icon: _isPrecached
                        ? Icons.check_circle_outline
                        : Icons.download,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.itemSpacing),
            SizedBox(
              height: 96,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _demoNetworkImages.length,
                separatorBuilder: (_, int _) =>
                    const SizedBox(width: AppSizes.itemSpacing),
                itemBuilder: (BuildContext context, int index) {
                  final String imageUrl = _demoNetworkImages[index];
                  final String heroTag = 'dynamic-demo-image-$index';

                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          AppFullscreenImageView.showNetwork(
                            context,
                            imageUrl: imageUrl,
                            heroTag: heroTag,
                          );
                        },
                        child: Hero(
                          tag: heroTag,
                          child: Image.network(
                            imageUrl,
                            width: 132,
                            height: 96,
                            fit: BoxFit.cover,
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
      ),
    );
  }
}

class _AdvancedReusableDemo extends StatefulWidget {
  const _AdvancedReusableDemo();

  @override
  State<_AdvancedReusableDemo> createState() => _AdvancedReusableDemoState();
}

class _AdvancedReusableDemoState extends State<_AdvancedReusableDemo> {
  static const int _pageSize = 8;
  final List<String> _catalogItems = List<String>.generate(
    36,
    (int index) => 'Service Item ${index + 1}',
  );

  String _query = '';
  int _loadedCount = 0;
  bool _isLoading = true;
  bool _isLoadingMore = false;
  String? _errorMessage;
  DateTime? _selectedCupertinoDateTime;
  DateTimeRange? _selectedDateRange;

  List<String> get _filteredItems {
    if (_query.trim().isEmpty) {
      return _catalogItems;
    }

    final String q = _query.toLowerCase();
    return _catalogItems
        .where((String item) => item.toLowerCase().contains(q))
        .toList(growable: false);
  }

  List<String> get _visibleItems {
    final List<String> filtered = _filteredItems;
    final int safeCount = _loadedCount.clamp(0, filtered.length);
    return filtered.take(safeCount).toList(growable: false);
  }

  bool get _hasMore => _visibleItems.length < _filteredItems.length;

  @override
  void initState() {
    super.initState();
    _loadInitial();
  }

  Future<void> _loadInitial() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future<void>.delayed(const Duration(milliseconds: 350));
    if (!mounted) {
      return;
    }

    setState(() {
      _loadedCount = _filteredItems.length < _pageSize
          ? _filteredItems.length
          : _pageSize;
      _isLoading = false;
    });
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore || !_hasMore) {
      return;
    }

    setState(() {
      _isLoadingMore = true;
    });

    await Future<void>.delayed(const Duration(milliseconds: 450));
    if (!mounted) {
      return;
    }

    setState(() {
      _loadedCount = (_loadedCount + _pageSize).clamp(0, _filteredItems.length);
      _isLoadingMore = false;
    });
  }

  void _onSearchDebounced(String value) {
    setState(() {
      _query = value;
    });
    _loadInitial();
  }

  @override
  Widget build(BuildContext context) {
    return AppSectionCard(
      title: 'Advanced Reusable Demo',
      subtitle: 'Search bar, paginated list, and date pickers.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSearchBar(
            hintText: 'Search services...',
            onDebouncedChanged: _onSearchDebounced,
          ),
          const SizedBox(height: AppSizes.itemSpacing),
          AppDateTimePickerField(
            label: 'iOS Style Date & Time',
            hint: 'Open Cupertino bottom sheet',
            mode: AppDateTimePickerMode.dateTime,
            pickerStyle: AppDateTimePickerStyle.cupertinoBottomSheet,
            onDateTimeChanged: (DateTime? value) {
              setState(() {
                _selectedCupertinoDateTime = value;
              });
            },
          ),
          if (_selectedCupertinoDateTime != null) ...[
            const SizedBox(height: 8),
            Text(
              'Cupertino: ${_selectedCupertinoDateTime!.toLocal()}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
          const SizedBox(height: AppSizes.itemSpacing),
          AppDateTimePickerField(
            label: 'Preferred Service Window',
            hint: 'Select a date range',
            mode: AppDateTimePickerMode.dateRange,
            onDateRangeChanged: (DateTimeRange? value) {
              setState(() {
                _selectedDateRange = value;
              });
            },
          ),
          if (_selectedDateRange != null) ...[
            const SizedBox(height: 8),
            Text(
              'Selected: ${_selectedDateRange!.start.toLocal()} - ${_selectedDateRange!.end.toLocal()}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
          const SizedBox(height: AppSizes.itemSpacing),
          SizedBox(
            height: 260,
            child: PaginatedListView<String>(
              items: _visibleItems,
              isLoading: _isLoading,
              isLoadingMore: _isLoadingMore,
              hasMore: _hasMore,
              errorMessage: _errorMessage,
              emptyTitle: 'No services found',
              emptyMessage: 'Try another search keyword.',
              onRefresh: _loadInitial,
              onLoadMore: _loadMore,
              onRetry: _loadInitial,
              separatorBuilder: (_, int _) => const Divider(height: 1),
              itemBuilder: (BuildContext context, String item, int index) {
                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.design_services_outlined, size: 20),
                  title: Text(item),
                  subtitle: Text('Reusable list row #${index + 1}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
