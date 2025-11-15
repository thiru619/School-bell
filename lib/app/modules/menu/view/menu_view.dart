// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../utils/theme.dart';
// import '../controller/menu_controller.dart';
// import '../widget/menu_item_widget.dart';
// import '../widget/responsive.dart';
// import '../widget/table_widget.dart';

// class MenuPageView extends GetView<MenuController> {
//   const MenuPageView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GetBuilder<MenuPageController>(
//         builder: (controller) => SafeArea(
//           child: Column(
//             children: [
//               Responsive.isMobile(context)
//                   ? SizedBox(
//                       height: 100,
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(children: _buildMenu(controller)),
//                       ),
//                     )
//                   : Wrap(spacing: 20, children: _buildMenu(controller)),

//               const SizedBox(height: 16),

//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   children: [
//                     // SEARCH BOX expands on larger screens
//                     Expanded(
//                       flex: Responsive.isMobile(context) ? 3 : 5,
//                       child: Container(
//                         height: 45,
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           border: Border.all(color: Colors.grey.shade400),
//                         ),
//                         child: const Row(
//                           children: [
//                             Expanded(
//                               child: TextField(
//                                 decoration: InputDecoration(
//                                   hintText: "Search Ctrl+k",
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                             Icon(Icons.search, size: 22),
//                           ],
//                         ),
//                       ),
//                     ),

//                     const SizedBox(width: 10),

//                     // ADD NEW button
//                     Expanded(
//                       flex: Responsive.isMobile(context) ? 2 : 1,
//                       child: Align(
//                         alignment: Alignment.centerRight,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             showDialog(
//                               context: context,
//                               builder: (_) {
//                                 TextEditingController type =
//                                     TextEditingController();
//                                 TextEditingController section =
//                                     TextEditingController();

//                                 return AlertDialog(
//                                   title: const Text("Add New Record"),
//                                   content: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       TextField(
//                                         controller: type,
//                                         decoration: const InputDecoration(
//                                           labelText: "Type",
//                                         ),
//                                       ),
//                                       TextField(
//                                         controller: section,
//                                         decoration: const InputDecoration(
//                                           labelText: "Section",
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   actions: [
//                                     TextButton(
//                                       onPressed: () => Get.back(),
//                                       child: const Text("Cancel"),
//                                     ),
//                                     ElevatedButton(
//                                       onPressed: () {
//                                         controller.addNewRecord({
//                                           "sno":
//                                               controller.originalData.length +
//                                               1,
//                                           "type": type.text,
//                                           "section": section.text,
//                                           "difficulty": "Easy",
//                                           "from": "User Added",
//                                           "total": 1,
//                                           "mark": 1,
//                                           "duration": "Yes",
//                                           "date": "Today",
//                                           "time": "Now",
//                                         });
//                                         Get.back();
//                                       },
//                                       child: const Text("Add"),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             );
//                           },
//                           child: const Text("Add new +"),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // ------------------------------------------------------
//               // TABLE - RESPONSIVE SCROLL
//               // ------------------------------------------------------
//               Expanded(
//                 child: Obx(() {
//                   return Scrollbar(
//                     thumbVisibility: true,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: SizedBox(
//                         width: Responsive.isMobile(context)
//                             ? 700
//                             : Responsive.isTablet(context)
//                             ? 900
//                             : 1100,
//                         child: Scrollbar(
//                           thumbVisibility: true,
//                           child: SingleChildScrollView(
//                             child: tableWidget(rows: controller.pageData),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }),
//               ),

//               // ------------------------------------------------------
//               // BOTTOM PAGINATION BAR (Fixed)
//               // ------------------------------------------------------
//               _paginationBar(controller),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ------------------ BUILD MENU ITEMS ------------------
//   List<Widget> _buildMenu(MenuPageController controller) {
//     return [
//       menuItemWidget(
//         title: "Cross Word",
//         active: controller.selectedMenu.value == 1,
//         onTap: () => controller.changeMenu(1),
//       ),
//       menuItemWidget(
//         title: "Find Word",
//         active: controller.selectedMenu.value == 2,
//         onTap: () => controller.changeMenu(2),
//       ),
//       menuItemWidget(
//         title: "Question",
//         active: controller.selectedMenu.value == 3,
//         onTap: () => controller.changeMenu(3),
//       ),
//       menuItemWidget(
//         title: "Exam",
//         active: controller.selectedMenu.value == 4,
//         onTap: () => controller.changeMenu(4),
//       ),
//     ];
//   }

//   // ------------------ PAGINATION BAR ------------------
//   Widget _paginationBar(MenuPageController controller) {
//     return Obx(() {
//       int showing = controller.pageData.length;
//       int pageStart =
//           ((controller.currentPage.value - 1) * controller.pageSize) + 1;
//       int pageEnd = pageStart + showing - 1;

//       return Container(
//         height: 60,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 6,
//               offset: const Offset(0, -2),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             // LEFT SIDE — COUNTER
//             Text(
//               "Showing $pageStart - $pageEnd of ${controller.totalItems.value} records",
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Colors.black87,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),

//             // RIGHT SIDE — PAGINATION BUTTONS
//             Row(
//               children: [
//                 // PREVIOUS BUTTON
//                 GestureDetector(
//                   onTap: controller.hasPrev ? controller.prevPage : null,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 10,
//                     ),
//                     decoration: BoxDecoration(
//                       color: controller.hasPrev
//                           ? AppTheme.violet
//                           : Colors.grey.shade300,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Icon(
//                       Icons.arrow_back_ios,
//                       size: 14,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),

//                 // NEXT BUTTON
//                 GestureDetector(
//                   onTap: controller.hasNext ? controller.nextPage : null,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 10,
//                     ),
//                     decoration: BoxDecoration(
//                       color: controller.hasNext
//                           ? AppTheme.violet
//                           : Colors.grey.shade300,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Icon(
//                       Icons.arrow_forward_ios,
//                       size: 14,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//     });
//   }

//   // ------------------ ADD POPUP ------------------
//   void showAddPopup(MenuPageController controller, BuildContext context) {
//     TextEditingController nameCtrl = TextEditingController();

//     Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         title: const Text("Add New Record"),
//         content: SizedBox(
//           width: Responsive.isMobile(context) ? 260 : 350,
//           child: TextField(
//             controller: nameCtrl,
//             decoration: const InputDecoration(
//               labelText: "Enter Name",
//               border: OutlineInputBorder(),
//             ),
//           ),
//         ),
//         actions: [
//           TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
//           ElevatedButton(
//             onPressed: () {
//               if (nameCtrl.text.trim().isNotEmpty) {
//                 controller.addRecord(nameCtrl.text.trim());
//               }
//               Get.back();
//             },
//             child: const Text("Add"),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Widget _buildInitialMenuGrid(
//   MenuPageController controller,
//   BuildContext context,
// ) {
//   return Obx(() {
//     return AnimatedOpacity(
//       duration: const Duration(milliseconds: 300),
//       opacity: controller.menuOpacity.value,
//       child: Transform.translate(
//         offset: Offset(0, controller.menuOffset.value),
//         child: Center(
//           child: GridView.count(
//             shrinkWrap: true,
//             crossAxisCount: Responsive.isMobile(context)
//                 ? 2
//                 : Responsive.isTablet(context)
//                 ? 3
//                 : 4,
//             crossAxisSpacing: 20,
//             mainAxisSpacing: 20,
//             padding: const EdgeInsets.all(24),
//             children: List.generate(
//               _buildMenu(controller).length,
//               (i) => GestureDetector(
//                 onTap: () => controller.changeMenu(i + 1),
//                 child: _buildMenu(controller)[i],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   });
// }

// Widget _buildFullTableUI(MenuPageController controller, BuildContext context) {
//   return Obx(() {
//     return AnimatedOpacity(
//       duration: const Duration(milliseconds: 300),
//       opacity: controller.tableOpacity.value,
//       child: Transform.translate(
//         offset: Offset(0, controller.tableOffset.value),
//         child: Column(
//           children: [
//             // your top menu row
//             Responsive.isMobile(context)
//                 ? SizedBox(
//                     height: 100,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: Row(children: _buildMenu(controller)),
//                     ),
//                   )
//                 : Wrap(spacing: 20, children: _buildMenu(controller)),

//             const SizedBox(height: 16),

//             _searchAndAddNewBar(controller, context),

//             const SizedBox(height: 16),

//             Expanded(
//               child: Scrollbar(
//                 thumbVisibility: true,
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: SizedBox(
//                     width: Responsive.isMobile(context)
//                         ? 700
//                         : Responsive.isTablet(context)
//                         ? 900
//                         : 1100,
//                     child: SingleChildScrollView(
//                       child: tableWidget(rows: controller.pageData),
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             _paginationBar(controller),
//           ],
//         ),
//       ),
//     );
//   });
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/menu_controller.dart';
import '../widget/responsive.dart';
import '../widget/table_widget.dart';
import '../widget/menu_item_widget.dart';
import '../../../utils/theme.dart';

class MenuPageView extends GetView<MenuPageController> {
  const MenuPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MenuPageController>(
        builder: (controller) => SafeArea(
          child: Obx(() {
            return controller.isInitialMenu.value
                ? _buildInitialMenuGrid(controller, context)
                : _buildFullTableUI(controller, context);
          }),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------
  // 1️⃣ INITIAL MENU GRID WITH ANIMATION
  // -------------------------------------------------------------------
  Widget _buildInitialMenuGrid(
    MenuPageController controller,
    BuildContext context,
  ) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 350),
      opacity: controller.menuOpacity.value,
      child: Transform.translate(
        offset: Offset(0, controller.menuOffset.value),
        child: Center(
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: Responsive.isMobile(context)
                ? 2
                : Responsive.isTablet(context)
                ? 3
                : 4,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            padding: const EdgeInsets.all(20),
            children: List.generate(
              _buildMenu(controller).length,
              (i) => GestureDetector(
                onTap: () async {
                  await controller.startTableTransition(); // animation
                  controller.changeMenu(i + 1); // change menu
                },
                child: _buildMenu(controller)[i],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------
  // 2️⃣ FULL TABLE UI
  // -------------------------------------------------------------------
  Widget _buildFullTableUI(
    MenuPageController controller,
    BuildContext context,
  ) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 350),
      opacity: controller.tableOpacity.value,
      child: Transform.translate(
        offset: Offset(0, controller.tableOffset.value),
        child: Column(
          children: [
            // TOP MENU
            Responsive.isMobile(context)
                ? SizedBox(
                    height: 100,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: _buildMenu(controller)),
                    ),
                  )
                : Wrap(spacing: 20, children: _buildMenu(controller)),

            const SizedBox(height: 16),

            _searchAndAddNewBar(controller, context),

            const SizedBox(height: 16),

            // TABLE CONTENT
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: Responsive.isMobile(context)
                        ? 700
                        : Responsive.isTablet(context)
                        ? 900
                        : 1100,
                    child: SingleChildScrollView(
                      child: tableWidget(rows: controller.pageData),
                    ),
                  ),
                ),
              ),
            ),

            _paginationBar(controller),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------
  // 3️⃣ MENU ITEMS LIST
  // -------------------------------------------------------------------
  List<Widget> _buildMenu(MenuPageController controller) {
    return [
      menuItemWidget(
        title: "Cross Word",
        active: controller.selectedMenu.value == 1,
        onTap: () async {
          await controller.startTableTransition();
          controller.changeMenu(1);
        },
      ),
      menuItemWidget(
        title: "Find Word",
        active: controller.selectedMenu.value == 2,
        onTap: () async {
          await controller.startTableTransition();
          controller.changeMenu(2);
        },
      ),
      menuItemWidget(
        title: "Question",
        active: controller.selectedMenu.value == 3,
        onTap: () async {
          await controller.startTableTransition();
          controller.changeMenu(3);
        },
      ),
      menuItemWidget(
        title: "Exam",
        active: controller.selectedMenu.value == 4,
        onTap: () async {
          await controller.startTableTransition();
          controller.changeMenu(4);
        },
      ),
    ];
  }

  // -------------------------------------------------------------------
  // 4️⃣ SEARCH + ADD NEW BAR
  // -------------------------------------------------------------------
  Widget _searchAndAddNewBar(
    MenuPageController controller,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: Responsive.isMobile(context) ? 3 : 5,
            child: Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search Ctrl+k",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.search, size: 22),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: Responsive.isMobile(context) ? 2 : 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => _showAddPopup(controller, context),
                child: const Text("Add new +"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // 5️⃣ PAGINATION BAR
  // -------------------------------------------------------------------
  Widget _paginationBar(MenuPageController controller) {
    return Obx(() {
      int showing = controller.pageData.length;
      int pageStart =
          (controller.currentPage.value - 1) * controller.pageSize + 1;
      int pageEnd = pageStart + showing - 1;

      return Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Showing $pageStart - $pageEnd of ${controller.totalItems.value} records",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),

            Row(
              children: [
                GestureDetector(
                  onTap: controller.hasPrev ? controller.prevPage : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: controller.hasPrev
                          ? AppTheme.violet
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: controller.hasNext ? controller.nextPage : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: controller.hasNext
                          ? AppTheme.violet
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  // -------------------------------------------------------------------
  // 6️⃣ ADD NEW POPUP
  // -------------------------------------------------------------------
  void _showAddPopup(MenuPageController controller, BuildContext context) {
    TextEditingController type = TextEditingController();
    TextEditingController section = TextEditingController();

    Get.dialog(
      AlertDialog(
        title: const Text("Add New Record"),
        content: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: type,
                decoration: const InputDecoration(labelText: "Type"),
              ),
              TextField(
                controller: section,
                decoration: const InputDecoration(labelText: "Section"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              controller.addNewRecord({
                "sno": controller.originalData.length + 1,
                "type": type.text,
                "section": section.text,
                "difficulty": "Easy",
                "from": "User Added",
                "total": 1,
                "mark": 1,
                "duration": "Yes",
                "date": "Today",
                "time": "Now",
              });
              Get.back();
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
