import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter_lib/src/theme/app_theme.dart';

class GetxCounterStarterApp extends StatelessWidget {
  const GetxCounterStarterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GetX Starter',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: const _GetxCounterPage(),
    );
  }
}

class _GetxCounterController extends GetxController {
  final RxInt counter = 0.obs;

  void increment() {
    counter.value++;
  }
}

class _GetxCounterPage extends StatelessWidget {
  const _GetxCounterPage();

  @override
  Widget build(BuildContext context) {
    final _GetxCounterController controller = Get.put(_GetxCounterController());
    return Scaffold(
      appBar: AppBar(title: const Text('GetX Setup')),
      body: Center(
        child: Obx(
          () => Text(
            'Count: ${controller.counter.value}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
