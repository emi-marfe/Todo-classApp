class Task {
  bool completed;
  String id;
  String description;
  String owner;
  String createdAt;
  String updatedAt;

  Task(
      {required this.completed,
      required this.id,
      required this.description,
      required this.owner,
      required this.createdAt,
      required this.updatedAt});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        completed: json["completed"],
        id: json["_id"],
        description: json["description"],
        owner: json["owner"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"]);
  }
}
