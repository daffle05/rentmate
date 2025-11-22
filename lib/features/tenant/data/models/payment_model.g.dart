// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentModelAdapter extends TypeAdapter<PaymentModel> {
  @override
  final int typeId = 2;

  @override
  PaymentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PaymentModel(
      id: fields[0] as String,
      tenantId: fields[1] as String,
      amount: fields[2] as double,
      datePaid: fields[3] as DateTime,
      monthCovered: fields[4] as String,
      notes: fields[5] as String?,
      paymentMethod: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.tenantId)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.datePaid)
      ..writeByte(4)
      ..write(obj.monthCovered)
      ..writeByte(5)
      ..write(obj.notes)
      ..writeByte(6)
      ..write(obj.paymentMethod);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
