import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_carosel_slider/config/app_constants.dart';
import 'package:flutter_widget_carosel_slider/config/theme.dart';
import 'package:flutter_widget_carosel_slider/onboarding/views/onboarding_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(AppConstants.appSettingsBox);
  await Hive.openBox(AppConstants.userBox);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // XD Design Sizes
      minTextAdapt: true, // 🔥 এটা যোগ করতে হবে
      splitScreenMode: true,
      useInheritedMediaQuery: true, // recommended
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: getAppTheme(context: context, isDarkTheme: false),
          home: child,
        );
      },
      child: OnboardingLayout(),
    );
  }
}
