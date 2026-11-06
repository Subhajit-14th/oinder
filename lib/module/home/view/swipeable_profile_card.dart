import 'package:flutter/material.dart';
import 'package:oinder/module/home/model/home_profile_model.dart';
import 'package:oinder/module/home/view/home_profile_card.dart';

class SwipeableProfileCard extends StatefulWidget {
  final HomeProfileModel profile;

  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final ValueChanged<double>? onDragging;

  const SwipeableProfileCard({
    super.key,
    required this.profile,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    this.onDragging,
  });

  @override
  State<SwipeableProfileCard> createState() => _SwipeableProfileCardState();
}

class _SwipeableProfileCardState extends State<SwipeableProfileCard>
    with SingleTickerProviderStateMixin {
  Offset _offset = Offset.zero;

  late AnimationController _controller;
  Animation<Offset>? _animation;

  static const double swipeThreshold = 120;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    );

    _controller.addListener(() {
      if (_animation != null) {
        setState(() {
          _offset = _animation!.value;
        });
      }
    });
  }

  // @override
  // void didUpdateWidget(covariant SwipeableProfileCard oldWidget) {
  //   super.didUpdateWidget(oldWidget);

  //   if (oldWidget.profile != widget.profile) {
  //     _controller.stop();

  //     setState(() {
  //       _offset = Offset.zero;
  //       _animation = null;
  //     });
  //   }
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animateTo(Offset endOffset, VoidCallback? onCompleted) {
    _animation = Tween<Offset>(
      begin: _offset,
      end: endOffset,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward(from: 0).then((_) {
      if (!mounted) return;

      setState(() {
        _offset = Offset.zero;
        _animation = null;
      });

      onCompleted?.call();
    });
  }

  void _resetPosition() {
    _animateTo(Offset.zero, null);
  }

  void _handlePanEnd() {
    if (_offset.dx > swipeThreshold) {
      _animateTo(
        Offset(MediaQuery.of(context).size.width * 1.5, _offset.dy),
        widget.onSwipeRight,
      );
    } else if (_offset.dx < -swipeThreshold) {
      _animateTo(
        Offset(-MediaQuery.of(context).size.width * 1.5, _offset.dy),
        widget.onSwipeLeft,
      );
    } else {
      _resetPosition();
    }
  }

  @override
  Widget build(BuildContext context) {
    final angle = _offset.dx * 0.0015;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanUpdate: (details) {
        setState(() {
          _offset += details.delta;
        });

        final progress = (_offset.dx.abs() / 150).clamp(0.0, 1.0);

        widget.onDragging?.call(progress);
      },
      onPanEnd: (_) {
        _handlePanEnd();
      },
      child: Transform.translate(
        offset: _offset,
        child: Transform.rotate(
          angle: angle,
          child: Stack(
            children: [
              ProfileCard(profile: widget.profile),

              ///=========================
              /// LIKE
              ///=========================
              Positioned(
                top: 40,
                left: 25,
                child: Opacity(
                  opacity: (_offset.dx / 120).clamp(0.0, 1.0),
                  child: Transform.rotate(
                    angle: -.35,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "LIKE",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              ///=========================
              /// NOPE
              ///=========================
              Positioned(
                top: 40,
                right: 25,
                child: Opacity(
                  opacity: (-_offset.dx / 120).clamp(0.0, 1.0),
                  child: Transform.rotate(
                    angle: .35,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "NOPE",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
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
}
