import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_lib/src/theme/app_theme.dart';

class ProviderCounterStarterApp extends StatelessWidget {
  const ProviderCounterStarterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<_ProviderCounterNotifier>(
      create: (_) => _ProviderCounterNotifier(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Provider Starter',
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        home: const _ProviderCounterPage(),
      ),
    );
  }
}

class _ProviderCounterNotifier extends ChangeNotifier {
  int counter = 0;

  void increment() {
    counter++;
    notifyListeners();
  }
}

class _ProviderCounterPage extends StatelessWidget {
  const _ProviderCounterPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Provider Setup')),
      body: Center(
        child: Consumer<_ProviderCounterNotifier>(
          builder: (BuildContext context, _ProviderCounterNotifier state, _) {
            return Text(
              'Count: ${state.counter}',
              style: Theme.of(context).textTheme.headlineMedium,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: context.read<_ProviderCounterNotifier>().increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
