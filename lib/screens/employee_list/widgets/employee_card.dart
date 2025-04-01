import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/employee/employee_cubit.dart';
import '../../../models/employee_model.dart';
import '../../add_edit_employee/add_edit_employee_screen.dart';
import 'package:intl/intl.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;

  const EmployeeCard({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    final isPrevious = employee.exitDate != null;
    final dateText = isPrevious
        ? "${_format(employee.joiningDate)} - ${_format(employee.exitDate!)}"
        : "From ${_format(employee.joiningDate)}";

    return Dismissible(
      key: ValueKey(employee.key),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
        context.read<EmployeeCubit>().deleteEmployee(employee);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Employee data has been deleted'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                context.read<EmployeeCubit>().addEmployee(employee);
              },
            ),
          ),
        );
      },
      child: ListTile(
        title: Text(employee.name, style: TextStyle(color: Color(0xff323238),fontWeight: FontWeight.w500,fontSize: 16),),
        subtitle: Text("${employee.role}\n$dateText",style: TextStyle(color: Color(0xff949c9e),fontWeight: FontWeight.w400,fontSize: 14),),
        isThreeLine: true,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddEditEmployeeScreen(employee: employee),
            ),
          );
        },
      ),
    );
  }

  String _format(DateTime date) {
    return DateFormat('d MMM, yyyy').format(date);
  }
}
