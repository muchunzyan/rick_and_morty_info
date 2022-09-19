class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String imageLink;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.imageLink,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      gender: json['gender'],
      imageLink: json['image'],
    );
  }
}
