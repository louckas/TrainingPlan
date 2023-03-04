import 'package:json_annotation/json_annotation.dart';

/*If this is missing run:
flutter pub run build_runner build --delete-conflicting-outputs*/
part 'exercises.g.dart';

@JsonSerializable()
class Exercises {
  @JsonKey(required: true)
  String name = "";
  @JsonKey(required: false)
  String description = "";

  Exercises(this.name, this.description);

  factory Exercises.fromJson(Map<String, dynamic> json) =>
      _$ExercisesFromJson(json);

  Map<String, dynamic> toJson() => _$ExercisesToJson(this);
}
