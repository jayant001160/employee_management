import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/employee_model.dart';
import '../../../blocs/employee/employee_cubit.dart';
import 'widgets/action_buttons.dart';
import 'widgets/date_picker_field.dart';
import 'widgets/name_input_field.dart';
import 'widgets/role_dropdown.dart';

class AddEditEmployeeScreen extends StatefulWidget {
  final Employee? employee;

  const AddEditEmployeeScreen({super.key, this.employee});

  @override
  State<AddEditEmployeeScreen> createState() => _AddEditEmployeeScreenState();
}

class _AddEditEmployeeScreenState extends State<AddEditEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  String? _selectedRole;
  DateTime? _joiningDate;
  DateTime? _exitDate;

  bool get isEditing => widget.employee != null;

  @override
  void initState() {
    super.initState();
    final emp = widget.employee;
    _nameController = TextEditingController(text: emp?.name ?? '');
    _selectedRole = emp?.role;
    _joiningDate = emp?.joiningDate;
    _exitDate = emp?.exitDate;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate() && _joiningDate != null) {
      final employee = Employee(
        name: _nameController.text,
        role: _selectedRole!,
        joiningDate: _joiningDate!,
        exitDate: _exitDate,
      );

      final cubit = context.read<EmployeeCubit>();

      if (isEditing) {
        widget.employee!
          ..name = employee.name
          ..role = employee.role
          ..joiningDate = employee.joiningDate
          ..exitDate = employee.exitDate;
        cubit.updateEmployee(widget.employee!);
      } else {
        cubit.addEmployee(employee);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? "Edit Employee" : "Add Employee",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        backgroundColor: const Color(0xff1da1f2),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Form fields inside scrollable area
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      NameInputField(controller: _nameController),
                      const SizedBox(height: 16),
                      RoleDropdown(
                        selectedRole: _selectedRole,
                        onChanged: (value) => setState(() => _selectedRole = value),
                      ),
                      const SizedBox(height: 16),
                      DatePickerField(
                        joiningDate: _joiningDate,
                        exitDate: _exitDate,
                        onDateRangeSelected: (join, exit) {
                          setState(() {
                            _joiningDate = join;
                            _exitDate = exit;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              // Button row pinned to bottom right
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, bottom: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xff1da1f2),
                          side: const BorderSide(color: Color(0xff1da1f2)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff1da1f2),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('Save'),
                      ),
                    ],
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
