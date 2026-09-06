import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:acuteflow/features/decision_tree/presentation/screens/home_screen.dart';

import 'core/di/injection_container.dart' as di;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await di.initDependencyInjection();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const AcuteFlowApp());
}

class AcuteFlowApp extends StatefulWidget {
  const AcuteFlowApp({super.key});

  @override
  State<AcuteFlowApp> createState() => _AcuteFlowAppState();
}

class _AcuteFlowAppState extends State<AcuteFlowApp> {
  @override
  void initState() {
    super.initState();
    splashInitialization();
  }

  void splashInitialization() async {
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AcuteFlow',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
