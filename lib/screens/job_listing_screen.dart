// lib/screens/job_listing_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/job_controller.dart';
import 'stamp_details_screen.dart';

class JobListingScreen extends StatelessWidget {
  final JobController controller = Get.put(JobController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160), // Adjust the height as needed
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: Column(
            children: [
              SizedBox(height: 40), // For status bar height adjustment
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [

                    Expanded(
                      child: Container(
                        height: 40, // Adjust height of the search bar
                        child: TextField(
                          decoration: InputDecoration(
                            // hintText: '北海道, 札幌市',
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey[200],
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) => controller.searchQuery.value = value,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.notifications, color: Colors.grey),
                    SizedBox(width: 10),
                    Icon(Icons.favorite_border, color: Colors.red),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Colors.orange,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '2022年5月26日 (木)',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          CalendarWidget(controller: controller),
          Expanded(child: JobListWidget(controller: controller)),
          BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.search), label: 'さがす'),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'お仕事'),
              BottomNavigationBarItem(icon: Icon(Icons.camera), label: '打刻する'),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'チャット'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'マイページ'),
            ],
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey,
            currentIndex: 0,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              if (index == 2) {
                Get.to(StampDetailsScreen());
              }
            },
          ),
        ],
      ),
    );
  }
}

class CalendarWidget extends StatelessWidget {
  final JobController controller;

  CalendarWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7, // Display a week for now
        itemBuilder: (context, index) {
          DateTime date = DateTime.now().add(Duration(days: index));
          return GestureDetector(
            onTap: () => controller.selectDate(date),
            child: Container(
              margin: EdgeInsets.all(4),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: date == controller.selectedDate.value ? Colors.orange : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text('${date.day}', style: TextStyle(fontSize: 18)),
                  Text(_weekdayString(date.weekday), style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _weekdayString(int weekday) {
    switch (weekday) {
      case 1:
        return '月';
      case 2:
        return '火';
      case 3:
        return '水';
      case 4:
        return '木';
      case 5:
        return '金';
      case 6:
        return '土';
      case 7:
        return '日';
      default:
        return '';
    }
  }
}

class JobListWidget extends StatelessWidget {
  final JobController controller;

  JobListWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.filteredJobList.isEmpty) {
        return Center(child: Text('No jobs available'));
      }
      return ListView.builder(
        itemCount: controller.filteredJobList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              leading: Image.network('https://via.placeholder.com/150'), // Placeholder for job image
              title: Text(controller.filteredJobList[index]),
              subtitle: Text('5月31日 (水) 08:00 - 17:00\n交通費 300円'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('¥6,000', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('本日まで', style: TextStyle(color: Colors.red, fontSize: 12)),
                ],
              ),
              isThreeLine: true,
            ),
          );
        },
      );
    });
  }
}
