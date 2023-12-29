class MovieModel {
  final int id;
  final String name;
  final String title;
  final String genre;

  MovieModel({
    required this.id,
    required this.name,
    required this.title,
    required this.genre,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      name: json['name'],
      title: json['title'],
      genre: json['genre'],
    );
  }
}
