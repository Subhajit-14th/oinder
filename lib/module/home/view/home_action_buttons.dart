import 'dart:async';

import 'package:flutter/material.dart';
import 'package:oinder/utils/utils.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onDislike;
  final VoidCallback onLike;
  final VoidCallback onSuperLike;
  final VoidCallback onBoost;

  const ActionButtons({
    super.key,
    required this.onDislike,
    required this.onLike,
    required this.onSuperLike,
    required this.onBoost,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ActionButton(
          icon: Icons.close_rounded,
          iconColor: const Color(0xffFF5B6E),
          backgroundColor: const Color(0xff2C2C31),
          size: 58,
          onTap: onDislike,
        ),

        const SizedBox(width: 16),

        _ActionButton(
          icon: Icons.star_rounded,
          iconColor: const Color(0xff5D8BFF),
          backgroundColor: const Color(0xff2C2C31),
          size: 52,
          onTap: onSuperLike,
        ),

        const SizedBox(width: 16),

        _ActionButton(
          icon: Icons.favorite_rounded,
          iconColor: Colors.white,
          gradient: AppColor.primaryGradient,
          size: 72,
          onTap: onLike,
        ),

        const SizedBox(width: 16),

        BoostButton(onBoost: onBoost),
      ],
    );
  }
}

class BoostButton extends StatefulWidget {
  final VoidCallback onBoost;

  const BoostButton({super.key, required this.onBoost});

  @override
  State<BoostButton> createState() => _BoostButtonState();
}

class _BoostButtonState extends State<BoostButton> {
  Timer? _timer;
  int _remainingSeconds = 1800; // 30 মিনিট = 1800 সেকেন্ড
  bool _isTimerRunning = false;

  void _startTimer() {
    // যদি আগে থেকেই টাইমার চলতে থাকে, তবে নতুন করে শুরু হবে না
    if (_isTimerRunning) return;

    widget.onBoost(); // আপনার মূল অনক্লিক ফাংশন কল হবে

    setState(() {
      _isTimerRunning = true;
      _remainingSeconds = 1800; // ৩০ মিনিট থেকে শুরু
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        // ০ হয়ে গেলে টাইমার বন্ধ হয়ে যাবে এবং টেক্সট হাইড হয়ে যাবে
        _timer?.cancel();
        setState(() {
          _isTimerRunning = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // মেমোরি লিক রোধ করতে পেজ ক্লোজ হলে টাইমার বন্ধ করা
    super.dispose();
  }

  // সেকেন্ডকে MM:SS ফরম্যাটে রূপান্তর করার ফাংশন
  String get _formattedTime {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _ActionButton(
          icon: Icons.flash_on_rounded,
          // টাইমার চললে আইকনটি হালকা হয়ে যাবে যেন টেক্সট ভালো করে দেখা যায়
          iconColor: _isTimerRunning
              ? const Color(0xffF9C846).withValues(alpha: 0.2)
              : const Color(0xffF9C846),
          backgroundColor: const Color(0xff2C2C31),
          size: 52,
          onTap: _startTimer,
        ),

        // টাইমার চললে বাটনের উপরে টেক্সটটি দেখাবে
        if (_isTimerRunning)
          IgnorePointer(
            child: Text(
              _formattedTime,
              style: const TextStyle(
                color: Color(0xffF9C846),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}

class _ActionButton extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final Color? backgroundColor;
  final Gradient? gradient;
  final double size;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.iconColor,
    required this.size,
    required this.onTap,
    this.backgroundColor,
    this.gradient,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => pressed = true);
      },
      onTapUp: (_) {
        setState(() => pressed = false);
        widget.onTap();
      },
      onTapCancel: () {
        setState(() => pressed = false);
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: pressed ? .90 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          height: widget.size,
          width: widget.size,
          decoration: BoxDecoration(
            color: widget.gradient == null ? widget.backgroundColor : null,
            gradient: widget.gradient,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withValues(alpha: .08)),
            boxShadow: [
              BoxShadow(
                color: widget.gradient != null
                    ? AppColor.primaryColor.withValues(alpha: .35)
                    : Colors.black.withValues(alpha: .18),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            widget.icon,
            color: widget.iconColor,
            size: widget.size * .42,
          ),
        ),
      ),
    );
  }
}
