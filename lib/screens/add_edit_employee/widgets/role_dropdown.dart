import 'package:flutter/material.dart';
import '../../../constants/roles.dart';

class RoleDropdown extends StatelessWidget {
  final String? selectedRole;
  final Function(String?) onChanged;

  const RoleDropdown({super.key, required this.selectedRole, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedRole,
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.work_outline,
          color: Color(0xff1da1f2), // Twitter Blue
        ),
        labelText: 'Select Role',
        border: OutlineInputBorder(),
      ),
      items: kRoles.map((role) {
        return DropdownMenuItem(value: role, child: Text(role));
      }).toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? 'Please select a role' : null,
    );
  }
}
