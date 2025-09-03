import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';
import '../../core/config/app_color.dart';
import '../../core/config/app_text_style.dart';
import '../../widgets/custom_form_builder_dropdown.dart';
import '../../widgets/custom_text_field_with_heading.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController passwordController = TextEditingController();
  bool showPass = false;

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyle(context);

    return Scaffold(
      backgroundColor: colors(context).background,
      appBar: AppBar(
        title: Text("My profile", style: style.appBarText18Medium),
        elevation: 0,
        backgroundColor: colors(context).background,
        actions: [
          Icon(Icons.notifications_none, color: AppColor.dark, size: 24.sp),
          Gap(16.w),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              /// Avatar
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CircleAvatar(
                    radius: 55.r,
                    backgroundImage: const NetworkImage(
                        "https://i.pravatar.cc/300"), // demo image
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(6.r),
                    child: Icon(Icons.edit, color: Colors.white, size: 18.sp),
                  )
                ],
              ),
              Gap(20.h),

              /// Email (read-only)
              CustomTextFieldWithHeading(
                textFieldName: 'email',
                hintText: "Email",
                enabled: false,
                initialValue: "name@gmail.com",
              ),
              Gap(16.h),

              /// Name
              CustomTextFieldWithHeading(
                textFieldName: 'name',
                hintText: "Name",
                initialValue: "Jhenyfer Santos",
              ),
              Gap(16.h),

              /// DOB
              CustomTextFieldWithHeading(
                textFieldName: 'dob',
                hintText: "Date of birth",
                initialValue: "April 12, 1999",
              ),
              Gap(16.h),

              /// Gender dropdown
              CustomFormBuilderDropdown(
                formKey: _formKey,
                name: 'gender',
                items: ['Male', 'Female', 'Other'],
                hintText: "Gender",
                validatorText: "Gender is required",
              ),
              Gap(16.h),

              /// Password
              CustomTextFieldWithHeading(
                textFieldName: 'password',
                controller: passwordController,
                obscureText: !showPass,
                hintText: "Password",
                textInputAction: TextInputAction.done,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      showPass = !showPass;
                    });
                  },
                  child: Icon(
                    showPass
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColor.dark.withValues(alpha: 0.8),
                  ),
                ),
              ),
              Gap(16.h),

              /// Language dropdown
              CustomFormBuilderDropdown(
                formKey: _formKey,
                name: 'language',
                items: ['English', 'Spanish', 'French'],
                initialValue: "English",
                hintText: "Language",
              ),
              Gap(24.h),

              /// Save button
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
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      debugPrint("Profile Saved: ${_formKey.currentState?.value}");
                    }
                  },
                  child: Text("Save",
                      style: style.buttonText16Bold.copyWith(
                        color: Colors.white,
                      )),
                ),
              ),
              Gap(24.h),

              /// Bottom actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _bottomAction(Icons.privacy_tip_outlined, "Privacy policy"),
                  _bottomAction(Icons.delete_outline, "Delete account"),
                  _bottomAction(Icons.logout, "Logout"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomAction(IconData icon, String label) {
    final style = AppTextStyle(context);
    return Column(
      children: [
        Icon(icon, size: 24.sp, color: AppColor.dark),
        Gap(4.h),
        Text(label, style: style.bodyTextSmall12Medium),
      ],
    );
  }
}
