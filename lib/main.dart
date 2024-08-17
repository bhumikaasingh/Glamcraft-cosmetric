import 'package:final_assignment/app/app.dart';
import 'package:final_assignment/core/networking/local/hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await HiveService().init();
  } catch (e, stackTrace) {
    // Handle the error, log it, or show a message
    print('Failed to initialize Hive: $e');
    print(stackTrace);
  }
  
  runApp(const ProviderScope(child: App()));
}
