import 'package:meta/meta.dart';

import 'acitivity.dart';
import '../../../core/models/permission.dart';

class ActivityLog {
  final int id;
  final Permission permissionType;
  final Activity activityType;
  final String entity;
  final String entityId;
  final String performedBy;
  final String userId;
  final String log;
  final DateTime createdAt;

  ActivityLog({
    @required this.id,
    @required this.permissionType,
    @required this.activityType,
    @required this.entity,
    @required this.entityId,
    @required this.performedBy,
    @required this.userId,
    @required this.log,
    @required this.createdAt,
  });

  factory ActivityLog.fromJson(Map<String, dynamic> json) {
    return ActivityLog(
      id: json['id'],
      permissionType: Permission.values[json['permissionType']],
      activityType: Activity.values[json['activityType']],
      entity: json['entity'],
      entityId: json['entityId'],
      performedBy: json['performedBy'],
      userId: json['userId'],
      log: json['log'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  static ActivityLog fromJsonModel(Map<String, dynamic> json) => ActivityLog.fromJson(json);
}
