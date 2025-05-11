import 'package:flutter/material.dart';

abstract class BaseUiProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasError => _error != null && _error!.isNotEmpty;

  void setLoading(bool value) {
    if (_isLoading == value) return;
    _isLoading = value;
    notifyListeners();
  }

  void setError(String? message) {
    _error = message;
    notifyListeners();
  }

  void resetUiState() {
    _isLoading = false;
    _error = null;
    notifyListeners();
  }

  Future<void> runAsync(Future<void> Function() action) async {
    setLoading(true);
    try {
      await action();
      setError(null);
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }
}
