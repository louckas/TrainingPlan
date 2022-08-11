package com.example.trainingplan.tabs;

import com.example.trainingplan.AddExerciseActivity;
import com.example.trainingplan.R;
import com.example.trainingplan.folder_view.FolderModel;
import com.example.trainingplan.folder_view.FolderViewAdapter;
import com.example.trainingplan.folder_view.FolderViewInterface;
import com.example.trainingplan.parser.ExerciseParser;
import com.google.android.material.floatingactionbutton.FloatingActionButton;

import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;

public class ExerciseTab extends Fragment implements FolderViewInterface {
    public static final String EXTRA_EXERCISE_LIST = "com.example.trainingplan.EXERCISE_LIST";
    public static final String EXTRA_EXERCISE = "com.example.trainingplan.EXERCISE";
    FolderViewAdapter folderAdapter;
    FloatingActionButton addButton;
    public ExerciseTab() { }// Required empty public constructor

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.exercise_fragment, container, false);// Inflate the layout for this fragment
        RecyclerView recyclerView = view.findViewById(R.id.exerciseFolderView);

        ExerciseParser parser = new ExerciseParser(container.getContext());
        folderAdapter = new FolderViewAdapter(container.getContext(), parser.getFolderList_(), this);

        recyclerView.setAdapter(folderAdapter);
        recyclerView.setLayoutManager(new LinearLayoutManager(container.getContext()));

        addButton = view.findViewById(R.id.addExerciseButton);
        addButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                Intent intent = new Intent(container.getContext(), AddExerciseActivity.class);
                intent.putParcelableArrayListExtra(EXTRA_EXERCISE_LIST, new ArrayList<>(folderAdapter.folderList_));
                startActivity(intent);
            }
        });

        return view;
    }

    @Override
    public void OnItemClick(int position) {
        FolderModel folder = folderAdapter.folderList_.get(position);
        folder.setExtended_(!folder.getExtended_());
        folderAdapter.notifyItemChanged(position);
    }
}