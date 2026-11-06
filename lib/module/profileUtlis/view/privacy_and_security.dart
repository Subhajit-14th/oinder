import 'package:flutter/material.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class PrivacyAndSecurity extends StatefulWidget {
  const PrivacyAndSecurity({super.key});

  @override
  State<PrivacyAndSecurity> createState() => _PrivacyAndSecurityState();
}

class _PrivacyAndSecurityState extends State<PrivacyAndSecurity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bodyColor,
      appBar: AppBar(
        backgroundColor: AppColor.bodyColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColor.white),
        ),
        title: const Texts(
          "Privacy & Security",
          color: AppColor.white,
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [Color(0xff9C6CFF), Color(0xff6D3DDB)],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.shield_outlined, color: AppColor.white, size: 42),
                  SizedBox(height: 18),

                  Texts(
                    "Your Privacy Comes First",
                    color: AppColor.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 10),

                  Texts(
                    "We're committed to protecting your personal information and providing a safe experience while using Oinder.",
                    color: Colors.white70,
                    height: 1.5,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            _buildInfoCard(
              icon: Icons.verified_user_outlined,
              color: Colors.green,
              title: "Your Privacy",
              description:
                  "Your personal information is protected using modern encryption and secure storage. We never share your private information without your permission.",
            ),
            const SizedBox(height: 16),

            _buildInfoCard(
              icon: Icons.location_on_outlined,
              color: Colors.orange,
              title: "Location Privacy",
              description:
                  "Your approximate location helps you discover nearby matches. Your exact address or live location is never shown to other users.",
            ),
            const SizedBox(height: 16),

            _buildInfoCard(
              icon: Icons.chat_bubble_outline,
              color: Colors.blue,
              title: "Messages & Chats",
              description:
                  "Your conversations stay private between you and your matches. Never share banking details, passwords or sensitive personal information.",
            ),
            const SizedBox(height: 16),

            _buildInfoCard(
              icon: Icons.photo_library_outlined,
              color: Colors.purple,
              title: "Photos & Media",
              description:
                  "Your uploaded photos are securely stored and used only within your profile. Images that violate our Community Guidelines may be removed to help keep Oinder safe for everyone.",
            ),
            const SizedBox(height: 16),

            _buildInfoCard(
              icon: Icons.lock_outline,
              color: Colors.teal,
              title: "Account Security",
              description:
                  "Protect your account by using a strong password and keeping your login credentials private. Never share verification codes or passwords with anyone.",
            ),
            const SizedBox(height: 16),

            _buildInfoCard(
              icon: Icons.gpp_good_outlined,
              color: Colors.indigo,
              title: "Data Protection",
              description:
                  "Your information is stored securely and processed in accordance with our Privacy Policy. We are committed to protecting your personal data and respecting your privacy.",
            ),
            const SizedBox(height: 16),

            _buildInfoCard(
              icon: Icons.block_outlined,
              color: Colors.redAccent,
              title: "Blocking & Reporting",
              description:
                  "If someone makes you feel uncomfortable, you can block or report them. Every report is reviewed by our moderation team to help maintain a respectful community.",
            ),
            const SizedBox(height: 16),

            _buildInfoCard(
              icon: Icons.health_and_safety_outlined,
              color: Colors.orange,
              title: "Safety Reminder",
              description:
                  "For your safety, always meet in public places, let a trusted friend know your plans, and trust your instincts if something doesn't feel right.",
            ),
            const SizedBox(height: 16),

            _buildInfoCard(
              icon: Icons.support_agent_outlined,
              color: Colors.green,
              title: "Need Help?",
              description:
                  "If you have questions about your privacy, security or account, our support team is available to assist you whenever you need help.",
            ),
            const SizedBox(height: 24),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xff2B2538),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: const Color(0xff9C6CFF).withOpacity(.25),
                ),
              ),
              child: Column(
                children: const [
                  Icon(Icons.favorite, color: Color(0xff9C6CFF), size: 38),
                  SizedBox(height: 14),
                  Texts(
                    "Your Trust Matters",
                    textAlign: TextAlign.center,
                    color: AppColor.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 10),

                  Texts(
                    "Our goal is to provide a secure, respectful and enjoyable dating experience. We're continuously improving our safety systems to protect our community.",
                    textAlign: TextAlign.center,
                    color: Colors.white60,
                    height: 1.6,
                    fontSize: 15,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color color,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xff24262B),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color.withValues(alpha: .15),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Texts(
                  title,
                  color: AppColor.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                const SizedBox(height: 8),

                Texts(
                  description,
                  color: Colors.white60,
                  fontSize: 14,
                  height: 1.6,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
