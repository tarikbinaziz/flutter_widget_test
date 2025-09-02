import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _search = TextEditingController();
  final ValueNotifier<bool> _busy = ValueNotifier(false);

  static const _initialPos = CameraPosition(
    target: LatLng(40.741_895, -73.989_308), // Flatiron-ish; replace as needed
    zoom: 14.3,
  );

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('cafe_1'),
      position: LatLng(40.7424, -73.9857),
      infoWindow: InfoWindow(title: 'Coffee Shop'),
    ),
  };

  @override
  void dispose() {
    _search.dispose();
    _busy.dispose();
    super.dispose();
  }

  Future<void> _centerOnUser() async {
    try {
      _busy.value = true;

      final enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) {
        if (context.mounted) {
          _showSnack('Enable location services to center the map.');
        }
        return;
      }

      LocationPermission perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }
      if (perm == LocationPermission.deniedForever ||
          perm == LocationPermission.denied) {
        if (context.mounted) {
          _showSnack('Location permission denied.');
        }
        return;
      }

      final pos = await Geolocator.getCurrentPosition();
      final controller = await _controller.future;
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(pos.latitude, pos.longitude), zoom: 16),
        ),
      );
    } catch (e) {
      _showSnack('Could not get location: $e');
    } finally {
      _busy.value = false;
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topSafe = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialPos,
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            compassEnabled: false,
            onMapCreated: (c) => _controller.complete(c),
            mapToolbarEnabled: false,
          ),

          // Header: title + bell
          Positioned(
            left: 16,
            right: 16,
            top: topSafe + 8,
            child: Row(
              children: [
                const Text(
                  'Map',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
                const Spacer(),
                IconButton.outlined(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none_rounded),
                  style: IconButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(8),
                  ),
                ),
              ],
            ),
          ),

          // Search + Filter
          Positioned(
            left: 16,
            right: 16,
            top: topSafe + 48,
            child: Row(
              children: [
                Expanded(
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(24),
                    child: TextField(
                      controller: _search,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search_rounded),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                        filled: true,
                      ),
                      onSubmitted: (q) {
                        // TODO: hook to real search
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B7C9E),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 8,
                        offset: Offset(0, 3),
                        color: Colors.black12,
                      )
                    ],
                  ),
                  child: IconButton(
                    onPressed: () {
                      // TODO: open filters bottom sheet
                    },
                    icon: const Icon(Icons.tune_rounded, color: Colors.white),
                  ),
                )
              ],
            ),
          ),

          // Center-on-me fab
          Positioned(
            right: 16,
            bottom: 180,
            child: ValueListenableBuilder(
              valueListenable: _busy,
              builder: (_, busy, __) => FloatingActionButton.small(
                onPressed: busy ? null : _centerOnUser,
                child: busy
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.my_location_rounded),
              ),
            ),
          ),

          // Bottom reviews sheet (draggable)
          _ReviewsSheet(
            onReviewTap: (i) {},
          ),
        ],
      ),
    );
  }
}

class _ReviewsSheet extends StatelessWidget {
  const _ReviewsSheet({required this.onReviewTap});
  final ValueChanged<int> onReviewTap;

  @override
  Widget build(BuildContext context) {
    final items = _demoReviews;

    return DraggableScrollableSheet(
      initialChildSize: 0.30,
      minChildSize: 0.20,
      maxChildSize: 0.70,
      snap: true,
      builder: (context, controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 16,
                  offset: Offset(0, -4),
                  color: Colors.black12,
                )
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 8),
                Container(
                  width: 38,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(height: 10),

                // Header: shop card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 18,
                        child: Icon(Icons.local_cafe_rounded),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Coffee Shop',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                )),
                            SizedBox(height: 2),
                            Row(
                              children: [
                                Icon(Icons.place_rounded, size: 16),
                                SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    'Complete address',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: 4.5,
                            itemBuilder: (ctx, _) =>
                                const Icon(Icons.star_rounded),
                            itemSize: 18,
                          ),
                          const SizedBox(width: 6),
                          const Text('(4.5)',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(height: 1),

                // Reviews
                Expanded(
                  child: ListView.separated(
                    controller: controller,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (ctx, i) {
                      final r = items[i];
                      return InkWell(
                        onTap: () => onReviewTap(i),
                        borderRadius: BorderRadius.circular(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundImage: AssetImage(r.avatarAsset),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          r.author,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        r.timeAgo,
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  RatingBarIndicator(
                                    rating: r.stars,
                                    itemSize: 16,
                                    itemBuilder: (ctx, _) =>
                                        const Icon(Icons.star_rounded),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    r.text,
                                    style: const TextStyle(height: 1.3),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class Review {
  final String author;
  final String timeAgo;
  final double stars;
  final String text;
  final String avatarAsset;

  const Review({
    required this.author,
    required this.timeAgo,
    required this.stars,
    required this.text,
    required this.avatarAsset,
  });
}

const _demoReviews = <Review>[
  Review(
    author: 'Jhenyfer Santos',
    timeAgo: '2 days ago',
    stars: 5,
    text:
        'Love the cozy vibe and the seasonal drinks. The barista even remembered my name!',
    avatarAsset: 'assets/avatar1.png',
  ),
  Review(
    author: 'Jhenyfer Santos',
    timeAgo: '2 days ago',
    stars: 4,
    text:
        'Great service and fast Wi-Fi. It gets a bit crowded in the afternoon, though.',
    avatarAsset: 'assets/avatar2.png',
  ),
  Review(
    author: 'Jhenyfer Santos',
    timeAgo: '2 days ago',
    stars: 4,
    text:
        'Coffee was good, but my order took longer than expected. Still recommend.',
    avatarAsset: 'assets/avatar3.png',
  ),
];


/*
4) Android setup (Maps + location)

android/app/src/main/AndroidManifest.xml (inside <application> ... </application>)

<meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_ANDROID_GOOGLE_MAPS_API_KEY"/>


android/app/src/main/AndroidManifest.xml (top-level, outside <application>)

<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>


For release builds, make sure you’ve set your SHA-1/256 fingerprints in Google Cloud Console for the same key used to sign the app.

5) iOS setup (Maps + location)

ios/Runner/AppDelegate.swift (Swift)

import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("YOUR_IOS_GOOGLE_MAPS_API_KEY")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}


ios/Runner/Info.plist (add the usage descriptions)

<key>NSLocationWhenInUseUsageDescription</key>
<string>We use your location to show nearby cafés.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>We use your location to show nearby cafés.</string>


On iOS, also enable Background Modes > Location updates only if you truly need it (you don’t for this screen).
*/