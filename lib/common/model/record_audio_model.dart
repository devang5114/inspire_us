class RecordAudioModel {
  final String audioUrl;
  final String title;
  final String tag;

  RecordAudioModel(
      {required this.audioUrl, required this.title, required this.tag});

  factory RecordAudioModel.fromJson(Map<String, dynamic> json) {
    return RecordAudioModel(
      audioUrl: json['audioUrl'],
      title: json['title'],
      tag: json['tag'],
    );
  }
}
