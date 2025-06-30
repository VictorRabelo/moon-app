import 'package:flutter/material.dart';
import '../models/moon_data.dart';
import '../services/moon_service.dart';

class MoonViewModel extends ChangeNotifier {
  final MoonService _service;

  MoonData? _data;
  bool _loading = false;
  String? _error;

  MoonData? get data => _data;
  bool get isLoading => _loading;
  String? get error => _error;

  MoonViewModel(this._service);

  Future<void> fetchMoon() async {
    _loading = true;
    _error = null;
    notifyListeners();
    try {
      _data = await _service.fetchMoonData();
    } catch (e) {
      _error = e.toString();
    }
    _loading = false;
    notifyListeners();
  }
}
