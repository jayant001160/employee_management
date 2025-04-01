import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/employee/employee_cubit.dart';
import '../../blocs/employee/employee_state.dart';
import '../../models/employee_model.dart';
import '../../responsive/responsive_layout.dart';
import '../add_edit_employee/add_edit_employee_screen.dart';
import 'widgets/employee_card.dart';
import 'widgets/empty_placeholder.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Employee List",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        backgroundColor: Color(0xff1da1f2),
      ),
      body: BlocBuilder<EmployeeCubit, EmployeeState>(
        builder: (context, state) {
          if (state is EmployeeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EmployeeLoaded) {
            final current = state.currentEmployees;
            final previous = state.previousEmployees;

            if (current.isEmpty && previous.isEmpty) {
              return const EmptyPlaceholder();
            }

            return ResponsiveLayout(
              mobile: _buildListView(context, current, previous),
              tablet: _buildListView(context, current, previous),
              desktop: _buildListView(context, current, previous),
            );
          } else if (state is EmployeeError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 50,
        child: FloatingActionButton(
          backgroundColor: Color(0xff1da1f2),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditEmployeeScreen()),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildListView(BuildContext context, List<Employee> current, List<Employee> previous) {
    return Column(
      children: [
        // Scrollable employee list
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (current.isNotEmpty) ...[
                const Text(
                  "Current employees",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff1da1f2)),
                ),
                const SizedBox(height: 8),
                ...current.map((e) => EmployeeCard(employee: e)).toList(),
                const SizedBox(height: 20),
              ],
              if (previous.isNotEmpty) ...[
                const Text(
                  "Previous employees",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff1da1f2)),
                ),
                const SizedBox(height: 8),
                ...previous.map((e) => EmployeeCard(employee: e)).toList(),
                const SizedBox(height: 20),
              ],
            ],
          ),
        ),

        // Always-sticky bottom note
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          color: Colors.grey.shade200,
          child: const Text(
            "Swipe left to delete",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
