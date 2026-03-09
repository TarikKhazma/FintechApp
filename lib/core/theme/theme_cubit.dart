import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Manages ThemeMode across the app.
/// Persist the user's preference via SecureStorage or SharedPrefs in a
/// real app — this in-memory version resets on cold start.
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  bool get isDark => state == ThemeMode.dark;

  void setLight() => emit(ThemeMode.light);
  void setDark()  => emit(ThemeMode.dark);
  void setSystem() => emit(ThemeMode.system);

  void toggle() {
    emit(state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }
}
