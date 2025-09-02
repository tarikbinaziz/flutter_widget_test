import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback onClose;
  const CustomDrawer({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final items = [
      _DrawerItem('Home', 'assets/icons/home.svg'),
      _DrawerItem('Map', 'assets/icons/map.svg'),
      _DrawerItem('Loopi Market', 'assets/icons/market.svg'),
      _DrawerItem('Wallet', 'assets/icons/wallet.svg'),
      _DrawerItem('Top Loopi', 'assets/icons/top_loopi.svg'),
      _DrawerItem('My profile', 'assets/icons/profile.svg'),
      _DrawerItem('Contact', 'assets/icons/contact.svg'),
      _DrawerItem('Support', 'assets/icons/support.svg'),
    ];

    return Drawer(
      backgroundColor: const Color(0xFF0A2A36), // Dark Blue Background
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top logo & close button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(
                    'assets/icons/logo.svg',
                    width: 100,
                  ),
                  IconButton(
                    onPressed: onClose,
                    icon: const Icon(Icons.close, color: Colors.white, size: 28),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Menu items
            Expanded(
              child: ListView.separated(
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return ListTile(
                    leading: SvgPicture.asset(
                      item.iconPath,
                      width: 24,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                    title: Text(
                      item.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      // Handle navigation
                      Navigator.pop(context);
                    },
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

class _DrawerItem {
  final String title;
  final String iconPath;
  _DrawerItem(this.title, this.iconPath);
}
