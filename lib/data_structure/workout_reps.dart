import 'package:json_annotation/json_annotation.dart';

import 'exercises.dart';

/*If this is missing run:
flutter pub run build_runner build --delete-conflicting-outputs*/
part 'workout_reps.g.dart';

@JsonSerializable()
class WorkoutReps {
  @JsonKey(required: false)
  int? restDuration;

  @JsonKey(required: false)
  int? repDuration;
  @JsonKey(required: false)
  Exercises? exercise;
  @JsonKey(required: false)
  int? reps;
  @JsonKey(required: false)
  int? set;

  WorkoutReps(this.exercise, this.reps, this.set, this.restDuration);
  WorkoutReps.exerciseDuration(
      this.exercise, this.repDuration, this.set, this.restDuration);

  factory WorkoutReps.fromJson(Map<String, dynamic> json) =>
      _$WorkoutRepsFromJson(json);

  Map<String, dynamic> toJson() => _$WorkoutRepsToJson(this);
}
