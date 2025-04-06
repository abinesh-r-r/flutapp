import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'list_variables.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class ListController extends GetxController {
  final vars = ListVariables();
  final ScrollController scrollController = ScrollController();
  var currentPage = 1.obs; // Track the current page
  var isLoadingNextPage = false.obs; // Track loading state for next page
  final currentTime = ''.obs;
  late Timer timer;
  var isDataFetched = false.obs; 

  @override
  void onInit() {
    super.onInit();
    debugPrint('ListController initialized');
    fetchPosts(); // Fetch initial posts
    scrollController.addListener(_scrollListener); // Add listener for infinite scroll
    updateTime(); // Set initial time
    timer = Timer.periodic(const Duration(seconds: 1), (_) => updateTime());
  }

  void updateTime() {
    final now = DateTime.now();
    currentTime.value = DateFormat('hh:mm:ss a').format(now);// e.g., 10:00 PM
  }

  // Fetch posts with pagination
  void fetchPosts() async {
    try {
      vars.isLoading.value = true;

      // Fetch data for the current page
      final response = await GetConnect().get(
          'https://jsonplaceholder.typicode.com/posts?_page=$currentPage&_limit=10');

      if (response.statusCode == 200) {
        final result = response.body as List;
        isDataFetched.value = true;
        if (currentPage.value == 1) {
          // If it's the first page, replace the post list
          vars.postList.value = result.map((e) => Post.fromJson(e)).toList();
        } else {
          // Append to the existing list for subsequent pages
          vars.postList.addAll(result.map((e) => Post.fromJson(e)).toList());
        }
      }
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      vars.isLoading.value = false;
    }
  }

  // Handle scroll events and load more data when reaching the bottom
  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isLoadingNextPage.value) {
      // Load next page if the user reaches the bottom of the list
      isLoadingNextPage.value = true;
      currentPage.value++;
      fetchPosts();
      isLoadingNextPage.value = false;
    }
  }

  @override
  void onClose() {
    timer.cancel();
    scrollController.removeListener(_scrollListener); // Remove listener when the controller is disposed
    scrollController.dispose();
    super.onClose();
  }
}
