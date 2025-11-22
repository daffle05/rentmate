// lib/features/tenant/data/models/payment_model.dart
import 'package:hive/hive.dart';

part 'payment_model.g.dart';

@HiveType(typeId: 2)
class PaymentModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String tenantId;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime datePaid;

  @HiveField(4)
  final String monthCovered;

  @HiveField(5)
  final String? notes;

  @HiveField(6)
  final String? paymentMethod;

  PaymentModel({
    required this.id,
    required this.tenantId,
    required this.amount,
    required this.datePaid,
    required this.monthCovered,
    this.notes,
    this.paymentMethod,
  });

  // Manual equality
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentModel &&
        other.id == id &&
        other.tenantId == tenantId &&
        other.amount == amount &&
        other.datePaid == datePaid &&
        other.monthCovered == monthCovered &&
        other.notes == notes &&
        other.paymentMethod == paymentMethod;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        tenantId.hashCode ^
        amount.hashCode ^
        datePaid.hashCode ^
        monthCovered.hashCode ^
        (notes?.hashCode ?? 0) ^
        (paymentMethod?.hashCode ?? 0);
  }
}
