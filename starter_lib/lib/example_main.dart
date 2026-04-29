import 'package:flutter/material.dart';
import 'package:starter_lib/src/starter/state_management/state_management_starter_app.dart';
import 'package:starter_lib/src/starter/state_management/state_management_type.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Change this one value based on your requirement.
  const StateManagementType stateManagement = StateManagementType.getx;

  runApp(StateManagementStarterApp.build(stateManagement));
}
