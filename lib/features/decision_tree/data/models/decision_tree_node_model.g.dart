// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'decision_tree_node_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DecisionTreeNodeModelAdapter extends TypeAdapter<DecisionTreeNodeModel> {
  @override
  final int typeId = 1;

  @override
  DecisionTreeNodeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DecisionTreeNodeModel(
      id: fields[0] as String?,
      label: fields[1] as String?,
      description: fields[2] as String?,
      requiresThermal: fields[3] as bool?,
      requiresHydration: fields[4] as bool?,
      remedies: (fields[5] as List?)?.cast<String>(),
      branches: (fields[6] as Map?)?.map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<String>())),
      matrix: (fields[7] as Map?)?.map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<String>())),
      subCategories: (fields[8] as List?)?.cast<DecisionTreeNodeModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, DecisionTreeNodeModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.requiresThermal)
      ..writeByte(4)
      ..write(obj.requiresHydration)
      ..writeByte(5)
      ..write(obj.remedies)
      ..writeByte(6)
      ..write(obj.branches)
      ..writeByte(7)
      ..write(obj.matrix)
      ..writeByte(8)
      ..write(obj.subCategories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DecisionTreeNodeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
