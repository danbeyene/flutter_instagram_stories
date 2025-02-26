import 'package:json_annotation/json_annotation.dart';
import 'story_data.dart';

part 'stories.g.dart';

@JsonSerializable(explicitToJson: true)
class Stories {
  String? storyId;
  DateTime? date;
  List<StoryData>? file;
  String? previewImage;
  // caption on the each story, can be null
  Map<String, String>? previewTitle;
@override
String toString(){
return "previewTitle: ${previewTitle?['en']} previewImage: ${previewImage}";
}
  Stories({
    this.storyId,
    this.date,
    this.file,
    this.previewImage,
    this.previewTitle,
  });

  factory Stories.fromJson(Map<String, dynamic> json) =>
      _$StoriesFromJson(json);
  Map<String, dynamic> toJson() => _$StoriesToJson(this);
}
