// lib/features/tenant/domain/repositories/payment_repository.dart
import 'package:dartz/dartz.dart';
import 'package:rentmate/features/data/datasources/payment_local_data_source.dart';
import 'package:rentmate/features/tenant/data/models/payment_model.dart';
import 'package:rentmate/core/error/failure.dart';

abstract class PaymentRepository {
  PaymentLocalDataSource get datasource;

  Future<Either<Failure, PaymentModel>> addPayment(PaymentModel payment);
  Future<Either<Failure, List<PaymentModel>>> getAllPayments();
  Future<Either<Failure, List<PaymentModel>>> getPaymentsByTenant(String tenantId);
  Future<Either<Failure, PaymentModel>> updatePayment(PaymentModel payment);
  Future<Either<Failure, void>> deletePayment(String id);
}
