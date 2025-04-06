// lib/controllers/bottom_nav_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    debugPrint("Selected index: $index");
    selectedIndex.value = index;
  }
}
