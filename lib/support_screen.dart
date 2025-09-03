import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../core/config/app_color.dart';
import '../../core/config/app_text_style.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final TextEditingController searchController = TextEditingController();

  // Dummy FAQ data
  final List<Map<String, String>> faqList = [
    {
      "question": "Lorem ipsum dolor sit amet consectetur.",
      "answer":
          "Lorem ipsum dolor sit amet consectetur. Purus vitae nibh sociis ornare. Eget gravida in volutpat lacus in vel lectus gravida risus."
    },
    {
      "question": "Lorem ipsum dolor sit amet consectetur.",
      "answer": "Answer for question 2"
    },
    {
      "question": "Lorem ipsum dolor sit amet consectetur.",
      "answer": "Answer for question 3"
    },
    {
      "question": "Lorem ipsum dolor sit amet consectetur.",
      "answer": "Answer for question 4"
    },
    {
      "question": "Lorem ipsum dolor sit amet consectetur.",
      "answer": "Answer for question 5"
    },
  ];

  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyle(context);

    return Scaffold(
      backgroundColor: colors(context).background,
      appBar: AppBar(
        backgroundColor: colors(context).background,
        elevation: 0,
        title: Text("Support", style: style.appBarText18Medium),
        centerTitle: false,
        actions: [
          Icon(Icons.notifications_none, color: AppColor.dark, size: 24.sp),
          Gap(16.w),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            // Search box
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: style.hintText14Medium,
                prefixIcon: Icon(Icons.search,
                    color: AppColor.dark.withValues(alpha: 0.4)),
                filled: false,
                border: const UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColor.dark.withValues(alpha: 0.1),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.dark, width: 1.2),
                ),
              ),
            ),
            Gap(20.h),

            // FAQ list
            Expanded(
              child: ListView.separated(
                itemCount: faqList.length,
                separatorBuilder: (_, __) => Gap(12.h),
                itemBuilder: (context, index) {
                  final item = faqList[index];
                  final isExpanded = expandedIndex == index;

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: ExpansionTile(
                      key: Key(index.toString()),
                      initiallyExpanded: isExpanded,
                      onExpansionChanged: (expanded) {
                        setState(() {
                          expandedIndex = expanded ? index : null;
                        });
                      },
                      tilePadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 6.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      title: Text(
                        item["question"]!,
                        style: style.bodyText14Bold.copyWith(
                          color: AppColor.dark,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 16.w, right: 16.w, bottom: 12.h),
                          child: Text(
                            item["answer"]!,
                            style: style.bodyText12Normal.copyWith(
                              color: AppColor.dark.withValues(alpha: 0.6),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
