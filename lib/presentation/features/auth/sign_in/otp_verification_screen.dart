import 'package:firebase_auth/firebase_auth.dart';

import '../../../../common_libraries.dart';
import '../../dashboard_page/home_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String verificationId;
  final Future<void> Function() saveUserCallback;

  const OtpVerificationScreen({
    super.key,
    required this.verificationId,
    required this.saveUserCallback,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController otpController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/fawry24.jpeg", // transparent background wali PNG rakho
                  height: 100,
                ),
              ),
              const SizedBox(height: 20),

              // App Name
              const Text(
                "Fawry24",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              // Phone Number Input
              // Phone Number Input
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: otpController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFFFF5DA), // light beige
                    hintText: "Enter OTP",
                    hintStyle: const TextStyle(color: Colors.black54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              // Send OTP Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity, // full width
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF007BFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 17),
                    ),
                    onPressed: isLoading ? null : _verifyOTP,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("VERIFY OTP"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _verifyOTP() async {
    String smsCode = otpController.text.trim();
    if (smsCode.isEmpty) return;

    setState(() => isLoading = true);

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: smsCode,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      await widget.saveUserCallback();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid OTP")),
      );
    }
  }
}
