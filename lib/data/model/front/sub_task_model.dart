/// subtaskName : ""
/// check : false
/// priority : 0

class SubTaskModel {
  SubTaskModel({
    this.subtaskName,
    this.check,
    this.priority,
  });

  SubTaskModel.fromJson(dynamic json) {
    subtaskName = json['subtaskName'];
    check = json['check'];
    priority = json['priority'];
  }
  String? subtaskName;
  bool? check;
  int? priority;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subtaskName'] = subtaskName;
    map['check'] = check;
    map['priority'] = priority;
    return map;
  }
}
