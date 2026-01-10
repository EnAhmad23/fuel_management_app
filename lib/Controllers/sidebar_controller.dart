import 'package:get/get.dart';

class SidebarController extends GetxController {
  var selectedIndex = 0.obs;
  var expandedIndices = <int>[].obs;

  void select(int index) {
    selectedIndex.value = index;
  }

  void toggleExpand(int index) {
    if (expandedIndices.contains(index)) {
      expandedIndices.remove(index);
    } else {
      expandedIndices.add(index);
    }
  }
}
