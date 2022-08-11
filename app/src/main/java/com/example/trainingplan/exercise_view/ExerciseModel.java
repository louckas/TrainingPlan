package com.example.trainingplan.exercise_view;

import android.os.Parcel;
import android.os.Parcelable;

public class ExerciseModel  implements Parcelable {
    String exerciseName_;
    String description_;
    String folderName_;

    public ExerciseModel(String exerciseName, String description, String folderName) {
        exerciseName_ = exerciseName;
        description_ = description;
        folderName_ = folderName;
    }

    protected ExerciseModel(Parcel in) {
        exerciseName_ = in.readString();
        description_ = in.readString();
        folderName_ = in.readString();
    }

    public static final Creator<ExerciseModel> CREATOR = new Creator<ExerciseModel>() {
        @Override
        public ExerciseModel createFromParcel(Parcel in) {
            return new ExerciseModel(in);
        }

        @Override
        public ExerciseModel[] newArray(int size) {
            return new ExerciseModel[size];
        }
    };

    public String getExerciseName_() { return exerciseName_; }

    public String getDescription_() { return description_; }

    public String getFolderName_() { return folderName_; }

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeString(exerciseName_);
        parcel.writeString(description_);
        parcel.writeString(folderName_);
    }
}
