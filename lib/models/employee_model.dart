import 'package:hive/hive.dart';

part 'employee_model.g.dart';

@HiveType(typeId: 0)
class Employee extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String role;

  @HiveField(2)
  DateTime joiningDate;

  @HiveField(3)
  DateTime? exitDate;

  Employee({
    required this.name,
    required this.role,
    required this.joiningDate,
    this.exitDate,
  });
}
