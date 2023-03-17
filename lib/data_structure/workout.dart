import 'package:json_annotation/json_annotation.dart';
import 'package:training_plan_flutter/data_structure/workout_reps.dart';

/*If this is missing run:
flutter pub run build_runner build --delete-conflicting-outputs*/
part 'workout.g.dart';

@JsonSerializable()
class Workout {
  @JsonKey(required: true)
  String name = "";
  @JsonKey(required: false)
  String description = "";

  @JsonKey(required: true)
  List<WorkoutReps> reps = [];

  Workout(this.name, this.description, this.reps);

  factory Workout.fromJson(Map<String, dynamic> json) =>
      _$WorkoutFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutToJson(this);
}
