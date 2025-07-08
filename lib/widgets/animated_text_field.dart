import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedTextField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final bool showPasswordStrength;
  final TextInputType keyboardType;
  const AnimatedTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.showPasswordStrength = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<AnimatedTextField> createState() => _AnimatedTextFieldState();
}

class _AnimatedTextFieldState extends State<AnimatedTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _isObscure = true;
  double _passwordStrength = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _colorAnimation = ColorTween(
      begin: Colors.white.withOpacity(0.1),
      end: Colors.white.withOpacity(0.2),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });

      if (_focusNode.hasFocus) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });

    if (widget.showPasswordStrength) {
      _textController.addListener(() {
        _calculatePasswordStrength();
      });
    }
  }

  void _calculatePasswordStrength() {
    final password = _textController.text;
    double strength = 0.0;

    if (password.length >= 8) strength += 0.25;
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.25;
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.25;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 0.25;

    setState(() {
      _passwordStrength = strength;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: _colorAnimation.value,
                  border: Border.all(
                    width: _isFocused ? 2 : 1,
                    color:
                        _isFocused
                            ? Colors.white.withOpacity(0.5)
                            : Colors.white.withOpacity(0.2),
                  ),
                  boxShadow:
                      _isFocused
                          ? [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.2),
                              blurRadius: 20,
                              spreadRadius: 0,
                            ),
                          ]
                          : [],
                ),
                child: TextField(
                  controller: _textController,
                  focusNode: _focusNode,
                  obscureText: widget.isPassword && _isObscure,
                  keyboardType: widget.keyboardType,
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 16),

                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.6),
                    ),
                    prefixIcon: Icon(
                      widget.prefixIcon,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    suffixIcon:
                        widget.isPassword
                            ? IconButton(
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.white.withOpacity(0.7),
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            )
                            : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),
            );
          },
        ),

        // Password Strength Indicator
        if (widget.showPasswordStrength && _textController.text.isNotEmpty) ...[
          const SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: _passwordStrength,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _passwordStrength < 0.5
                        ? Colors.red
                        : _passwordStrength < 0.75
                        ? Colors.orange
                        : Colors.green,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                _passwordStrength < 0.5
                    ? 'Weak'
                    : _passwordStrength < 0.75
                    ? 'Medium'
                    : 'Strong',
                style: GoogleFonts.inter(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
