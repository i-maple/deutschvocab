class VocabularyModel {
  final String german;
  final String english;
  final dynamic user;
  VocabularyModel({
    required this.german,
    required this.english,
    this.user = 'admin'
  });
}
