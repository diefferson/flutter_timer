import 'package:flutter_timer/src/utils/extensions.dart';
import 'package:uuid/uuid.dart';

class OdooProject {
  OdooProject({
    String? id,
    String? name,
    String? description,
    String? color,
    this.deadline,
    bool? isFavorite,
    String? assignee,
  })  : id = id ?? const Uuid().v1(),
        name = name ?? "",
        description = description ?? "",
        color = color ?? "",
        isFavorite = isFavorite ?? false,
        assignee = assignee ?? "";

  final String id;
  final String name;
  final String description;
  final String color;
  final bool isFavorite;
  final DateTime? deadline;
  final String assignee;

  factory OdooProject.fromJson(Map<dynamic, dynamic> json) {
    return OdooProject(
      id: json.getString('id'),
      name: json.getString('name'),
      description: json.getString('description'),
      color: json.getString('color'),
      deadline: json.getDate('deadline'),
      isFavorite: json.getBool('isFavorite'),
      assignee: json.getString('assignee'),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'color': color,
        'deadline': deadline?.toIso8601String(),
        'isFavorite': isFavorite,
        'assignee': assignee,
      }..removeWhere((e, dynamic v) => v == null);

  @override
  String toString() {
    return name;
  }
}
