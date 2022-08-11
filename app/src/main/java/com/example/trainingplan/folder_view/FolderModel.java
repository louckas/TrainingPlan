package com.example.trainingplan.folder_view;

import android.os.Build;
import android.os.Parcel;
import android.os.Parcelable;

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
        byte tmpExtended_ = in.readByte();
        extended_ = tmpExtended_ == 0 ? null : tmpExtended_ == 1;
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

    @Override
    public void writeToParcel(Parcel parcel, int i) {
        parcel.writeString(folderName_);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            parcel.writeParcelableList(exerciseList_, i);
        }
    }
}
