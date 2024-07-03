import 'package:movie_app/models/movie_model.dart';

class UserModel {
  String? uid;
  String? name;
  List<MovieModel>? movieList;
  String? email;
  UserModel({
    this.uid,
    this.name,
    this.movieList,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'movieList': movieList,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      movieList: map['movieList'] != null
          ? List<MovieModel>.from(
              (map['movieList'] as List<dynamic>).map<MovieModel?>(
                (x) => MovieModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      email: map['email'] != null ? map['email'] as String : null,
    );
  }
}
