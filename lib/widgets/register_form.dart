import 'package:day_03_auth_app/widgets/animated_button_widget.dart';
import 'package:day_03_auth_app/widgets/animated_text_field.dart';
import 'package:day_03_auth_app/widgets/glassmorphic_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterForm extends StatelessWidget {
  final PageController? pageController;
  const RegisterForm({super.key, this.pageController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GlassmorphicCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Create new account',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Name Field
                AnimatedTextField(
                  hintText: 'Full Name',
                  prefixIcon: Icons.person_outline,
                  keyboardType: TextInputType.name,
                ),

                const SizedBox(height: 16),

                // Email Field
                AnimatedTextField(
                  hintText: 'Email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 16),

                // Password Field
                AnimatedTextField(
                  hintText: 'Password',
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                ),
                const SizedBox(height: 16),

                // Password Field
                AnimatedTextField(
                  hintText: 'Confirm Password',
                  prefixIcon: Icons.lock_outline,
                  isPassword: true,
                ),

                const SizedBox(height: 24),

                // sign up button
                AnimatedButtonWidget(
                  text: "Sign Up",
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    // handle sing up
                  },
                ),

                const SizedBox(height: 16),

                // login link
                TextButton(
                  onPressed: () {
                    pageController?.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.8),
                      ),
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
