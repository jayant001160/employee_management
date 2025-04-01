import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/employee_model.dart';
import '../../repositories/employee_repository.dart';
import 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeRepository repository;

  EmployeeCubit(this.repository) : super(EmployeeInitial());

  void loadEmployees() async {
    emit(EmployeeLoading());
    try {
      final employees = await repository.getEmployees();

      final now = DateTime.now();

      final current = employees.where((e) =>
      e.exitDate == null || e.exitDate!.isAfter(now)
      ).toList();

      final previous = employees.where((e) =>
      e.exitDate != null && e.exitDate!.isBefore(now)
      ).toList();

      emit(EmployeeLoaded(currentEmployees: current, previousEmployees: previous));
    } catch (e) {
      emit(EmployeeError('Failed to load employees'));
    }
  }


  Future<void> addEmployee(Employee employee) async {
    await repository.addEmployee(employee);
    loadEmployees();
  }

  Future<void> updateEmployee(Employee employee) async {
    await repository.updateEmployee(employee);
    loadEmployees();
  }

  Future<void> deleteEmployee(Employee employee) async {
    await repository.deleteEmployee(employee);
    loadEmployees();
  }
}
