import 'package:designhub/main_app.dart';
import 'package:designhub/shared/controller/controller.dart';
import 'package:flutter/material.dart';

void main() {
  // init global controller to handle mock_dbs in the app
  Controller controller = Controller();
  runApp(const MainApp());
}
