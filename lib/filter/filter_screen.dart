import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // Selected states
  Set<String> selectedCategories = {"Cafes"};
  Set<String> selectedRatings = {"4 stars & up"};
  Set<String> selectedDistance = {"Show all"};
  bool onlyOpenNow = true;
  Set<String> selectedVisitHistory = {"Visit recently"};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7F9),
      appBar: AppBar(
        backgroundColor: const Color(0xffF6F7F9),
        elevation: 0,
        title: Text(
          "Filter",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Category"),
            _buildChips(
              ["Cafes", "Restaurants", "Bars", "Gyms", "Wellness", "Beauty Salons", "Retail", "Services", "Pet friendly"],
              selectedCategories,
            ),
            _sectionTitle("Ratings"),
            _buildChips(
              ["4 stars & up", "Most reviewed", "Top Loopi Ranked", "Loopi recommend"],
              selectedRatings,
            ),
            _sectionTitle("Distance"),
            _buildChips(
              ["Show all", "Within 500m", "Within 1km", "Within 3km"],
              selectedDistance,
            ),
            _sectionTitle("Open now"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Only show open business",
                  style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                ),
                Checkbox(
                  value: onlyOpenNow,
                  onChanged: (val) {
                    setState(() => onlyOpenNow = val ?? false);
                  },
                )
              ],
            ),
            _sectionTitle("Visit History"),
            _buildChips(
              ["Visit recently", "Never visit"],
              selectedVisitHistory,
            ),
            SizedBox(height: 32.h),

            // Apply Button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Apply",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // Clean Filters
            Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    selectedCategories.clear();
                    selectedRatings.clear();
                    selectedDistance.clear();
                    selectedVisitHistory.clear();
                    onlyOpenNow = false;
                  });
                },
                child: Text(
                  "Clean filters",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Section Title
  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  // Chips Builder
  Widget _buildChips(List<String> items, Set<String> selectedSet) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: items.map((item) {
        final isSelected = selectedSet.contains(item);
        return ChoiceChip(
          label: Text(
            item,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
          selected: isSelected,
          selectedColor: Colors.black87,
          backgroundColor: const Color(0xffE8EBF0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
          onSelected: (val) {
            setState(() {
              selectedSet.clear(); // only one selection per group
              if (val) selectedSet.add(item);
            });
          },
        );
      }).toList(),
    );
  }
}
