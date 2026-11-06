import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/core/services/auth_provider.dart';
import 'package:oinder/module/profile/provider/profile_provider.dart';
import 'package:oinder/module/splash/view/splash_view.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class DeleteAccountView extends ConsumerStatefulWidget {
  const DeleteAccountView({super.key});

  @override
  ConsumerState<DeleteAccountView> createState() => _DeleteAccountViewState();
}

class _DeleteAccountViewState extends ConsumerState<DeleteAccountView> {
  bool isDeleting = false;

  Future<void> _deleteAccount() async {
    final profile = ref.read(profileProvider).value;
    final userId = profile?.id;
    if (userId == null || userId.isEmpty) {
      AppSnackbar.showError("User id not found");
      return;
    }
    setState(() {
      isDeleting = true;
    });
    try {
      final response = await ref.read(deleteAccountProvider(userId).future);
      if (!mounted) return;
      if (response.success) {
        // await LocalNotificationService.instance.showTestNotification();
        AppSnackbar.showSuccess(response.message);
        // এখানে logout + navigation করবে
        // Example:
        // ref.read(authProvider.notifier).logout();
        await ref.read(authProvider.notifier).logout();

        if (!mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SplashScreen()),
          (route) => false,
        );
      } else {
        AppSnackbar.showError(response.message);
      }
    } catch (e) {
      if (!mounted) return;
      AppSnackbar.showError("Failed to delete account");
    } finally {
      if (mounted) {
        setState(() {
          isDeleting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xff1C1C1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 14, 24, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 55,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(height: 28),

              Center(
                child: Container(
                  width: 78,
                  height: 78,
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: .12),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.delete_forever_rounded,
                    color: Colors.redAccent,
                    size: 40,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              const Center(
                child: Texts(
                  "Delete Account",
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 14),

              Center(
                child: Texts(
                  "Deleting your account is permanent.\nThis action cannot be undone.",
                  textAlign: TextAlign.center,
                  color: Colors.white.withValues(alpha: .7),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 30),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .05),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: .08),
                  ),
                ),
                child: Column(
                  children: const [
                    _DeleteItem(
                      icon: Icons.person_outline,
                      title: "Your profile will be permanently removed",
                    ),
                    SizedBox(height: 16),
                    _DeleteItem(
                      icon: Icons.favorite_border,
                      title: "All matches and likes will be deleted",
                    ),
                    SizedBox(height: 16),
                    _DeleteItem(
                      icon: Icons.chat_bubble_outline,
                      title: "All chats and messages will be erased",
                    ),
                    SizedBox(height: 16),
                    _DeleteItem(
                      icon: Icons.photo_library_outlined,
                      title: "Your uploaded photos will be removed",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: isDeleting ? null : _deleteAccount,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    disabledBackgroundColor: Colors.redAccent.withValues(
                      alpha: .5,
                    ),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: isDeleting
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Texts(
                          "Delete My Account",
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
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

class _DeleteItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _DeleteItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: .10),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.redAccent, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Texts(
            title,
            color: Colors.white.withValues(alpha: .82),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
