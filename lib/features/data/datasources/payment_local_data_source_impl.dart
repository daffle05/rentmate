// lib/features/tenant/data/datasources/payment_local_data_source_impl.dart
import 'package:hive/hive.dart';
import 'package:rentmate/features/tenant/data/models/payment_model.dart';
import 'payment_local_data_source.dart';

class PaymentLocalDataSourceImpl implements PaymentLocalDataSource {
  final Box<PaymentModel> paymentBox;

  PaymentLocalDataSourceImpl(this.paymentBox);

  @override
  Future<PaymentModel> addPayment(PaymentModel payment) async {
    await paymentBox.put(payment.id, payment);
    return payment;
  }

  @override
  Future<List<PaymentModel>> getAllPayments() async {
    return paymentBox.values.toList();
  }

  @override
  Future<List<PaymentModel>> getPaymentsByTenant(String tenantId) async {
    return paymentBox.values.where((p) => p.tenantId == tenantId).toList();
  }

  @override
  Future<PaymentModel> updatePayment(PaymentModel payment) async {
    await payment.save();
    return payment;
  }

  @override
  Future<void> deletePayment(String id) async {
    await paymentBox.delete(id);
  }
}
