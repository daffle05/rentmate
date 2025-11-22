import 'package:dartz/dartz.dart';
import 'package:rentmate/core/error/failure.dart';
import 'package:rentmate/features/data/dashboards/dashboard_model.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardSummaryModel>> getDashboardSummary();
}
