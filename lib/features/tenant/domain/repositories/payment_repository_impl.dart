// lib/features/tenant/data/repositories/payment_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:rentmate/features/tenant/domain/repositories/payment_repository.dart';
import 'package:rentmate/features/tenant/data/models/payment_model.dart';
import 'package:rentmate/features/tenant/data/datasources/payment_local_data_source.dart';
import 'package:rentmate/core/error/failure.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentLocalDataSource localDataSource;

  PaymentRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, PaymentModel>> addPayment(PaymentModel payment) async {
    try {
      final result = await localDataSource.addPayment(payment);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure('Failed to add payment: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<PaymentModel>>> getAllPayments() async {
    try {
      final result = await localDataSource.getAllPayments();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure('Failed to load payments: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<PaymentModel>>> getPaymentsByTenant(String tenantId) async {
    try {
      final result = await localDataSource.getPaymentsByTenant(tenantId);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure('Failed to load payments for tenant: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, PaymentModel>> updatePayment(PaymentModel payment) async {
    try {
      final result = await localDataSource.updatePayment(payment);
      return Right(result);
    } catch (e) {
      return Left(CacheFailure('Failed to update payment: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deletePayment(String id) async {
    try {
      await localDataSource.deletePayment(id);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to delete payment: ${e.toString()}'));
    }
  }
}
