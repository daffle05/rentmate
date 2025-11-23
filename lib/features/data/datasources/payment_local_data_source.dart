import 'package:hive/hive.dart';
import 'package:rentmate/features/tenant/data/models/payment_model.dart';

class PaymentLocalDataSource {
  final Box<PaymentModel> paymentBox;

  PaymentLocalDataSource(this.paymentBox);

  // CREATE
  Future<void> addPayment(PaymentModel payment) async {
    await paymentBox.put(payment.id, payment);
  }

  // READ ALL
  List<PaymentModel> getAllPayments() {
    return paymentBox.values.toList();
  }

  // READ by Tenant
  List<PaymentModel> getPaymentsByTenant(String tenantId) {
    return paymentBox.values
        .where((payment) => payment.tenantId == tenantId)
        .toList();
  }

  // UPDATE
  Future<void> updatePayment(PaymentModel payment) async {
    await paymentBox.put(payment.id, payment);
  }

  // DELETE
  Future<void> deletePayment(String id) async {
    await paymentBox.delete(id);
  }
}
