import 'package:flutter/material.dart';
import 'package:flutter_widget_carosel_slider/gen/assets.gen.dart';

class SignupSuccessDialog extends StatelessWidget {
  const SignupSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Custom Dialog Example")),
      // backgroundColor: Colors.red, // 🔴 bg color red
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              barrierColor: Color(
                0xff0E212B,
              ).withOpacity(0.9), // 🔴 bg color red
              context: context,
              builder: (context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Image
                        Image.asset(
                          Assets.png.onboardingOne.path,

                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(height: 16),

                        // Text
                        const Text(
                          "This is a custom dialog!",
                          style: TextStyle(
                            fontSize: 18,
                            // color: Colors.white, // text white for contrast
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),

                        // Button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Close"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: const Text("Show Dialog"),
        ),
      ),
    );
  }
}
