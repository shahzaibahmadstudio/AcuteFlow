// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remedy_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RemedyModelAdapter extends TypeAdapter<RemedyModel> {
  @override
  final int typeId = 0;

  @override
  RemedyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RemedyModel(
      id: fields[0] as String,
      name: fields[1] as String,
      decisiveSymptoms: (fields[2] as List).cast<String>(),
      otherBehaviors: (fields[3] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, RemedyModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.decisiveSymptoms)
      ..writeByte(3)
      ..write(obj.otherBehaviors);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RemedyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
