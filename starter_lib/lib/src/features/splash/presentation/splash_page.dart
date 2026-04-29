import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starter_lib/src/core/constants/app_sizes.dart';
import 'package:starter_lib/src/features/splash/controller/splash_controller.dart';
import 'package:starter_lib/src/widgets/buttons/app_primary_button.dart';
import 'package:starter_lib/src/widgets/scaffolds/app_scaffold.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.pagePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              'Starter Boilerplate',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSizes.itemSpacing),
            Text(
              'Use this as the first screen and replace with your own flow.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
            AppPrimaryButton(
              label: 'Continue',
              onPressed: controller.continueToHome,
            ),
          ],
        ),
      ),
    );
  }
}
