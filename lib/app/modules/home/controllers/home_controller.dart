import 'package:get/get.dart';

class HomeController extends GetxController {
  // ignore: todo
  //TODO: Implement HomeController

  final count = 0.obs;


  @override
  void onClose() {}
  void increment() => count.value++;
}
