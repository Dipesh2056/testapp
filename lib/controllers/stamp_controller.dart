// lib/controllers/stamp_controller.dart
import 'package:get/get.dart';

class StampController extends GetxController {
  var stampHistory = [
    Stamp(date: '2021/11/18', count: 1),
    Stamp(date: '2021/11/17', count: 1),
    Stamp(date: '2021/11/16', count: 1),
    Stamp(date: '2021/11/13', count: 1),
    Stamp(date: '2021/11/12', count: 1),
  ].obs;
}

class Stamp {
  final String date;
  final int count;

  Stamp({required this.date, required this.count});
}
