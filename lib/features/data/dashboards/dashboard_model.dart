import 'package:hive/hive.dart';

part 'dashboard_model.g.dart';

@HiveType(typeId: 3)
class DashboardSummaryModel extends HiveObject {
  @HiveField(0)
  final int totalTenants;

  @HiveField(1)
  final int paidCount;

  @HiveField(2)
  final int unpaidCount;

  @HiveField(3)
  final int overdueCount;

  DashboardSummaryModel({
    required this.totalTenants,
    required this.paidCount,
    required this.unpaidCount,
    required this.overdueCount,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DashboardSummaryModel &&
        other.totalTenants == totalTenants &&
        other.paidCount == paidCount &&
        other.unpaidCount == unpaidCount &&
        other.overdueCount == overdueCount;
  }

  @override
  int get hashCode {
    return totalTenants.hashCode ^
        paidCount.hashCode ^
        unpaidCount.hashCode ^
        overdueCount.hashCode;
  }
}
