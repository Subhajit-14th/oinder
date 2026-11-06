import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:oinder/widget/widget.dart';

class AppDateTimeField extends ConsumerStatefulWidget {
  const AppDateTimeField({super.key});

  @override
  ConsumerState<AppDateTimeField> createState() => _AppDateTimeFieldState();
}

class _AppDateTimeFieldState extends ConsumerState<AppDateTimeField> {
  final dobController = TextEditingController();
  DateTime? selectedDob;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickDate(context),
      child: AbsorbPointer(
        child: AppTextField(
          controller: dobController,
          labelText: "",
          // labelText: "Last Menstrual Date",
          richLabel: TextSpan(
            children: [
              TextSpan(
                text: 'Last Menstrual Date',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  letterSpacing: 1,
                ),
              ),
              TextSpan(
                text: ' *',
                style: TextStyle(fontSize: 15, color: Colors.red),
              ),
            ],
          ),
          hintText: "Last menstrual Date",
          suffixIcon: Icon(Icons.calendar_month_rounded),
        ),
      ),
    ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.25);
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {
        selectedDob = picked;
        dobController.text = formattedDate;
      });

      // ref.read(registerProvider).setMenstrualCycleStartDate(picked);
    }
  }
}
