import 'package:flutter/widgets.dart';
import 'package:starter_lib/src/starter/state_management/bloc/bloc_counter_starter_app.dart';
import 'package:starter_lib/src/starter/state_management/getx/getx_counter_starter_app.dart';
import 'package:starter_lib/src/starter/state_management/provider/provider_counter_starter_app.dart';
import 'package:starter_lib/src/starter/state_management/riverpod/riverpod_counter_starter_app.dart';
import 'package:starter_lib/src/starter/state_management/state_management_type.dart';

class StateManagementStarterApp {
  StateManagementStarterApp._();

  static Widget build(StateManagementType type) {
    switch (type) {
      case StateManagementType.getx:
        return const GetxCounterStarterApp();
      case StateManagementType.provider:
        return const ProviderCounterStarterApp();
      case StateManagementType.riverpod:
        return const RiverpodCounterStarterApp();
      case StateManagementType.bloc:
        return const BlocCounterStarterApp();
    }
  }
}
