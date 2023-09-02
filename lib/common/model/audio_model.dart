class AudioModel {
  final String id;
  final String title;
  final String tags;
  final String fileUrl;
  final DateTime createdAt;

  AudioModel(
      {required this.id,
      required this.title,
      required this.tags,
      required this.createdAt,
      required String file})
      : fileUrl =
            'https://inspireus.thunderstormdevelopers.com/storage/media/$file';

  factory AudioModel.fromJson(Map<String, dynamic> json) {
    return AudioModel(
        id: json['id'].toString(),
        title: json['title'].toString(),
        tags: json['tags'] ?? '',
        file: json['file'] ?? '',
        createdAt: DateTime.parse(
            (json['created_at'] ?? '2023-08-30T11:49:29.000000Z')
                .toString()
                .replaceAll('Z', '')));
  }
}
