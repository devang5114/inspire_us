class User {
  final int id;
  final String name;
  final String email;
  final String imgUrl;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required String path})
      : imgUrl =
            'http://inspireus.thunderstormdevelopers.com/storage/media/$path';

  @override
  String toString() {
    return 'id: $id, name: $name, email: $email,imgUrl:$imgUrl';
  }
}
