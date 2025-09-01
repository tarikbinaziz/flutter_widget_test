import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_carosel_slider/config/app_color.dart';
import 'package:flutter_widget_carosel_slider/config/app_logo.dart';
import 'package:flutter_widget_carosel_slider/config/app_text_style.dart';
import 'package:flutter_widget_carosel_slider/config/custom_button.dart';
import 'package:flutter_widget_carosel_slider/config/hive_service_provider.dart';
import 'package:flutter_widget_carosel_slider/config/theme.dart';
import 'package:flutter_widget_carosel_slider/gen/assets.gen.dart';
import 'package:flutter_widget_carosel_slider/onboarding/controller/onboarding_controller.dart';
import 'package:gap/gap.dart';

class OnboardingLayout extends ConsumerStatefulWidget {
  const OnboardingLayout({super.key});

  @override
  ConsumerState<OnboardingLayout> createState() => _OnboardingLayoutState();
}

class _OnboardingLayoutState extends ConsumerState<OnboardingLayout> {
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      int? newPage = pageController.page?.round();
      if (newPage != ref.read(currentPageController)) {
        setState(() {
          ref.read(currentPageController.notifier).state = newPage!;
        });
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ).copyWith(top: 40.h, bottom: 20.h),
        child: Column(
          children: [
            const AppLogo(isAnimation: true),
            Gap(30.h),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: onboardingItems.length,
                onPageChanged: (page) {
                  if (page == 2 && !ref.read(isOnboardingLastPage)) {
                    ref.read(isOnboardingLastPage.notifier).state = true;
                  } else if (ref.read(isOnboardingLastPage)) {
                    ref.read(isOnboardingLastPage.notifier).state = false;
                  }
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Image.asset(
                          onboardingItems[index]['image'],
                          height: MediaQuery.of(context).size.height / 2.5.h,
                          width: 280.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Gap(30.h),
                      Text(
                        onboardingItems[index]['title'],
                        style: AppTextStyle(context).title.copyWith(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(20.h),
                      Text(
                        onboardingItems[index]['description'],
                        style: AppTextStyle(
                          context,
                        ).bodyTextSmall.copyWith(fontSize: 16.sp),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child:
                  ref.watch(isOnboardingLastPage)
                      ? AbsorbPointer(
                        absorbing: !ref.read(isOnboardingLastPage),
                        child: CustomButton(
                          key: ValueKey<int>(2),
                          buttonText: 'Procced Next',
                          buttonColor:
                              ref.read(isOnboardingLastPage)
                                  ? colors(context).primaryColor
                                  : ColorTween(
                                    begin: colors(context).primaryColor,
                                    end: colors(context).light,
                                  ).lerp(0.5),
                          onPressed: () {
                            ref
                                .read(hiveServiceProvider)
                                .setFirstOpenValue(value: true);
                            // context.nav.pushNamedAndRemoveUntil(
                            //     Routes.getCoreRouteName(
                            //         AppConstants.appServiceName),
                            //     (route) => false);
                          },
                        ),
                      )
                      : SizedBox(
                        height: 50.h,
                        child: Row(
                          key: ValueKey<int>(1),
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              List.generate(
                                3,
                                (index) => AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        ref
                                                    .read(
                                                      currentPageController
                                                          .notifier,
                                                    )
                                                    .state ==
                                                index
                                            ? colors(context).primaryColor
                                            : EcommerceAppColor.lightGray,
                                    borderRadius: BorderRadius.circular(30.sp),
                                  ),
                                  height: 8.h,
                                  width:
                                      ref
                                                  .read(
                                                    currentPageController
                                                        .notifier,
                                                  )
                                                  .state ==
                                              index
                                          ? 26
                                          : 8.w,
                                ),
                              ).toList(),
                        ),
                      ),
            ),

            Gap(24.h),
          ],
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> onboardingItems = [
    {
      'image': Assets.png.onboardingOne.path,
      'title': 'Tap, earn, enjoy',
      'description':
          'Just tap your phone on our LOOPI at partner locations to check in and collect stamps.',
    },
    {
      'image': Assets.png.onboardingTwo.path,
      'title': 'Discover local favorites',
      'description':
          'Find cafés, gyms, restaurants, bars and more — all near you and ready to reward your loyalty.',
    },
    {
      'image': Assets.png.onboardingThree.path,
      'title': 'Earn rewards for living your routine',
      'description':
          'Give quick feedback, unlock missions, and climb the LOOPI ranks while supporting great places.',
    },
  ];
}
