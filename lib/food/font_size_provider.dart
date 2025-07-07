import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontSizeProvider extends ChangeNotifier {
  double _fontSize = 16.0;

  double get fontSize => _fontSize;

  FontSizeProvider() {
    _loadFontSize();
  }

  Future<void> _loadFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    _fontSize = prefs.getDouble('loremFontSize') ?? 16.0;
    notifyListeners();
  }

  Future<void> setFontSize(double size) async {
    _fontSize = size.clamp(12.0, 20.0);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('loremFontSize', _fontSize);
    notifyListeners();
  }

  Future<void> resetFontSize() async {
    _fontSize = 16.0;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('loremFontSize', _fontSize);
    notifyListeners();
  }
}