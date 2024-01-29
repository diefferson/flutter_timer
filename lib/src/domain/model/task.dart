import 'package:flutter_timer/src/utils/extensions.dart';
import 'package:uuid/uuid.dart';

class OdooTask {
  OdooTask({
    String? id,
    String? projectId,
    String? name,
    String? description,
  })  : id = id ?? const Uuid().v1(),
        projectId = projectId ?? "",
        name = name ?? "",
        description = description ?? "";

  final String id;
  final String projectId;
  final String name;
  final String description;


  factory OdooTask.fromJson(Map<dynamic, dynamic> json) {
    return OdooTask(
      id: json.getString('id'),
      projectId: json.getString('projectId'),
      name: json.getString('name'),
      description: json.getString('description'),

    );
  }

  Map<dynamic, dynamic> toJson() => {
        'id': id,
        'projectId': projectId,
        'name': name,
        'description': description,
      }..removeWhere((e, dynamic v) => v == null);

  @override
  String toString() {
    return name;
  }
}
