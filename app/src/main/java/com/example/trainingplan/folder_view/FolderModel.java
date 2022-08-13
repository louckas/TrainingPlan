package com.example.trainingplan.folder_view;

import android.os.Build;
import android.os.Parcel;
import android.os.Parcelable;

import androidx.annotation.RequiresApi;

import com.example.trainingplan.exercise_view.ExerciseModel;

import java.util.ArrayList;
import java.util.List;

public class FolderModel implements Parcelable {
    String folderName_ = "Folder";
    Boolean extended_ = false;
    ArrayList<ExerciseModel> exerciseList_;

    public FolderModel(String folderName, Boolean extended, ArrayList<ExerciseModel> exerciseList) {
        folderName_ = folderName;
        extended_ = extended;
        exerciseList_ = exerciseList;
    }

    protected FolderModel(Parcel in) {
        folderName_ = in.readString();
        extended_ = in.readByte() != 0;
        exerciseList_ = in.createTypedArrayList(ExerciseModel.CREATOR);
    }

    public static final Creator<FolderModel> CREATOR = new Creator<FolderModel>() {
        @Override
        public FolderModel createFromParcel(Parcel in) {
            return new FolderModel(in);
        }

        @Override
        public FolderModel[] newArray(int size) {
            return new FolderModel[size];
        }
    };

    public String getFolderName_() {
        return folderName_;
    }

    public Boolean getExtended_() {
        return extended_;
    }

    public void setExtended_(boolean extended) { extended_ = extended; }

    public List<ExerciseModel> getExerciseList_() { return exerciseList_; }

    @Override
    public int describeContents() {
        return 0;
    }

    @RequiresApi(api = Build.VERSION_CODES.Q)
    @Override
    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeString(folderName_);
        parcel.writeByte((byte) (extended_ ? 1 : 0));
        parcel.writeTypedList(exerciseList_);
    }
}
