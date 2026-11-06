import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfileState {
  final Map<String, dynamic> answers;
  const EditProfileState({this.answers = const {}});

  EditProfileState copyWith({Map<String, dynamic>? answers}) {
    return EditProfileState(answers: answers ?? this.answers);
  }
}

class EditProfileNotifier extends Notifier<EditProfileState> {
  @override
  EditProfileState build() {
    return const EditProfileState();
  }

  void updateAnswer(String key, dynamic value) {
    state = state.copyWith(answers: {...state.answers, key: value});
  }

  dynamic getAnswer(String key) {
    return state.answers[key];
  }
}

final editProfileProvider =
    NotifierProvider<EditProfileNotifier, EditProfileState>(
      EditProfileNotifier.new,
    );
