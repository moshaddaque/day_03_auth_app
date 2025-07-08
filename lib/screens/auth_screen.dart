import 'package:day_03_auth_app/widgets/login_form.dart';
import 'package:day_03_auth_app/widgets/page_toggle.dart';
import 'package:day_03_auth_app/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  const AuthScreen({super.key, required this.onThemeToggle});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  late AnimationController _backgroundController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _backgroundAnimation;

  int _currentPage = 0;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
    _backgroundController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _backgroundAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _backgroundController, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _backgroundController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    transform: GradientRotation(
                      _backgroundAnimation.value * 2 * 3.14159,
                    ),
                    colors:
                        isDark
                            ? [
                              const Color(0xFF1E293B),
                              const Color(0xFF334155),
                              const Color(0xFF475569),
                            ]
                            : [
                              const Color(0xFF667EEA),
                              const Color(0xFF764BA2),
                              const Color(0xFFF093FB),
                            ],
                  ),
                ),
              );
            },
          ),

          // Glassmorphic Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors:
                    isDark
                        ? [
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.1),
                        ]
                        : [
                          Colors.white.withOpacity(0.3),
                          Colors.white.withOpacity(0.1),
                        ],
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    // header
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Welcome',
                            style: GoogleFonts.inter(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              widget.onThemeToggle();
                              HapticFeedback.lightImpact();
                            },
                            icon: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: Icon(
                                isDark ? Icons.light_mode : Icons.dark_mode,
                                key: ValueKey(isDark),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Page Toggle
                    PageToggle(
                      pageController: _pageController,
                      currentPage: _currentPage,
                    ),

                    const SizedBox(height: 32),

                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (value) {
                          setState(() {
                            _currentPage = value;
                          });
                          HapticFeedback.lightImpact();
                        },
                        children: [
                          // Login Page
                          LoginForm(),

                          // Register Page
                          RegisterForm(pageController: _pageController),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
