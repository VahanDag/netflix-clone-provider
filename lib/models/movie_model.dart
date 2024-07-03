class MovieModel {
  String? name;
  String? youtubeId;
  String? image;
  String? description;
  int? movieId;
  MovieModel({
    this.name,
    this.youtubeId,
    this.image,
    this.description,
    this.movieId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'youtubeId': youtubeId,
      'image': image,
      'description': description,
      'movieId': movieId,
    };
  }

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      name: map['name'] != null ? map['name'] as String : null,
      youtubeId: map['youtubeId'] != null ? map['youtubeId'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      movieId: map['movieId'] != null ? map['movieId'] as int : null,
    );
  }
}
