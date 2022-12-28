import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:production_automation_testing/res/theme.dart';


void main() {
  runApp(const ProviderScope(child: AppTheme()));
}

