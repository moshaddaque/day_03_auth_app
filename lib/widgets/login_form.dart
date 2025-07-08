import 'package:day_03_auth_app/widgets/animated_button_widget.dart';
import 'package:day_03_auth_app/widgets/animated_text_field.dart';
import 'package:day_03_auth_app/widgets/glassmorphic_card.dart';
import 'package:day_03_auth_app/widgets/social_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GlassmorphicCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Login to your account',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 32),

                // Email Field
                AnimatedTextField(
                  hintText: "Email",
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 16),

                // Password Field
                AnimatedTextField(
                  hintText: "Password",
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                ),

                const SizedBox(height: 16),

                // Button
                AnimatedButtonWidget(
                  text: 'Login',
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                  },
                ),

                const SizedBox(height: 16),
                // Forgot Password
                TextButton(
                  onPressed: () {
                    // Handle forgot password
                  },
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Divider
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.white.withOpacity(0.3),
                        thickness: 1,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'or',
                        style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.white.withOpacity(0.3),
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SocialButton(
                      icon: Icons.g_mobiledata,
                      label: 'Google',
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        // Handle Google login
                      },
                    ),
                    SocialButton(
                      icon: Icons.facebook,
                      label: 'Facebook',
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        // Handle Facebook login
                      },
                    ),
                    SocialButton(
                      icon: Icons.fingerprint,
                      label: 'Biometric',
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        // Handle Biometric login
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
