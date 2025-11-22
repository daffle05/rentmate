// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DashboardSummaryModelAdapter extends TypeAdapter<DashboardSummaryModel> {
  @override
  final int typeId = 3;

  @override
  DashboardSummaryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DashboardSummaryModel(
      totalTenants: fields[0] as int,
      paidCount: fields[1] as int,
      unpaidCount: fields[2] as int,
      overdueCount: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DashboardSummaryModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.totalTenants)
      ..writeByte(1)
      ..write(obj.paidCount)
      ..writeByte(2)
      ..write(obj.unpaidCount)
      ..writeByte(3)
      ..write(obj.overdueCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardSummaryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
