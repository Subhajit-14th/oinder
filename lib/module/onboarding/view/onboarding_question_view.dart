import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/module/bottomNavigation/view/bottom_navigation_bar_view.dart';
import 'package:oinder/module/onboarding/provider/onbaording_provider.dart';
import 'package:oinder/module/onboarding/view/onboarding_progress.dart';
import 'package:oinder/module/onboarding/view/question_renderer.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class OnboardingQuestionView extends ConsumerStatefulWidget {
  const OnboardingQuestionView({super.key});

  @override
  ConsumerState<OnboardingQuestionView> createState() =>
      _OnboardingQuestionViewState();
}

class _OnboardingQuestionViewState
    extends ConsumerState<OnboardingQuestionView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(onboardingProvider.notifier).getQuestions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);

    if (state.isLoading) {
      return const Scaffold(
        backgroundColor: AppColor.bodyColor,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.error != null) {
      return Scaffold(
        backgroundColor: AppColor.bodyColor,
        body: Center(
          child: Text(
            state.error!,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    if (state.questions.isEmpty) {
      return const Scaffold(
        backgroundColor: AppColor.bodyColor,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final questions = state.questions;
    final question = questions[state.currentPage];
    final isFirstPage = state.currentPage == 0;
    final isLastPage = state.currentPage == questions.length - 1;
    return Scaffold(
      backgroundColor: AppColor.bodyColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            //-----------------------------------------
            // TOP BAR
            //-----------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      if (isFirstPage) {
                        Navigator.pop(context);
                      } else {
                        notifier.previousPage();
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(6),
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColor.white,
                        size: 32,
                      ),
                    ),
                  ),
                  const SizedBox(width: 28),

                  Expanded(
                    child: OnboardingProgress(
                      current: state.currentPage,
                      total: questions.length,
                    ),
                  ),
                  const SizedBox(width: 14),

                  SizedBox(
                    width: 55,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: question.canSkip
                          ? InkWell(
                              onTap: notifier.nextPage,
                              child: const Texts(
                                "Skip",
                                color: AppColor.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ),
                ],
              ),
            ),

            //-----------------------------------------
            // BODY
            //-----------------------------------------
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 18),

                    //-----------------------------------------
                    // TITLE
                    //-----------------------------------------
                    Texts(
                      question.title,
                      color: AppColor.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                    ),

                    //-----------------------------------------
                    // SUB TITLE
                    //-----------------------------------------
                    if (question.subTitle != null) ...[
                      const SizedBox(height: 18),

                      Texts(
                        question.subTitle!,
                        color: AppColor.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.35,
                      ),
                    ],
                    const SizedBox(height: 34),

                    //-----------------------------------------
                    // QUESTION UI
                    //-----------------------------------------
                    QuestionRenderer(question: question),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),

            //-----------------------------------------
            // BOTTOM BUTTON
            //-----------------------------------------
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(26, 8, 26, 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: state.canContinue
                        ? () async {
                            if (isLastPage) {
                              final answers = state.answers;

                              final personality =
                                  (answers["personality"]
                                      as Map<String, dynamic>?) ??
                                  {};

                              final lifestyle =
                                  (answers["lifestyle"]
                                      as Map<String, dynamic>?) ??
                                  {};

                              final payload = <String, dynamic>{
                                "name": answers["name"],
                                "birthDate": answers["birthday"],
                                "gender": answers["gender"],
                                "sexualOrientation":
                                    answers["orientation"] ?? [],
                                "interestedIn": answers["interestedIn"] ?? [],
                                "relationshipGoals": answers["lookingFor"],
                                "distancePreference":
                                    (state.answers["distance"] as double)
                                        .toInt(),
                                "college": answers["college"],
                                "educationLevel": personality["educationLevel"],
                                "communicationStyle":
                                    personality["communicationStyle"],
                                "loveLanguage": personality["loveLanguage"],
                                "lifestyle": {
                                  "drinking": lifestyle["drinking"],
                                  "smoking": lifestyle["smoking"],
                                  "workout": lifestyle["workout"],
                                  "pets": lifestyle["pets"] ?? [],
                                },
                                "interests": answers["interests"] ?? [],
                                "bio": (answers["bio"] is Map)
                                    ? answers["bio"]["bio"]
                                    : answers["bio"],
                                "photos": answers["photos"] ?? [],
                              };

                              const encoder = JsonEncoder.withIndent("  ");

                              log("========== ONBOARDING PAYLOAD ==========");
                              log(encoder.convert(payload));
                              log("========================================");

                              try {
                                final response = await ref
                                    .read(onboardingSubmitProvider.notifier)
                                    .submit(payload: payload);

                                log(
                                  "========== ONBOARDING RESPONSE ==========",
                                );
                                log(response.toJson().toString());
                                log(
                                  "==========================================",
                                );

                                // TODO:
                                // Navigate to Home Screen here

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const BottomNavigationBarView(),
                                  ),
                                );
                              } catch (e) {
                                log("ONBOARDING ERROR: $e");
                              }
                            }

                            notifier.nextPage();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: state.canContinue
                          ? AppColor.primaryColor
                          : AppColor.grey.withValues(alpha: .35),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: Texts(
                      isLastPage ? "Finish" : "Next",
                      color: state.canContinue ? AppColor.white : AppColor.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
