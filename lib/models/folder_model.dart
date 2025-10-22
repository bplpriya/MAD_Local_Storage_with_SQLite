class FolderModel {
  final int? id;
  final String name;

  FolderModel({this.id, required this.name});

  factory FolderModel.fromMap(Map<String, dynamic> map) {
    return FolderModel(
      id: map['id'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }
}
