import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_lib/src/theme/app_theme.dart';

class RiverpodCounterStarterApp extends StatelessWidget {
  const RiverpodCounterStarterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(child: _RiverpodRootApp());
  }
}

class _RiverpodRootApp extends StatelessWidget {
  const _RiverpodRootApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Riverpod Starter',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: const _RiverpodCounterPage(),
    );
  }
}

class _RiverpodCounterNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void increment() {
    state++;
  }
}

final NotifierProvider<_RiverpodCounterNotifier, int> _counterProvider =
    NotifierProvider<_RiverpodCounterNotifier, int>(
      _RiverpodCounterNotifier.new,
    );

class _RiverpodCounterPage extends ConsumerWidget {
  const _RiverpodCounterPage();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int counter = ref.watch(_counterProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod Setup')),
      body: Center(
        child: Text(
          'Count: $counter',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(_counterProvider.notifier).increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
