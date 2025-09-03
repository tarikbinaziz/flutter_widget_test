import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../core/config/app_color.dart';
import '../../core/config/app_text_style.dart';
import '../../widgets/custom_text_field_with_heading.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int rating = 0;
  final List<String> tags = [
    "Fast service",
    "Friendly staff",
    "Clean environment",
    "Great value",
    "Great menu",
    "Comfortable space",
    "Long wait",
    "Noisy atmosphere",
    "Order mistake",
  ];
  final List<String> selectedTags = [];

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyle(context);

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("How was your experience?", style: style.title16Bold),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text("Cancel",
                      style: style.bodyText14SemiBold.copyWith(
                        color: Colors.red,
                      )),
                ),
              ],
            ),
            Gap(16.h),

            /// Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => IconButton(
                  onPressed: () => setState(() => rating = index + 1),
                  icon: Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 28.sp,
                  ),
                ),
              ),
            ),
            Gap(16.h),

            /// Tags
            Align(
              alignment: Alignment.centerLeft,
              child: Text("What stood out to you?", style: style.bodyText14SemiBold),
            ),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: tags.map((tag) {
                final isSelected = selectedTags.contains(tag);
                return ChoiceChip(
                  label: Text(tag, style: style.bodyTextSmall12Medium),
                  selected: isSelected,
                  onSelected: (val) {
                    setState(() {
                      val ? selectedTags.add(tag) : selectedTags.remove(tag);
                    });
                  },
                  selectedColor: AppColor.dark,
                  backgroundColor: Colors.grey.shade200,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppColor.dark,
                  ),
                );
              }).toList(),
            ),
            Gap(20.h),

            /// Comment field
            CustomTextFieldWithHeading(
              textFieldName: "comment",
              hintText: "Leave a comment",
              maxLines: 3,
            ),
            Gap(20.h),

            /// Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.dark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                onPressed: () {
                  debugPrint("Rating: $rating, Tags: $selectedTags");
                  Navigator.pop(context);
                },
                child: Text("Submit",
                    style: style.buttonText16Bold.copyWith(
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
