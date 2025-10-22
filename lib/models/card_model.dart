class CardModel {
  int? id;
  String name;
  String suit;
  String image; // store URL or base64 string
  int folderId;

  CardModel({this.id, required this.name, required this.suit, required this.image, required this.folderId});

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'],
      name: map['name'],
      suit: map['suit'],
      image: map['image'],
      folderId: map['folderId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'suit': suit,
      'image': image,
      'folderId': folderId,
    };
  }
}
