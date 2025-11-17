import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/images.dart';
import '../../../widgets/custom_text.dart';
import '../controller/menu_controller.dart';
import '../widget/crossword/views/crossword_view.dart';
import '../widget/exam/views/exam_view.dart';
import '../widget/question/views/question_view.dart';
import '../widget/responsive.dart';
import '../widget/table_widget.dart';
import '../widget/menu_item_widget.dart';
import '../../../utils/theme.dart';

class MenuPageView extends GetView<MenuPageController> {
  const MenuPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
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
            crossAxisCount: 2,
            // crossAxisCount: Responsive.isMobile(context)
            //     ? 2
            //     : Responsive.isTablet(context)
            //     ? 3
            //     : 4,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
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
        icon: AssetsGif.crossWord,
        title: "Cross Word",
        active: controller.selectedMenu.value == 1,
        onTap: () async {
          await controller.startTableTransition();
          controller.changeMenu(1);
        },
      ),
      menuItemWidget(
        icon: AssetsGif.findWord,
        title: "Find Word",
        active: controller.selectedMenu.value == 2,
        onTap: () async {
          await controller.startTableTransition();
          controller.changeMenu(2);
        },
      ),
      menuItemWidget(
        icon: AssetsGif.question,
        title: "Question",
        active: controller.selectedMenu.value == 3,
        onTap: () async {
          await controller.startTableTransition();
          controller.changeMenu(3);
        },
      ),
      menuItemWidget(
        icon: AssetsGif.exam,
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
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.search, size: 22, color: AppTheme.violet),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.violet,
                ),
                onPressed: () => controller.selectedMenu.value == 1
                    ? showAddPopup(controller, context)
                    : controller.selectedMenu.value == 2
                    ? showQuestionPaperPopup(controller, context)
                    : controller.selectedMenu.value == 3
                    ? showQuestionPaperPopup(controller, context)
                    : controller.selectedMenu.value == 4
                    ? showExamPopup(controller, context)
                    : SizedBox.shrink(),
                child: CustomText(text: "Add new +", color: Colors.white),
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
}
