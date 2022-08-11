package com.example.trainingplan.folder_view;
import com.example.trainingplan.R;
import com.example.trainingplan.exercise_view.ExerciseAdapter;
import com.example.trainingplan.exercise_view.ExerciseInterface;
import com.example.trainingplan.exercise_view.ExerciseModel;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.cardview.widget.CardView;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;
import java.util.List;

public class FolderViewAdapter extends RecyclerView.Adapter<FolderViewAdapter.MyViewHolder> implements ExerciseInterface {

    private final FolderViewInterface folderInterface_;
    Context context_;
    public ArrayList<FolderModel> folderList_;
    ExerciseAdapter exerciseAdapter;


    public FolderViewAdapter (Context context, ArrayList<FolderModel> folderList, FolderViewInterface folderInterface) {
        context_ = context;
        folderList_ = folderList;
        folderInterface_  = folderInterface;
    }

    @NonNull
    @Override
    public FolderViewAdapter.MyViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        // Inflate the layout and make the looks of it
        LayoutInflater inflater = LayoutInflater.from(context_);
        View view = inflater.inflate(R.layout.folder_row, parent, false);

        return new FolderViewAdapter.MyViewHolder(view, folderInterface_);
    }

    @Override
    public void onBindViewHolder(@NonNull FolderViewAdapter.MyViewHolder holder, int position) {
        // Assign values to the view that will be created in the each row of the recycler view based on the position
        holder.folderName.setText(folderList_.get(position).getFolderName_());
        holder.subListLayout.setVisibility(folderList_.get(position).getExtended_() ? View.VISIBLE : View.GONE);

        RecyclerView exerciseView = holder.itemView_.findViewById(R.id.subListView);
        exerciseAdapter = new ExerciseAdapter(context_, folderList_.get(position).exerciseList_, this);
        exerciseView.setAdapter(exerciseAdapter);
        exerciseView.setLayoutManager(new LinearLayoutManager(context_));
    }

    @Override
    public int getItemCount() {
        // Return the number of items to display
        return folderList_.size();
    }

    @Override
    public void OnItemClick(int position) {
        ExerciseModel exercise = exerciseAdapter.exerciseList_.get(position);
    }

    public static class MyViewHolder extends RecyclerView.ViewHolder {
        // Grab the view from from the folder_row layout

        CardView topCard;
        ImageView openCloseArrow;
        TextView folderName;
        RecyclerView subList;
        ConstraintLayout subListLayout;
        ConstraintLayout titleLayout;
        View itemView_;

        public MyViewHolder(@NonNull View itemView, FolderViewInterface folderInterface) {
            super(itemView);
            itemView_ = itemView;
            topCard = itemView.findViewById(R.id.cardView);
            titleLayout = itemView.findViewById(R.id.titleView);
            openCloseArrow = itemView.findViewById(R.id.ocarrow);
            folderName = itemView.findViewById(R.id.folderName);
            subList = itemView.findViewById(R.id.subListView);
            subListLayout = itemView.findViewById(R.id.subListLayout);

            titleLayout.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if(folderInterface != null) {
                        int pos = getAdapterPosition();

                        if(pos != RecyclerView.NO_POSITION) {
                            folderInterface.OnItemClick(pos);
                        }
                    }
                }
            });
        }
    }
}
