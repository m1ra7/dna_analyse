import 'package:flutter/material.dart';

class MessageProvider extends ChangeNotifier {
  String? _pendingMessage;

  String? get pendingMessage => _pendingMessage;

  void setPendingMessage(String message) {
    _pendingMessage = message;
    notifyListeners();
  }

  void clearPendingMessage() {
    _pendingMessage = null;
    notifyListeners();
  }
}
