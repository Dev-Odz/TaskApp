import 'dart:convert';

class TaskModel {
  String? title;
  bool? isDone;
  TaskModel({
    this.title,
    this.isDone,
  });

  TaskModel copyWith({
    String? title,
    bool? isDone,
  }) {
    return TaskModel(
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'isDone': isDone,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map['title'] != null ? map['title'] as String : null,
      isDone: map['isDone'] != null ? map['isDone'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TaskModel(title: $title, isDone: $isDone)';

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.title == title && other.isDone == isDone;
  }

  @override
  int get hashCode => title.hashCode ^ isDone.hashCode;
}
