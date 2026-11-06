import 'package:flutter/material.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class ProfileMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? iconColor;
  final bool isLogout;

  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xff2A2A2F),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: (iconColor ?? AppColor.primaryLight).withValues(
                    alpha: .15,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor ?? AppColor.primaryColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),

              Expanded(
                child: Texts(
                  title,
                  color: isLogout ? AppColor.red : AppColor.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColor.white.withValues(alpha: .35),
                size: 17,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
