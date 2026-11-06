import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/module/home/provider/home_provider.dart';
import 'package:oinder/module/preferences/provider/preferences_provider.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class PreferenceBottomSheet extends ConsumerStatefulWidget {
  const PreferenceBottomSheet({super.key});

  @override
  ConsumerState<PreferenceBottomSheet> createState() =>
      _PreferenceBottomSheetState();
}

class _PreferenceBottomSheetState extends ConsumerState<PreferenceBottomSheet> {
  int selectedIntent = -1;
  String? selectedIntentValue;

  double maxDistance = 35;
  RangeValues ageRange = const RangeValues(20, 32);

  bool verifiedOnly = false;

  int selectedGenderIndex = -1;
  String? selectedGenderId;
  String? selectedGenderValue;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final lookingForResponse = await ref.read(
        lookingForYouQuestionProvider.future,
      );

      final preferences = await ref.read(getPreferencesAnswersProvider.future);

      final filters = preferences.filtersApplied;

      if (filters == null || !mounted) return;

      final options = lookingForResponse.data?.options ?? [];

      setState(() {
        maxDistance = (filters.maxDistance ?? 35).toDouble().clamp(1, 100);

        if (filters.minAge != null && filters.maxAge != null) {
          double minAge = filters.minAge!.toDouble().clamp(18, 60);

          double maxAge = filters.maxAge!.toDouble().clamp(18, 60);

          if (minAge > maxAge) {
            final temp = minAge;
            minAge = maxAge;
            maxAge = temp;
          }

          ageRange = RangeValues(minAge, maxAge);
        }

        verifiedOnly = filters.isVerified ?? false;

        /// Gender
        if (filters.interestedIn.isNotEmpty) {
          selectedGenderValue = normalizeGender(filters.interestedIn.first);
        }

        /// Looking For
        selectedIntentValue = filters.lookingFor;

        selectedIntent = options.indexWhere((e) => e.id == filters.lookingFor);

        if (selectedIntent < 0) {
          selectedIntent = -1;
        }
      });
    });
  }

  RangeValues get safeAgeRange {
    double start = ageRange.start.clamp(18, 60).toDouble();
    double end = ageRange.end.clamp(18, 60).toDouble();
    if (start > end) {
      final temp = start;
      start = end;
      end = temp;
    }
    return RangeValues(start, end);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(postPreferencesProvider, (previous, next) {
      next.when(
        loading: () {},
        error: (error, stack) {
          AppSnackbar.showError(error.toString());
        },
        data: (response) async {
          if (response != null) {
            AppSnackbar.showSuccess("Preferences updated successfully");
            ref.invalidate(getPreferencesAnswersProvider);

            await ref.read(homeProfilesProvider.notifier).resetCards();

            Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted) {
                Navigator.pop(context);
              }
            });
          }
        },
      );
    });

    return SafeArea(
      top: false,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xff323236),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ///====================================
            /// Drag Handle
            ///====================================
            const SizedBox(height: 10),

            Container(
              height: 5,
              width: 52,
              decoration: BoxDecoration(
                color: AppColor.white.withValues(alpha: .45),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  const Icon(
                    Icons.tune_rounded,
                    color: Color(0xffCDB4FF),
                    size: 24,
                  ),
                  const SizedBox(width: 10),

                  const Expanded(
                    child: Texts(
                      "Discovery Preferences",
                      color: AppColor.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 38,
                      width: 38,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.close_rounded,
                        color: AppColor.white.withValues(alpha: .75),
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            Divider(height: 1, color: AppColor.white.withValues(alpha: .08)),
            const SizedBox(height: 22),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Texts(
                      "Looking For (Intent)",
                      color: AppColor.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 18),

                    ref
                        .watch(lookingForYouQuestionProvider)
                        .when(
                          loading: () => const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          error: (error, stack) => Center(
                            child: Text(
                              error.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          data: (response) {
                            final options = response.data?.options ?? [];

                            return Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: List.generate(options.length, (index) {
                                final item = options[index];

                                return _intentChip(
                                  item.label ?? "",
                                  index,
                                  item.id ?? "",
                                );
                              }),
                            );
                          },
                        ),
                    const SizedBox(height: 28),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Texts(
                          "Maximum Distance",
                          color: AppColor.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),

                        Texts(
                          "${maxDistance.round()} km",
                          color: const Color(0xffCDB4FF),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 8,
                        activeTrackColor: const Color(0xffCDB4FF),
                        inactiveTrackColor: const Color(0xff4B4858),
                        thumbColor: const Color(0xffCDB4FF),
                        overlayColor: const Color(
                          0xffCDB4FF,
                        ).withValues(alpha: .15),
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 11,
                        ),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 18,
                        ),
                        trackShape: const RoundedRectSliderTrackShape(),
                      ),
                      child: Slider(
                        value: maxDistance,
                        min: 1,
                        max: 100,
                        onChanged: (value) {
                          setState(() {
                            maxDistance = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    ///====================================
                    /// AGE RANGE
                    ///====================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Texts(
                          "Age Range",
                          color: AppColor.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),

                        Texts(
                          "${ageRange.start.round()} - ${ageRange.end.round()}",
                          color: const Color(0xffCDB4FF),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 8,
                        activeTrackColor: const Color(0xffCDB4FF),
                        inactiveTrackColor: const Color(0xff4B4858),
                        thumbColor: const Color(0xffCDB4FF),
                        overlayColor: const Color(
                          0xffCDB4FF,
                        ).withValues(alpha: .15),
                        rangeThumbShape: const RoundRangeSliderThumbShape(
                          enabledThumbRadius: 11,
                        ),
                        overlayShape: const RoundSliderOverlayShape(
                          overlayRadius: 18,
                        ),
                        rangeTrackShape:
                            const RoundedRectRangeSliderTrackShape(),
                      ),
                      child: RangeSlider(
                        values: ageRange,
                        min: 18,
                        max: 60,
                        divisions: 42,
                        labels: RangeLabels(
                          ageRange.start.round().toString(),
                          ageRange.end.round().toString(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            ageRange = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 30),

                    ///====================================
                    /// SHOW ME
                    ///====================================
                    const Texts(
                      "Show Me",
                      color: AppColor.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 18),

                    ref
                        .watch(onboardingQuestionsProvider)
                        .when(
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (error, stack) =>
                              Texts(error.toString(), color: Colors.white),
                          data: (response) {
                            final genderQuestion = response.questions
                                .firstWhere(
                                  (element) => element.stepId == "gender",
                                );
                            final options = genderQuestion.options;
                            return Row(
                              children: List.generate(options.length, (index) {
                                final option = options[index];
                                return Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: index != options.length - 1
                                          ? 10
                                          : 0,
                                    ),
                                    child: _genderChip(
                                      title: _genderLabel(option.id),
                                      value: option.id,
                                      index: index,
                                      icon: _genderIcon(option.id),
                                      id: "${option.optionId}",
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                    const SizedBox(height: 30),

                    ///====================================
                    /// VERIFIED ONLY
                    ///====================================
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff202124),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: AppColor.white.withValues(alpha: .08),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 48,
                            width: 48,
                            decoration: const BoxDecoration(
                              color: Color(0xffCDB4FF),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.verified_rounded,
                              color: Color(0xff3A2756),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),

                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Texts(
                                  "Verified Profiles Only",
                                  color: AppColor.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                SizedBox(height: 4),

                                Texts(
                                  "Show only verified members",
                                  color: Colors.white54,
                                  fontSize: 13,
                                ),
                              ],
                            ),
                          ),

                          Switch(
                            value: verifiedOnly,
                            activeColor: AppColor.white,
                            activeTrackColor: const Color(0xffCDB4FF),
                            inactiveThumbColor: Colors.white70,
                            inactiveTrackColor: const Color(0xff5A5A5A),
                            onChanged: (value) {
                              setState(() {
                                verifiedOnly = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 35),

                    ///====================================
                    /// ACTION BUTTONS
                    ///====================================
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(56),
                              side: BorderSide(
                                color: Colors.white.withValues(alpha: .12),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            child: const Texts(
                              "Reset",
                              color: AppColor.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),

                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 56,
                            child: ElevatedButton(
                              onPressed: () async {
                                final response = ref
                                    .read(lookingForYouQuestionProvider)
                                    .value;

                                final options = response?.data?.options ?? [];

                                final payload = {
                                  "lookingFor":
                                      (selectedIntent >= 0 &&
                                          selectedIntent < options.length)
                                      ? (options[selectedIntent].id ?? "")
                                      : (selectedIntentValue ?? ""),
                                  "interestedIn": selectedGenderId,
                                  "minAge": ageRange.start.round(),
                                  "maxAge": ageRange.end.round(),
                                  "maxDistance": maxDistance.round(),
                                  "isVerified": verifiedOnly,
                                };

                                log("Preference Payload: $payload");

                                await ref
                                    .read(postPreferencesProvider.notifier)
                                    .submitPreferences(answers: payload);

                                // final apiState = ref.read(
                                //   postPreferencesProvider,
                                // );

                                // apiState.when(
                                //   data: (response) {
                                //     if (response != null) {
                                //       log(
                                //         "Preference Success Users: ${response.users.length}",
                                //       );
                                //       Navigator.pop(context);
                                //     }
                                //   },
                                //   loading: () {
                                //     log("Preference API Loading");
                                //   },
                                //   error: (error, stack) {
                                //     log("Preference API Error: $error");
                                //   },
                                // );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffCDB4FF),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: const Texts(
                                "Apply Preferences",
                                color: Color(0xff2D2145),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _genderLabel(String value) {
    switch (value) {
      case "Woman":
        return "Women";
      case "Man":
        return "Men";
      case "Beyond Binary":
        return "Everyone";
      default:
        return value;
    }
  }

  IconData _genderIcon(String value) {
    switch (value) {
      case "Woman":
        return Icons.female_rounded;
      case "Man":
        return Icons.male_rounded;
      case "Beyond Binary":
        return Icons.groups_rounded;
      default:
        return Icons.person;
    }
  }

  Widget _intentChip(String title, int index, String value) {
    final selected = selectedIntentValue == value;
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        setState(() {
          selectedIntent = index;
          selectedIntentValue = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xffCDB4FF) : const Color(0xff202124),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Texts(
          title,
          color: selected ? const Color(0xff33214A) : AppColor.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _genderChip({
    required String title,
    required int index,
    required IconData icon,
    required String value,
    required String id,
  }) {
    final isSelected = selectedGenderValue == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGenderIndex = index;
          selectedGenderValue = value;
          selectedGenderId = id;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColor.primaryColor : Colors.grey.shade300,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.grey),

            const SizedBox(height: 6),

            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String normalizeGender(String value) {
    switch (value) {
      case "Men":
        return "Man";

      case "Women":
        return "Woman";

      case "Everyone":
        return "Beyond Binary";

      default:
        return value;
    }
  }
}
