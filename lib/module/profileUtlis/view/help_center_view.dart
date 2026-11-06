import 'package:flutter/material.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class HelpCenterView extends StatefulWidget {
  const HelpCenterView({super.key});

  @override
  State<HelpCenterView> createState() => _HelpCenterViewState();
}

class _HelpCenterViewState extends State<HelpCenterView> {
  final List<HelpCategory> categories = [
    HelpCategory(
      title: "Account",
      subtitle: "Login, profile & settings",
      icon: Icons.person_outline_rounded,
      color: Colors.blue,
    ),
    HelpCategory(
      title: "Safety",
      subtitle: "Report & stay protected",
      icon: Icons.shield_outlined,
      color: Colors.green,
    ),
    HelpCategory(
      title: "Subscription",
      subtitle: "Premium & payments",
      icon: Icons.workspace_premium_outlined,
      color: Colors.orange,
    ),
    HelpCategory(
      title: "Messages",
      subtitle: "Chat & match issues",
      icon: Icons.chat_bubble_outline,
      color: Colors.purple,
    ),
  ];

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
          "Help Center",
          color: AppColor.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
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
                  colors: [Color(0xff9C6CFF), Color(0xff6C3BDA)],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.support_agent, color: AppColor.white, size: 42),
                  SizedBox(height: 16),

                  Texts(
                    "How can we help?",
                    color: AppColor.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  SizedBox(height: 10),

                  Texts(
                    "Find answers to common questions or browse support categories below.",
                    color: Colors.white70,
                    height: 1.5,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),

            const Texts(
              "Browse Categories",
              color: AppColor.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            const SizedBox(height: 16),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: .95,
              ),
              itemBuilder: (context, index) {
                final item = categories[index];

                return Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xff24262B),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: item.color.withValues(alpha: .15),
                        child: Icon(item.icon, color: item.color),
                      ),
                      const Spacer(),

                      Texts(
                        item.title,
                        color: AppColor.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                      const SizedBox(height: 6),

                      Texts(item.subtitle, color: Colors.white60, fontSize: 13),
                    ],
                  ),
                );
              },
            ),

            const Texts(
              "Frequently Asked Questions",
              color: AppColor.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 18),

            _buildFaqCard(
              "How do I change my profile information?",
              "Go to Profile > Edit Profile to update your personal information, photos and interests.",
            ),
            const SizedBox(height: 14),

            _buildFaqCard(
              "Why can't I send messages?",
              "Messaging is available only after you and another user have matched with each other.",
            ),
            const SizedBox(height: 14),

            _buildFaqCard(
              "How do I report someone?",
              "Open the user's profile, tap the menu icon and select Report User. Our moderation team will review the report.",
            ),
            const SizedBox(height: 14),

            _buildFaqCard(
              "How can I delete my account?",
              "Go to Settings > Account > Delete Account. Please note that this action is permanent.",
            ),
            const SizedBox(height: 16),

            const Texts(
              "Contact Support",
              color: AppColor.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 18),

            _buildSupportCard(
              icon: Icons.email_outlined,
              color: Colors.blue,
              title: "Email Support",
              subtitle: "support@oinder.com",
            ),
            const SizedBox(height: 14),

            _buildSupportCard(
              icon: Icons.chat_bubble_outline,
              color: Colors.green,
              title: "Live Chat",
              subtitle: "Chat with our support team",
            ),
            const SizedBox(height: 14),

            _buildSupportCard(
              icon: Icons.phone_outlined,
              color: Colors.orange,
              title: "Call Support",
              subtitle: "+91 98765 43210",
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqCard(String title, String description) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xff24262B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Texts(
            title,
            color: AppColor.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 10),

          Texts(description, color: Colors.white60, height: 1.5, fontSize: 15),
        ],
      ),
    );
  }

  Widget _buildSupportCard({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xff24262B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color.withOpacity(.15),
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
                  fontSize: 17,
                ),
                const SizedBox(height: 6),

                Texts(subtitle, color: Colors.white60, fontSize: 14),
              ],
            ),
          ),

          const Icon(Icons.chevron_right_rounded, color: Colors.white38),
        ],
      ),
    );
  }
}

class HelpCategory {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  HelpCategory({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}
