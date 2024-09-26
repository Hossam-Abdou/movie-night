// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'hive_adapter.dart';
//
//
// class HiveWatchListAdapter extends TypeAdapter<HiveWatchList> {
//   @override
//   final int typeId = 2;
//
//   @override
//   HiveWatchList read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return HiveWatchList(
//       title: fields[0] as String?,
//       id: fields[1] as int?,
//       posterPath: fields[2] as String?,
//       voteAverage: fields[3] as double?,
//     );
//   }
//
//   @override
//   void write(BinaryWriter writer, HiveWatchList obj) {
//     writer
//       ..writeByte(4)
//       ..writeByte(0)
//       ..write(obj.title)
//       ..writeByte(1)
//       ..write(obj.id)
//       ..writeByte(2)
//       ..write(obj.posterPath)
//       ..writeByte(3)
//       ..write(obj.voteAverage);
//   }
//
//   @override
//   int get hashCode => typeId.hashCode;
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//           other is HiveWatchListAdapter &&
//               runtimeType == other.runtimeType &&
//               typeId == other.typeId;
// }
