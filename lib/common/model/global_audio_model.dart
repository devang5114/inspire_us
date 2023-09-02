class GlobalAudioModel {
  final String id;
  final String userId;
  final String userName;
  final String title;
  final String tags;
  final String fileUrl;
  final DateTime createdAt;

  GlobalAudioModel(
      {required this.id,
      required this.userId,
      required this.userName,
      required this.title,
      required this.tags,
      required this.createdAt,
      required String fileName})
      : fileUrl =
            'https://inspireus.thunderstormdevelopers.com/storage/media/$fileName';

  factory GlobalAudioModel.fromJson(Map<String, dynamic> json) {
    return GlobalAudioModel(
        id: json['id'].toString(),
        userId: json['user_id'].toString(),
        userName: json['name'].toString(),
        title: json['title'].toString(),
        tags: json['tags'].toString(),
        fileName: json['file'].toString(),
        createdAt: DateTime.parse(
            (json['created_at'] ?? '2023-08-30T11:49:29.000000Z')
                .toString()
                .replaceAll('Z', '')));
  }
}
