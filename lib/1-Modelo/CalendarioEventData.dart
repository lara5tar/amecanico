import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// calendar_event_data_adapter.dart

class CalendarEventDataAdapter<T> extends TypeAdapter<CalendarEventData<T>> {
  Map<String, dynamic> textStyleToMap(TextStyle? textStyle) {
    if (textStyle == null) {
      return {};
    }

    return {
      'color': textStyle.color?.value,
      'fontSize': textStyle.fontSize,
      'fontWeight': textStyle.fontWeight?.index,
      'fontStyle': textStyle.fontStyle?.index,
    };
  }

  TextStyle? mapToTextStyle(Map<dynamic, dynamic> map) {
    if (map.isEmpty) {
      return null;
    }

    return TextStyle(
      color: map['color'] != null ? Color(map['color']) : null,
      fontSize: map['fontSize']?.toDouble(),
      fontWeight: map['fontWeight'] != null
          ? FontWeight.values[map['fontWeight']]
          : null,
      fontStyle:
          map['fontStyle'] != null ? FontStyle.values[map['fontStyle']] : null,
    );
  }

  @override
  final int typeId = 2;

  @override
  CalendarEventData<T> read(BinaryReader reader) {
    final date = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final startTime = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final endTime = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
    final title = reader.readString();
    final description = reader.readString();
    final color = Color(reader.readInt());
    final event = reader.read() as T?;
    final titleStyle = mapToTextStyle(reader.readMap());
    final descriptionStyle = mapToTextStyle(reader.readMap());

    return CalendarEventData<T>(
      date: date,
      startTime: startTime,
      endTime: endTime,
      title: title,
      description: description,
      color: color,
      event: event,
      titleStyle: titleStyle,
      descriptionStyle: descriptionStyle,
    );
  }

  @override
  void write(BinaryWriter writer, CalendarEventData<T> obj) {
    writer.writeInt(obj.date.millisecondsSinceEpoch);
    writer.writeInt(obj.startTime?.millisecondsSinceEpoch ?? 0);
    writer.writeInt(obj.endTime?.millisecondsSinceEpoch ?? 0);
    writer.writeString(obj.title);
    writer.writeString(obj.description);
    writer.writeInt(obj.color.value);
    writer.write(obj.event);
    writer.writeMap(textStyleToMap(obj.titleStyle));
    writer.writeMap(textStyleToMap(obj.descriptionStyle));
  }
}
