import 'package:hive/hive.dart';
import 'package:rentmate/features/tenant/data/models/payment_model.dart';
import 'payment_local_data_source.dart';

class PaymentLocalDataSourceImpl extends PaymentLocalDataSource {
  final Box<PaymentModel> _paymentBox;

  PaymentLocalDataSourceImpl(this._paymentBox) : super(int as Box<PaymentModel>);

  @override
  Box<PaymentModel> get paymentBox => _paymentBox;

  @override
  Future<void> addPayment(PaymentModel payment) async {
    await _paymentBox.put(payment.id, payment);
  }

  @override
  List<PaymentModel> getAllPayments() {
    return _paymentBox.values.toList();
  }

  @override
  List<PaymentModel> getPaymentsByTenant(String tenantId) {
    return _paymentBox.values
        .where((p) => p.tenantId == tenantId)
        .toList();
  }

  @override
  Future<void> updatePayment(PaymentModel payment) async {
    await _paymentBox.put(payment.id, payment);
  }

  @override
  Future<void> deletePayment(String id) async {
    await _paymentBox.delete(id);
  }
}
