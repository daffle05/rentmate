// lib/features/tenant/domain/repositories/payment_repository.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../data/models/payment_model.dart';

abstract class PaymentRepository {
  Future<Either<Failure, PaymentModel>> addPayment(PaymentModel payment);
  Future<Either<Failure, List<PaymentModel>>> getAllPayments();
  Future<Either<Failure, List<PaymentModel>>> getPaymentsByTenant(String tenantId);
  Future<Either<Failure, PaymentModel>> updatePayment(PaymentModel payment);
  Future<Either<Failure, void>> deletePayment(String id);
}
