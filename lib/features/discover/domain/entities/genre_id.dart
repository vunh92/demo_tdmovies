class GenreId {
  final int id;

  const GenreId({this.id});

  factory GenreId.fromJson(Map jsonMap){
    return GenreId(id : jsonMap['id']);
  }
}