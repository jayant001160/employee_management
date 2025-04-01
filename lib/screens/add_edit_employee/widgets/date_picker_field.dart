import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatelessWidget {
  final DateTime? joiningDate;
  final DateTime? exitDate;
  final Function(DateTime joining, DateTime? exit) onDateRangeSelected;

  const DatePickerField({
    super.key,
    required this.joiningDate,
    required this.exitDate,
    required this.onDateRangeSelected,
  });

  Future<void> _pickDateRange(BuildContext context) async {
    final today = DateTime.now();

    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(today.year + 10),
      initialDateRange: (joiningDate != null)
          ? DateTimeRange(start: joiningDate!, end: exitDate ?? joiningDate!)
          : null,
    );

    if (picked != null) {
      onDateRangeSelected(picked.start, picked.start == picked.end ? null : picked.end);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateText = (joiningDate != null)
        ? (exitDate != null
        ? "${_format(joiningDate!)} - ${_format(exitDate!)}"
        : "From ${_format(joiningDate!)}")
        : "Select Joining/Exit Date";

    return GestureDetector(
      onTap: () => _pickDateRange(context),
      child: InputDecorator(
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.calendar_today_outlined,
            color: Color(0xff1da1f2), // Twitter Blue
          ),
          labelText: 'Joining Date (and Exit if any)',
          border: OutlineInputBorder(),
        ),
        child: Text(dateText),
      ),
    );
  }

  String _format(DateTime date) => DateFormat('d MMM, yyyy').format(date);
}
