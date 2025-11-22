import 'package:hive/hive.dart';
import 'package:rentmate/features/data/models/payment_model.dart';
import 'package:rentmate/features/data/models/tenant_model.dart';
import 'package:rentmate/features/data/dashboards/dashboard_model.dart';

import 'dashboard_local_data_source.dart';

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  final Box<TenantModel> tenantBox;
  final Box<PaymentModel> paymentBox;

  DashboardLocalDataSourceImpl({
    required this.tenantBox,
    required this.paymentBox,
  });

  @override
  Future<DashboardSummaryModel> getDashboardSummary() async {
    final tenants = tenantBox.values.toList();
    final payments = paymentBox.values.toList();

    int totalTenants = tenants.length;

    int paid = 0;
    int unpaid = 0;
    int overdue = 0;

    DateTime now = DateTime.now();

    for (var tenant in tenants) {
      final tenantPayments = payments.where((p) => p.tenantId == tenant.id);

      bool hasPaidThisMonth = tenantPayments.any(
        (p) =>
            p.monthCovered ==
            "${now.year}-${now.month.toString().padLeft(2, '0')}",
      );

      if (hasPaidThisMonth) {
        paid++;
      } else {
        if (now.day > tenant.dueDate) {
          overdue++;
        } else {
          unpaid++;
        }
      }
    }

    return DashboardSummaryModel(
      totalTenants: totalTenants,
      paidCount: paid,
      unpaidCount: unpaid,
      overdueCount: overdue,
    );
  }
}
