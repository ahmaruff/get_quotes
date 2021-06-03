class QuoteModel {
  final String uuid;
  final List<dynamic> tags;
  final String content;
  final String author;
  final String authorSlug;
  final int length;

  QuoteModel({
    required this.uuid,
    required this.tags,
    required this.content,
    required this.author,
    required this.authorSlug,
    required this.length,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      uuid: json['_id'],
      tags: json['tags'],
      content: json['content'],
      author: json['author'],
      authorSlug: json['authorSlug'],
      length: json['length'],
    );
  }
}
