import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          /// 🔵 Top round container (header background)
          Container(
            height: 220.h,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF0D1B2A),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(200),
                bottomRight: Radius.circular(200),
              ),
            ),
          ),

          /// 📦 Content under the header
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),

                  /// 🔹 Profile Header Row
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25.r,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 28.sp, color: Colors.grey[700]),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          "Hi, Jhenyfer",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Icon(Icons.notifications_none, color: Colors.white, size: 26.sp),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  /// 🔹 Task Section
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _taskTile("Rate a business you visited", Icons.star, true),
                        Divider(),
                        _taskTile("Invite a friend", Icons.group, false),
                        Divider(),
                        _taskTile("Explore a new category", Icons.search, false),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  /// 🔹 Top Loopi Section
                  Text(
                    "Top Loopi",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  /// 🏆 Top 3 Cards
                  Row(
                    children: [
                      Expanded(child: _rankCard("2nd", "Coffee Shop", 4.5, Colors.orange)),
                      SizedBox(width: 12.w),
                      Expanded(child: _rankCard("1st", "Coffee Shop", 4.5, Colors.blueAccent, isBig: true)),
                      SizedBox(width: 12.w),
                      Expanded(child: _rankCard("3rd", "Coffee Shop", 4.5, Colors.purple)),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  /// 🔹 More Shops List
                  ListView.builder(
                    itemCount: 6,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 28.r,
                              backgroundColor: Colors.blueAccent,
                              child: Icon(Icons.local_cafe, color: Colors.white, size: 28.sp),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Coffee Shop ${index + 1}",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.star, size: 16.sp, color: Colors.amber),
                                      SizedBox(width: 4.w),
                                      Text("4.5", style: TextStyle(fontSize: 14.sp)),
                                    ],
                                  ),
                                  Text(
                                    "Complete address",
                                    style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔸 Task Row
  Widget _taskTile(String title, IconData icon, bool isDone) {
    return Row(
      children: [
        Icon(icon, color: isDone ? Colors.amber : Colors.grey, size: 22),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        Icon(
          isDone ? Icons.check_circle : Icons.circle_outlined,
          color: isDone ? Colors.green : Colors.grey,
        ),
      ],
    );
  }

  /// 🔸 Rank Card (1st, 2nd, 3rd)
  Widget _rankCard(String rank, String title, double rating, Color color, {bool isBig = false}) {
    return Container(
      height: isBig ? 180 : 150,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.emoji_events, size: isBig ? 40 : 32, color: color),
          SizedBox(height: 8),
          Text(rank, style: TextStyle(fontSize: isBig ? 18 : 14, fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          CircleAvatar(
            radius: isBig ? 28 : 22,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(Icons.local_cafe, color: color, size: isBig ? 26 : 20),
          ),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: isBig ? 16 : 14, fontWeight: FontWeight.w600)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, size: 14, color: Colors.amber),
              SizedBox(width: 4),
              Text(rating.toString(), style: const TextStyle(fontSize: 13)),
            ],
          ),
          Text("Complete address", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        ],
      ),
    );
  }
}
