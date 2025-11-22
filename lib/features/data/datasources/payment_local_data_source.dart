// lib/features/tenant/data/datasources/payment_local_data_source.dart
import '../models/payment_model.dart';

abstract class PaymentLocalDataSource {
  Future<PaymentModel> addPayment(PaymentModel payment);
  Future<List<PaymentModel>> getAllPayments();
  Future<List<PaymentModel>> getPaymentsByTenant(String tenantId);
  Future<PaymentModel> updatePayment(PaymentModel payment);
  Future<void> deletePayment(String id);
}
