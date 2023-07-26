import 'package:deutschvocab/ui/utils/enums.dart';

class VocabularyModel {
  final String german;
  final String english;
  final dynamic user;
  final PartOfSpeech partOfSpeech;
  
  VocabularyModel({
    required this.german,
    required this.english,
    this.user = 'admin',
    this.partOfSpeech = PartOfSpeech.noun,
  });
}
