import 'exercises.dart';
import 'package:json_annotation/json_annotation.dart';

/*If this is missing run:
flutter pub run build_runner build --delete-conflicting-outputs*/
part 'folders.g.dart';

@JsonSerializable()
class Folders {
  @JsonKey(required: true)
  String name = "";
  @JsonKey(required: false)
  String description = "";

  @JsonKey(required: false)
  List<Exercises> exercises = [];

  Folders(this.name, this.description, this.exercises);

  factory Folders.fromJson(Map<String, dynamic> json) =>
      _$FoldersFromJson(json);

  Map<String, dynamic> toJson() => _$FoldersToJson(this);
}
