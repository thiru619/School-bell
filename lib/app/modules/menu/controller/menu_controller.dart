import 'package:get/get.dart';

class MenuPageController extends GetxController {
  // ------------------------------
  // INITIAL MENU SCREEN
  // ------------------------------
  RxBool timeDuration = true.obs;

  RxBool isInitialMenu = true.obs;

  RxDouble menuOpacity = 1.0.obs;
  RxDouble tableOpacity = 0.0.obs;

  RxDouble menuOffset = 0.0.obs; // slide from bottom
  RxDouble tableOffset = 50.0.obs; // slide from bottom

  // ------------------------------
  // TABLE + DATA
  // ------------------------------
  RxList<Map<String, dynamic>> originalData = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> tableData = <Map<String, dynamic>>[].obs;

  RxInt currentPage = 1.obs;
  final int pageSize = 20;

  RxInt totalItems = 0.obs;

  int get totalPages => (totalItems.value / pageSize).ceil();
  bool get hasNext => currentPage.value < totalPages;
  bool get hasPrev => currentPage.value > 1;

  // ------------------------------
  // MENU
  // ------------------------------
  RxInt selectedMenu = 1.obs;

  // ------------------------------
  // SEARCH
  // ------------------------------
  RxString searchText = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  // ------------------------------------------------------------------
  // startTableTransition
  // - call this to begin transition from initial grid -> table UI
  // - it animates menu out, switches state, and animates table in
  // ------------------------------------------------------------------
  Future<void> startTableTransition() async {
    // animate menu out
    menuOpacity.value = 0.0;
    menuOffset.value = 30.0;
    // allow opacity/translate to animate visually (view uses AnimatedOpacity & Transform)
    await Future.delayed(const Duration(milliseconds: 260));

    // switch to table UI
    isInitialMenu.value = false;

    // animate table in
    tableOpacity.value = 0.0; // ensure starts from 0
    tableOffset.value = 30.0;
    // small delay to allow widget tree to re-render
    await Future.delayed(const Duration(milliseconds: 40));
    tableOpacity.value = 1.0;
    tableOffset.value = 0.0;
  }

  // ------------------------------
  // changeMenu (no animations here)
  // ------------------------------
  void changeMenu(int index) {
    selectedMenu.value = index;
    // reload data for selected menu
    loadInitialData();
    // reset pagination
    currentPage.value = 1;
  }

  // ------------------------------
  // LOAD DEFAULT DATA
  // ------------------------------
  void loadInitialData() {
    originalData.value = List.generate(50, (i) {
      return {
        "sno": i + 1,
        "type": "Educational",
        "section": "7G–B Sec",
        "difficulty": "Medium",
        "from": "One ownAI",
        "total": 10,
        "mark": 2,
        "duration": "Yes",
        "date": "07-11-25",
        "time": "10:00 AM –10:30 AM",
      };
    });

    totalItems.value = originalData.length;

    applySearchFilter();
  }

  // ------------------------------
  // SEARCH FILTER
  // ------------------------------
  void applySearchFilter() {
    List<Map<String, dynamic>> filtered = originalData.where((row) {
      return row.values
          .join(" ")
          .toLowerCase()
          .contains(searchText.value.toLowerCase());
    }).toList();

    tableData.value = filtered;
    totalItems.value = filtered.length;

    currentPage.value = 1; // reset pagination
  }

  // ------------------------------
  // PAGINATION
  // ------------------------------
  List<Map<String, dynamic>> get pageData {
    if (tableData.isEmpty) return <Map<String, dynamic>>[];
    int start = (currentPage.value - 1) * pageSize;
    int end = (start + pageSize).clamp(0, totalItems.value);
    // defensive: ensure indices valid
    if (start >= tableData.length) return <Map<String, dynamic>>[];
    return tableData.sublist(start, end);
  }

  void nextPage() {
    if (hasNext) currentPage.value++;
  }

  void prevPage() {
    if (hasPrev) currentPage.value--;
  }

  // ------------------------------
  // ADD NEW RECORD
  // ------------------------------
  void addNewRecord(Map<String, dynamic> data) {
    originalData.insert(0, data);
    applySearchFilter();
  }
}
