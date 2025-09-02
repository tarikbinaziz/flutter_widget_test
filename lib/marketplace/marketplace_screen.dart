import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MarketplaceScreen extends StatelessWidget {
  const MarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Loopi Marketplace",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.black),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: GridView.builder(
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            childAspectRatio: 0.8, // ratio maintain korar jonno
          ),
          itemBuilder: (context, index) {
            return _OfferCard(
              imageUrl: _dummyData[index]["image"]!,
              title: _dummyData[index]["title"]!,
              subtitle: _dummyData[index]["subtitle"]!,
              logo: _dummyData[index]["logo"]!,
            );
          },
        ),
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String logo;

  const _OfferCard({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        color: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Text + Logo
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 10.r,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(logo),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// Dummy data for demo (replace with API data)
final List<Map<String, String>> _dummyData = [
  {
    "image":
        "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=500",
    "title": "Free Medium Coffee",
    "subtitle": "Coffee Shop",
    "logo": "https://cdn-icons-png.flaticon.com/512/1046/1046784.png",
  },
  {
    "image":
        "https://images.unsplash.com/photo-1550547660-d9450f859349?w=500",
    "title": "20% Off Your Bill",
    "subtitle": "Burger Bull",
    "logo": "https://cdn-icons-png.flaticon.com/512/1046/1046786.png",
  },
  {
    "image":
        "https://images.unsplash.com/photo-1617196037283-5b1a9d46b94e?w=500",
    "title": "Combo Meal",
    "subtitle": "Panda Meal",
    "logo": "https://cdn-icons-png.flaticon.com/512/1046/1046785.png",
  },
  {
    "image":
        "https://images.unsplash.com/photo-1565958011703-44c04c47dba7?w=500",
    "title": "10% Off Any Pastry",
    "subtitle": "Donuts Loopi",
    "logo": "https://cdn-icons-png.flaticon.com/512/1046/1046782.png",
  },
  {
    "image":
        "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=500",
    "title": "Combo Meal",
    "subtitle": "Coffee Shop",
    "logo": "https://cdn-icons-png.flaticon.com/512/1046/1046784.png",
  },
  {
    "image":
        "https://images.unsplash.com/photo-1617196037283-5b1a9d46b94e?w=500",
    "title": "10% Off Any Pastry",
    "subtitle": "Panda Meal",
    "logo": "https://cdn-icons-png.flaticon.com/512/1046/1046785.png",
  },
];
