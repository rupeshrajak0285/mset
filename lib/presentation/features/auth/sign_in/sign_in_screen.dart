

import 'package:App/presentation/features/auth/sign_in/otp_verification_screen.dart';

import '/common_libraries.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _verificationId;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF9500), Color(0xFFFFCC00)], // Orange → Yellow-Orange
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
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
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFFFF5DA), // light beige
                    hintText: "Phone Number",
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
                    onPressed: isLoading ? null : _sendOTP,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      "Send OTP",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendOTP() async {
    String phone = phoneController.text.trim();
    if (phone.isEmpty) return;
    if (!phone.startsWith('+')) {
      phone = '+91$phone'; // assuming India
    }
    setState(() => isLoading = true);
    print("Sending OTP to: $phone"); // ✅ payload print

    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        print("Auto verification completed: $credential"); // ✅ payload print
        try {
          final userCredential = await _auth.signInWithCredential(credential);
          print(
              "Signed in user: ${userCredential.user?.uid}"); // ✅ payload print
          await _saveUserToFirestore();
          _navigateToHome();
        } catch (e) {
          print("Error during auto sign-in: $e"); // ✅ error print
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() => isLoading = false);
        print(
            "Verification failed: code=${e.code}, message=${e.message}"); // ✅ error print
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Verification Failed: ${e.message}")),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        print(
            "Code sent! verificationId: $verificationId, resendToken: $resendToken"); // ✅ payload print
        setState(() {
          _verificationId = verificationId;
          isLoading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OtpVerificationScreen(
              verificationId: verificationId,
              saveUserCallback: _saveUserToFirestore,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print(
            "Code auto-retrieval timeout: $verificationId"); // ✅ payload print
        _verificationId = verificationId;
        setState(() => isLoading = false);
      },
    );
  }

  Future<void> _saveUserToFirestore() async {
    final user = _auth.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'phoneNumber': user.phoneNumber,
      'createdAt': FieldValue.serverTimestamp(),
      'lastSeen': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const RecentChatScreen()),
    );
  }
}

