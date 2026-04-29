import 'package:flutter/material.dart';
import 'package:starter_lib/src/core/constants/app_sizes.dart';
import 'package:starter_lib/src/widgets/states/app_empty_state.dart';
import 'package:starter_lib/src/widgets/states/app_error_state.dart';
import 'package:starter_lib/src/widgets/states/app_loading_state.dart';

class PaginatedListView<T> extends StatefulWidget {
  const PaginatedListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.separatorBuilder,
    this.padding,
    this.physics,
    this.scrollController,
    this.onRefresh,
    this.onLoadMore,
    this.hasMore = false,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.errorMessage,
    this.onRetry,
    this.emptyTitle = 'No items found',
    this.emptyMessage,
    this.loadMoreThreshold = 3,
  }) : assert(loadMoreThreshold > 0, 'loadMoreThreshold must be positive');

  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final ScrollController? scrollController;
  final Future<void> Function()? onRefresh;
  final Future<void> Function()? onLoadMore;
  final bool hasMore;
  final bool isLoading;
  final bool isLoadingMore;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final String emptyTitle;
  final String? emptyMessage;
  final int loadMoreThreshold;

  @override
  State<PaginatedListView<T>> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T> extends State<PaginatedListView<T>> {
  bool _loadMoreTriggered = false;

  @override
  void didUpdateWidget(covariant PaginatedListView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isLoadingMore && !widget.isLoadingMore) {
      _loadMoreTriggered = false;
    }

    if (oldWidget.items.length != widget.items.length) {
      _loadMoreTriggered = false;
    }
  }

  Future<void> _tryLoadMoreIfNeeded(int index) async {
    if (widget.onLoadMore == null ||
        !widget.hasMore ||
        widget.isLoadingMore ||
        _loadMoreTriggered) {
      return;
    }

    final int thresholdIndex = widget.items.length - widget.loadMoreThreshold;
    if (index < thresholdIndex) {
      return;
    }

    _loadMoreTriggered = true;
    await widget.onLoadMore!.call();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading && widget.items.isEmpty) {
      return const AppLoadingState(message: 'Loading...');
    }

    if (widget.errorMessage != null && widget.items.isEmpty) {
      return AppErrorState(
        title: 'Something went wrong',
        message: widget.errorMessage,
        onAction: widget.onRetry,
      );
    }

    if (widget.items.isEmpty) {
      return AppEmptyState(
        title: widget.emptyTitle,
        message: widget.emptyMessage,
      );
    }

    final IndexedWidgetBuilder separatorBuilder =
        widget.separatorBuilder ??
        (_, int index) => const SizedBox(height: AppSizes.itemSpacing);

    Widget list = ListView.separated(
      controller: widget.scrollController,
      physics: widget.physics,
      padding: widget.padding,
      itemCount: widget.items.length + (widget.hasMore ? 1 : 0),
      separatorBuilder: separatorBuilder,
      itemBuilder: (BuildContext context, int index) {
        if (index >= widget.items.length) {
          if (widget.isLoadingMore) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSizes.itemSpacing),
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            );
          }

          WidgetsBinding.instance.addPostFrameCallback((_) {
            _tryLoadMoreIfNeeded(index);
          });
          return const SizedBox.shrink();
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _tryLoadMoreIfNeeded(index);
        });
        return widget.itemBuilder(context, widget.items[index], index);
      },
    );

    if (widget.onRefresh != null) {
      list = RefreshIndicator(onRefresh: widget.onRefresh!, child: list);
    }

    return list;
  }
}
