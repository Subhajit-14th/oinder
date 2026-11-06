import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oinder/module/edirProfile/provider/edit_profile_provider.dart';
import 'package:oinder/module/onboarding/model/onbaording_question_api_response_model.dart';
import 'package:oinder/module/profile/model/get_profile_api_response_model.dart';
import 'package:oinder/module/profile/provider/profile_provider.dart';
import 'package:oinder/utils/utils.dart';
import 'package:oinder/widget/widget.dart';

class EditProfileView extends ConsumerStatefulWidget {
  const EditProfileView({super.key});

  @override
  ConsumerState<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  final Map<String, TextEditingController> controllers = {};
  final Map<String, dynamic> answers = {};
  bool isProfileLoaded = false;

  TextEditingController _getController(String key) {
    if (!controllers.containsKey(key)) {
      controllers[key] = TextEditingController(
        text: answers[key]?.toString() ?? "",
      );
    }
    return controllers[key]!;
  }

  void _prefillProfileData(UserProfileModel profile) {
    answers.clear();

    answers["name"] = profile.fullname ?? profile.name ?? "";

    final birthday =
        profile.birthday ??
        profile.dateOfBirth ??
        profile.dateOfBirthSnake ??
        profile.dob ??
        profile.bday ??
        profile.bDay ??
        (profile.birthDate != null
            ? profile.birthDate!.toIso8601String().split("T").first
            : "");

    // birthday সব possible key-তে set করে রাখছি
    answers["birthday"] = birthday;
    answers["birthDate"] = birthday;
    answers["dateOfBirth"] = birthday;
    answers["date_of_birth"] = birthday;
    answers["dob"] = birthday;
    answers["bday"] = birthday;
    answers["b_day"] = birthday;

    answers["gender"] = profile.gender ?? "";

    answers["showGenderOnProfile"] = profile.showGenderOnProfile ?? true;

    answers["orientation"] = List<String>.from(profile.sexualOrientation ?? []);

    answers["showOrientationOnProfile"] =
        profile.showOrientationOnProfile ?? false;

    answers["interestedIn"] = List<String>.from(profile.interestedIn ?? []);

    // Education
    answers["college"] = profile.college ?? "";
    answers["educationLevel"] = profile.educationLevel ?? "";

    answers["lookingFor"] = profile.relationshipGoals ?? "";

    answers["distance"] = profile.distancePreference ?? 80;

    answers["college"] = profile.college ?? "";

    answers["communicationStyle"] = profile.communicationStyle ?? "";

    answers["loveLanguage"] = profile.loveLanguage ?? "";

    answers["drinking"] = profile.lifestyle?.drinking ?? "";

    answers["smoking"] = profile.lifestyle?.smoking ?? "";

    answers["workout"] = profile.lifestyle?.workout ?? "";

    answers["pets"] = List<String>.from(profile.lifestyle?.pets ?? []);

    answers["interests"] = List<String>.from(profile.interests ?? []);

    answers["bio"] = profile.bio ?? "";

    answers["photos"] = List<String>.from(profile.photos ?? []);

    // IMPORTANT FIX
    controllers.clear();

    for (final entry in answers.entries) {
      if (entry.value is String) {
        controllers[entry.key] = TextEditingController(
          text: entry.value.toString(),
        );
      }
    }

    log("Prefilled Answers => $answers");

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final questions = ref.watch(editProfileQuestionsProvider);
    final profile = ref.watch(profileProvider);
    return Scaffold(
      backgroundColor: AppColor.bodyColor,
      body: SafeArea(
        child: questions.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Texts("Something went wrong", color: AppColor.white),
          ),
          data: (response) {
            for (final q in response.questions) {
              log("${q.title} ---> ${q.stepId}");
            }
            profile.whenData((profileData) {
              log("EDIT PROFILE USER => ${profileData.toJson()}");
              if (!isProfileLoaded) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _prefillProfileData(profileData);

                  isProfileLoaded = true;
                });
              }
            });
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  _buildHeader(),
                  const SizedBox(height: 30),

                  const Texts(
                    "Edit Profile",
                    color: AppColor.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(height: 20),

                  ...response.questions.map(
                    (question) => Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: _buildQuestion(question),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColor.white,
            size: 18,
          ),
        ),
        const SizedBox(width: 12),

        const Expanded(
          child: Texts(
            "Edit Profile",
            color: AppColor.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),

        SizedBox(
          width: 100,
          height: 45,
          child: ElevatedButton(
            onPressed: () async {
              final payload = {
                "firstName": answers["firstName"] ?? answers["name"] ?? "",
                "lastName": answers["lastName"] ?? "",

                "bday": answers["birthday"] ?? "",

                "gender": answers["gender"] ?? "",

                "showGenderOnProfile": answers["showGenderOnProfile"] ?? true,

                "sexualOrientation": List<String>.from(
                  answers["orientation"] ?? [],
                ),

                "showOrientationOnProfile":
                    answers["showOrientationOnProfile"] ?? true,

                "intrest": List<String>.from(answers["interestedIn"] ?? []),

                "whatHeLookingFor":
                    answers["relationshipGoals"] ?? answers["lookingFor"] ?? "",

                "distancePrefrences": (answers["distance"] ?? 80).toInt(),

                "ifStudyingIsYourThing": answers["college"] ?? "",

                "communicationStyle": answers["communicationStyle"] ?? "",

                "howDoYouReceiveLove": answers["loveLanguage"] ?? "",

                "educationLevel": answers["educationLevel"] ?? "",

                "howOftenDoYouDrink": answers["drinking"] ?? "",

                "howOftenDoYouSmoke": answers["smoking"] ?? "",

                "doYouWorkout": answers["workout"] ?? "",

                "doHaveAnyPets": List<String>.from(answers["pets"] ?? []),

                "whatAreYouInto": List<String>.from(answers["interests"] ?? []),

                "fanFavorites": List<String>.from(
                  answers["fanFavorites"] ?? [],
                ),

                "foodAndDrinks": List<String>.from(
                  answers["foodAndDrinks"] ?? [],
                ),

                "gaming": List<String>.from(answers["gaming"] ?? []),

                "moreAboutYourSelf": answers["bio"] ?? "",
              };

              try {
                final response = await ref
                    .read(editProfileProvider.notifier)
                    .updateProfile(profileData: payload);

                if (mounted) {
                  Navigator.pop(context);
                }

                if (response.success == true) {
                  AppSnackbar.showSuccess(
                    response.message ?? "Profile updated successfully",
                  );

                  ref.invalidate(profileProvider);
                } else {
                  AppSnackbar.showError(
                    response.message ?? "Something went wrong",
                  );
                }
              } catch (e) {
                if (mounted) {
                  Navigator.pop(context);
                }

                AppSnackbar.showError(e.toString());
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            child: const Texts(
              "Save",
              color: AppColor.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestion(OnboardingQuestion question) {
    switch (question.type) {
      case "text":
        return _buildTextQuestion(question);

      case "date":
        return _buildDateQuestion(question);

      case "single_select":
        return _buildSingleSelectQuestion(question);

      case "multi_select":
        return _buildMultiSelectQuestion(question);

      case "single_select_cards":
        return _buildDropdownQuestion(question);

      case "slider":
        return _buildSliderQuestion(question);

      case "multi_group_select":
        return _buildMultiGroupSelectQuestion(question);

      case "multi_select_tags":
        return _buildMultiSelectTagsQuestion(question);

      case "bio_and_prompts":
        return _buildBioQuestion(question);

      default:
        return const SizedBox();
    }
  }

  Widget _buildTextQuestion(OnboardingQuestion question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Texts(
          question.title,
          color: AppColor.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),

        if (question.subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Texts(
              question.subtitle!,
              color: Colors.white54,
              fontSize: 13,
            ),
          ),
        const SizedBox(height: 12),

        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white24),
            borderRadius: BorderRadius.circular(22),
          ),
          child: TextField(
            controller: _getController(question.stepId),
            style: Styles.textStyle(color: AppColor.white, fontSize: 16),
            onChanged: (value) {
              answers[question.stepId] = value;
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateQuestion(OnboardingQuestion question) {
    final selectedDate = answers[question.stepId] != null
        ? DateTime.tryParse(answers[question.stepId])
        : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Texts(
          question.title,
          color: AppColor.white,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 12),

        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1950),
              lastDate: DateTime.now(),
              initialDate: selectedDate ?? DateTime(2000),
            );
            if (date != null) {
              answers[question.stepId] = date
                  .toIso8601String()
                  .split("T")
                  .first;
              setState(() {});
            }
          },
          child: Container(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white24),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Texts(
                  answers[question.stepId] ?? "Select Date",
                  color: AppColor.white,
                ),
                const Icon(Icons.calendar_month, color: AppColor.white),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSingleSelectQuestion(OnboardingQuestion question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (question.toggleField != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Texts(question.toggleField!.label, color: AppColor.white),

              Switch(
                value:
                    answers[question.toggleField!.name] ??
                    question.toggleField!.defaultValue,
                onChanged: (value) {
                  setState(() {
                    answers[question.toggleField!.name] = value;
                  });
                },
              ),
            ],
          ),
        const SizedBox(height: 12),

        Texts(
          question.title,
          color: AppColor.white,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 12),

        InkWell(
          onTap: () {
            _showDropdownSheet(question);
          },
          child: Container(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white24),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Texts(
                  answers[question.stepId] ?? "Select",
                  color: AppColor.white,
                ),

                const Icon(Icons.keyboard_arrow_down, color: AppColor.white),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMultiSelectQuestion(OnboardingQuestion question) {
    final selected = List<String>.from(answers[question.stepId] ?? []);

    log("STEP => ${question.stepId}");
    log("SELECTED => $selected");

    for (final e in question.options) {
      log("OPTION => id=${e.id} label=${e.label}");
    }

    bool isSelected(OnboardingOption option) {
      String normalize(String value) {
        value = value.toLowerCase().trim();

        switch (value) {
          case "woman":
            return "women";

          case "man":
            return "men";

          default:
            return value;
        }
      }

      return selected.any(
        (e) =>
            normalize(e) == normalize(option.id) ||
            normalize(e) == normalize(option.label),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Texts(
          question.title,
          color: AppColor.white,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 12),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: question.options.map((option) {
            final active = isSelected(option);
            return InkWell(
              splashColor: AppColor.transparent,
              onTap: () {
                setState(() {
                  if (active) {
                    selected.removeWhere(
                      (e) =>
                          e.toLowerCase().trim() ==
                              option.id.toLowerCase().trim() ||
                          e.toLowerCase().trim() ==
                              option.label.toLowerCase().trim(),
                    );
                  } else {
                    selected.add(option.label);
                  }

                  answers[question.stepId] = selected;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: active ? AppColor.primaryColor : AppColor.transparent,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: active ? AppColor.transparent : Colors.white24,
                  ),
                ),
                child: Texts(
                  option.label,
                  color: active ? AppColor.black : AppColor.white,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDropdownQuestion(OnboardingQuestion question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Texts(
          question.title,
          color: AppColor.white,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 12),

        InkWell(
          onTap: () {
            _showDropdownSheet(question);
          },
          child: Container(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white24),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Texts(
                  answers[question.stepId] ?? "Select",
                  color: AppColor.white,
                ),
                const Icon(Icons.keyboard_arrow_down, color: AppColor.white),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSliderQuestion(OnboardingQuestion question) {
    final double value =
        (answers[question.stepId] ?? question.sliderConfig!.defaultValue)
            .toDouble();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Texts(
          question.title,
          color: AppColor.white,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 15),

        Slider(
          min: question.sliderConfig!.min,
          max: question.sliderConfig!.max,
          value: value,
          onChanged: (v) {
            setState(() {
              answers[question.stepId] = v;
            });
          },
        ),
        Center(
          child: Texts(
            "${value.toInt()} ${question.sliderConfig!.unit}",
            color: AppColor.white,
          ),
        ),
      ],
    );
  }

  Widget _buildMultiGroupSelectQuestion(OnboardingQuestion question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Texts(
          question.title,
          color: AppColor.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),

        if (question.subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Texts(
              question.subtitle!,
              color: Colors.white54,
              fontSize: 13,
            ),
          ),
        const SizedBox(height: 20),

        ...question.groups!.map((group) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Texts(
                  group.title,
                  color: AppColor.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 10),

                if (group.type == "single")
                  _buildGroupDropdown(question, group.id, group.options)
                else
                  _buildGroupMultiSelect(question, group.id, group.options),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildGroupDropdown(
    OnboardingQuestion question,
    String key,
    List<String> options,
  ) {
    return InkWell(
      onTap: () {
        _showGroupDropdownSheet(question, key, options);
      },
      child: Container(
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Texts(answers[key] ?? "Select", color: AppColor.white),

            const Icon(Icons.keyboard_arrow_down, color: AppColor.white),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupMultiSelect(
    OnboardingQuestion question,
    String key,
    List<String> options,
  ) {
    final selected = List<String>.from(answers[key] ?? []);
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options.map((item) {
        final active = selected.contains(item);
        return InkWell(
          splashColor: AppColor.transparent,
          onTap: () {
            setState(() {
              if (active) {
                selected.remove(item);
              } else {
                selected.add(item);
              }
              answers[key] = selected;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: active ? AppColor.primaryColor : AppColor.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: active ? AppColor.transparent : Colors.white24,
              ),
            ),
            child: Texts(
              item,
              color: active ? AppColor.black : AppColor.white,
              fontSize: 14,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMultiSelectTagsQuestion(OnboardingQuestion question) {
    final selected = List<String>.from(answers[question.stepId] ?? []);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Texts(
          question.title,
          color: AppColor.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 20),

        ...question.categories!.map((category) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Texts(
                category.name,
                color: AppColor.white,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 10),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: category.tags.map((tag) {
                  final active = selected.contains(tag);
                  return InkWell(
                    splashColor: AppColor.transparent,
                    onTap: () {
                      setState(() {
                        if (active) {
                          selected.remove(tag);
                        } else {
                          selected.add(tag);
                        }
                        answers[question.stepId] = selected;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: active
                            ? AppColor.primaryColor
                            : AppColor.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Texts(
                        tag,
                        color: active ? AppColor.black : AppColor.white,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildBioQuestion(OnboardingQuestion question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Texts(
          question.title,
          color: AppColor.white,
          fontWeight: FontWeight.w700,
        ),

        if (question.subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Texts(
              question.subtitle!,
              color: Colors.white54,
              fontSize: 13,
            ),
          ),
        const SizedBox(height: 15),

        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white24),
            borderRadius: BorderRadius.circular(22),
          ),
          child: TextField(
            controller: TextEditingController(
              text: answers[question.stepId]?.toString() ?? "",
            ),
            maxLines: 6,
            style: Styles.textStyle(color: AppColor.white),
            onChanged: (value) {
              answers[question.stepId] = value;
            },
            decoration: const InputDecoration(
              hintText: "Write something about yourself",
              hintStyle: TextStyle(color: Colors.white38),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(20),
            ),
          ),
        ),
      ],
    );
  }

  void _showGroupDropdownSheet(
    OnboardingQuestion question,
    String key,
    List<String> options,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xff18181B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return ListView(
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          children: options.map((item) {
            return ListTile(
              title: Texts(item, color: AppColor.white),
              trailing: answers[key] == item
                  ? const Icon(Icons.check, color: Color(0xffD7BBFF))
                  : null,
              onTap: () {
                setState(() {
                  answers[key] = item;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  void _showDropdownSheet(OnboardingQuestion question) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xff18181B),
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          children: question.options.map((e) {
            return ListTile(
              title: Texts(e.label, color: AppColor.white),
              onTap: () {
                setState(() {
                  answers[question.stepId] = e.id;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }
}
