import 'package:hive/hive.dart';
import '../models/employee_model.dart';

class EmployeeRepository {
  static const String _boxName = 'employees';

  Future<Box<Employee>> _openBox() async {
    return await Hive.openBox<Employee>(_boxName);
  }

  Future<List<Employee>> getEmployees() async {
    final box = await _openBox();
    return box.values.toList();
  }

  Future<void> addEmployee(Employee employee) async {
    final box = await _openBox();
    await box.add(employee);
  }

  Future<void> updateEmployee(Employee employee) async {
    await employee.save();
  }

  Future<void> deleteEmployee(Employee employee) async {
    await employee.delete();
  }

  Future<void> clearAll() async {
    final box = await _openBox();
    await box.clear();
  }
}
