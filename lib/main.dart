// import 'package:flutapp/pages/lazyloadlistpage/list_bindings.dart';
// import 'package:flutapp/pages/lazyloadlistpage/list_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// void main() {
//   runApp(GetMaterialApp(
//     debugShowCheckedModeBanner: false,
//     initialBinding: ListBinding(),
//     home: const ListViewPage(),
//   ));
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutapp/pages/lazyloadlistpage/list_view.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const HomePage(),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Home Page')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Home button
//             ElevatedButton(
//               onPressed: () {
//                 // Here, you can define what happens when Home is clicked.
//                 // For now, it just does nothing as you are already on the Home page.
//               },
//               child: const Text('Home'),
//             ),
//             const SizedBox(height: 20), // Space between buttons
//             // List button
//             ElevatedButton(
//               onPressed: () {
//                 // Navigate to ListViewPage
//                 Get.to(() => const ListViewPage());
//               },
//               child: const Text('Go to List'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutapp/pages/lazyloadlistpage/list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/bottom_nav_controller.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/settings_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GetX Bottom Nav',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  final List<Widget> _pages = const [
    HomePage(),
    ProfilePage(),
    ListViewPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.put(BottomNavController());

    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text(
              ['Home', 'Profile', 'Settings'][controller.selectedIndex.value],
            ),
          ),
          body: _pages[controller.selectedIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeTabIndex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        ));
  }
}

