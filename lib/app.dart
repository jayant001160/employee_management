import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/employee/employee_cubit.dart';
import 'repositories/employee_repository.dart';
import 'screens/employee_list/employee_list_screen.dart';

class MyApp extends StatelessWidget {
  final EmployeeRepository _employeeRepository = EmployeeRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmployeeCubit(_employeeRepository)..loadEmployees(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Employee Manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const EmployeeListScreen(),
      ),
    );
  }
}
