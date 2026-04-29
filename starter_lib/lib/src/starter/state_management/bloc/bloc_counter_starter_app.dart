import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_lib/src/theme/app_theme.dart';

class BlocCounterStarterApp extends StatelessWidget {
  const BlocCounterStarterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<_CounterCubit>(
      create: (_) => _CounterCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bloc Starter',
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        home: const _BlocCounterPage(),
      ),
    );
  }
}

class _CounterCubit extends Cubit<int> {
  _CounterCubit() : super(0);

  void increment() {
    emit(state + 1);
  }
}

class _BlocCounterPage extends StatelessWidget {
  const _BlocCounterPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bloc Setup')),
      body: Center(
        child: BlocBuilder<_CounterCubit, int>(
          builder: (BuildContext context, int counter) {
            return Text(
              'Count: $counter',
              style: Theme.of(context).textTheme.headlineMedium,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: context.read<_CounterCubit>().increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
