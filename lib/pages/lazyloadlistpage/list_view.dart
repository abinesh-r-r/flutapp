import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'list_controller.dart';

class ListViewPage extends GetView<ListController> {
  const ListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.delete<ListController>();
    final ListController controller = Get.put(ListController());
    return Scaffold(
      appBar: AppBar(title: const Text('Posts List')),
      body: Obx(() {
        if (controller.vars.isLoading.value &&
            controller.vars.postList.isEmpty) {
          // Show loading spinner at the beginning if no data is loaded
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          controller: controller.scrollController, // Attach ScrollController
          itemCount: controller.vars.postList.length +
              (controller.isLoadingNextPage.value
                  ? 1
                  : 0), // Show loader at the end
          itemBuilder: (_, index) {
            if (index == controller.vars.postList.length &&
                controller.isLoadingNextPage.value) {
              // Show loading indicator at the bottom if more items are being loaded
              return const SizedBox(
                  height: 50,
                  child: Center(child: CircularProgressIndicator()));
            }

            final post = controller.vars.postList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
                child: ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';
// import 'list_controller.dart';

// class ListViewPage extends GetView<ListController> {
//   const ListViewPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final ListController controller = Get.put(ListController());
//     controller.onInit(); // Initialize the controller

//     return Scaffold(
//       appBar: AppBar(
//         title: Obx(() => Text('Time: ${controller.currentTime.value}')),
//         centerTitle: true,
//       ),
//       body: Obx(() {
//         if (controller.vars.isLoading.value &&
//             controller.vars.postList.isEmpty &&
//             !controller.isDataFetched.value) {
//           return ListView.builder(
//             itemCount: 6, // Number of shimmer items
//             itemBuilder: (_, index) => Shimmer.fromColors(
//               baseColor: Colors.grey.shade300,
//               highlightColor: Colors.grey.shade100,
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 child: Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: Colors.grey.shade300),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Simulated title (full width)
//                       Container(
//                         width: double.infinity,
//                         height: 16,
//                         color: Colors.grey[300],
//                       ),
//                       const SizedBox(height: 10),
//                       // Simulated body line 1
//                       Container(
//                         width: double.infinity,
//                         height: 14,
//                         color: Colors.grey[300],
//                       ),
//                       const SizedBox(height: 6),
//                       // Simulated body line 2 (shorter)
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.7,
//                         height: 14,
//                         color: Colors.grey[300],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }

//         return AnimatedSwitcher(
//           duration: const Duration(
//               milliseconds: 500), // Duration of the smooth transition
//           child: ListView.builder(
//                   itemCount: controller.vars.postList.length,
//                   itemBuilder: (_, index) {
//                     final post = controller.vars.postList[index];
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.grey,
//                             width: 1.0,
//                           ),
//                         ),
//                         child: ListTile(
//                           title: Text(post.title),
//                           subtitle: Text(post.body),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//         );
//       }),
//     );
//   }
// }
