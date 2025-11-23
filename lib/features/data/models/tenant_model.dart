import 'package:hive/hive.dart';

part 'tenant_model.g.dart';

@HiveType(typeId: 0)
class TenantModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String phone;

  @HiveField(3)
  final String roomNumber;

  TenantModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.roomNumber, required int dueDate, required double rentAmount,
  });

  get rentAmount => null;

  get dueDate => null;
}
