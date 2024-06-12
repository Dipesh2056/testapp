import 'package:get/get.dart';

class JobController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var jobList = <String>[].obs; // Replace with your job model
  var filteredJobList = <String>[].obs; // List to hold the filtered jobs
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobs(); // Fetch jobs initially
    ever(searchQuery, (_) => filterJobs()); // Re-filter jobs whenever searchQuery changes
    ever(selectedDate, (_) => fetchJobs()); // Refetch jobs whenever selectedDate changes
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  void fetchJobs() {
    // Simulate fetching jobs based on selectedDate
    // Replace this with your actual logic to fetch jobs from a data source
    // For demonstration purposes, this will add jobs based on the day of the selectedDate
    jobList.clear(); // Clear existing jobs
    for (int i = 0; i < selectedDate.value.day; i++) {
      jobList.add('Job ${i + 1} on ${selectedDate.value.year}-${selectedDate.value.month}-${selectedDate.value.day}');
    }
    filterJobs(); // Filter the fetched jobs
  }

  void filterJobs() {
    if (searchQuery.value.isEmpty) {
      filteredJobList.value = jobList;
    } else {
      filteredJobList.value = jobList.where((job) => job.contains(searchQuery.value)).toList();
    }
  }
}
