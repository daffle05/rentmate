import 'package:hive/hive.dart';

part 'tenant_model.g.dart';

@HiveType(typeId: 1)
class TenantModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String roomNumber;

  @HiveField(3)
  final double rentAmount;

  @HiveField(4)
  final int dueDate; // Day of month (1–31)

  TenantModel({
    required this.id,
    required this.name,
    required this.roomNumber,
    required this.rentAmount,
    required this.dueDate,
  });

  // Manual equality
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TenantModel &&
        other.id == id &&
        other.name == name &&
        other.roomNumber == roomNumber &&
        other.rentAmount == rentAmount &&
        other.dueDate == dueDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        roomNumber.hashCode ^
        rentAmount.hashCode ^
        dueDate.hashCode;
  }
}
