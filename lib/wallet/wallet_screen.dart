import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final coffeeCards = [
      WalletCardData(
        imagePath: 'assets/images/coffee1.jpg',
        shopName: 'Coffe Shop',
        current: 2,
        total: 10,
      ),
      WalletCardData(
        imagePath: 'assets/images/coffee2.jpg',
        shopName: 'Coffe Shop',
        current: 2,
        total: 10,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    'Wallet',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: coffeeCards.length,
                  itemBuilder: (context, index) {
                    final data = coffeeCards[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _WalletCard(data: data),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WalletCardData {
  final String imagePath;
  final String shopName;
  final int current;
  final int total;

  WalletCardData({
    required this.imagePath,
    required this.shopName,
    required this.current,
    required this.total,
  });
}

class _WalletCard extends StatelessWidget {
  final WalletCardData data;
  const _WalletCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final progress = data.current / data.total;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              data.imagePath,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/icons/shop_icon.png', // shop logo
                        width: 28,
                        height: 28,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      data.shopName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Text('x1',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            )),
                        const SizedBox(width: 4),
                        SvgPicture.asset(
                          'assets/icons/bean.svg', // coffee bean icon
                          width: 18,
                          height: 18,
                          colorFilter: const ColorFilter.mode(
                              Colors.black87, BlendMode.srcIn),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF112D36)),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${data.current}/${data.total}',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                    const Text(
                      'Earn 1 free coffee',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
