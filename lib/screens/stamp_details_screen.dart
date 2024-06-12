import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/stamp_controller.dart';

class StampDetailsScreen extends StatelessWidget {
  final StampController controller = Get.put(StampController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('スタンプカード詳細', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('現在の獲得数 30個', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
          Container(
            height: 120, // Set a fixed height for the horizontal ListView
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 60, // Total number of stamps
              itemBuilder: (context, index) {
                return Container(
                  width: 80,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(Icons.check_circle, color: Colors.orange, size: 40),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.stampHistory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(controller.stampHistory[index].date),
                  trailing: Text('${controller.stampHistory[index].count}個'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
