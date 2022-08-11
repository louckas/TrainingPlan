package com.example.trainingplan;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.Spinner;
import android.widget.TextView;

import com.example.trainingplan.exercise_view.ExerciseModel;
import com.example.trainingplan.folder_view.FolderModel;
import com.example.trainingplan.tabs.ExerciseTab;

import java.util.ArrayList;

public class AddExerciseActivity extends AppCompatActivity {

    public ArrayList<FolderModel> folderList_ = new ArrayList<>();
    public ExerciseModel exercise_;

    ImageButton returnButton;
    TextView exerciseName;
    Spinner folderSelection;
    Button addFolderButton;
    TextView descriptionView;
    Button doneButton;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.add_exercise_activity);
        Intent intent = getIntent();

        returnButton =  findViewById(R.id.returnButton);
        exerciseName =  findViewById(R.id.exerciseName);
        folderSelection =  findViewById(R.id.folderSelection);
        addFolderButton =  findViewById(R.id.addFolderButton);
        descriptionView =  findViewById(R.id.descriptionTextView);
        doneButton =  findViewById(R.id.doneButton);

        returnButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                finish();
            }
        });

        addFolderButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {

            }
        });

        doneButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                //Todo add saving of the exercise
                finish();
            }
        });

        folderList_ = intent.getParcelableArrayListExtra(ExerciseTab.EXTRA_EXERCISE_LIST);
        for (FolderModel folder : folderList_) {
//            folderSelection.add
        }

        if (intent.hasExtra(ExerciseTab.EXTRA_EXERCISE)) {
            exercise_ = intent.getParcelableExtra(ExerciseTab.EXTRA_EXERCISE);
            exerciseName.setText(exercise_.getExerciseName_());
            descriptionView.setText(exercise_.getDescription_());
//            folderSelection.set Todo set default choice in the spinner
        }


    }
}