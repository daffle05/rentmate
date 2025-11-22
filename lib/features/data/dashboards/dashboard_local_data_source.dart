import 'package:rentmate/features/data/dashboards/dashboard_model.dart';

abstract class DashboardLocalDataSource {
  Future<DashboardSummaryModel> getDashboardSummary();
}
