package com.example.trainingplan.exercise_view;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;

import com.example.trainingplan.R;

import java.util.ArrayList;


public class ExerciseAdapter extends RecyclerView.Adapter<ExerciseAdapter.MyViewHolder> {
    Context context_;
    public ArrayList<ExerciseModel> exerciseList_;
    ExerciseInterface exerciseInterface_;

    public ExerciseAdapter (Context context, ArrayList<ExerciseModel> exerciseList, ExerciseInterface exerciseInterface) {
        context_ = context;
        exerciseList_ = exerciseList;
        exerciseInterface_ = exerciseInterface;
    }

    @NonNull
    @Override
    public ExerciseAdapter.MyViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        // Inflate the layout and make the looks of it
        LayoutInflater inflater = LayoutInflater.from(context_);
        View view = inflater.inflate(R.layout.exercise_row, parent, false);
        return new ExerciseAdapter.MyViewHolder(view, exerciseInterface_);
    }

    @Override
    public void onBindViewHolder(@NonNull ExerciseAdapter.MyViewHolder holder, int position) {
        // Assign values to the view that will be created in the each row of the recycler view based on the position
        holder.exerciseName.setText(exerciseList_.get(position).getExerciseName_());
    }

    @Override
    public int getItemCount() {
        // Return the number of items to display
        return exerciseList_.size();
    }

    public static class MyViewHolder extends RecyclerView.ViewHolder {
        // Grab the view from from the folder_row layout
        TextView exerciseName;
        CardView cardView;
        public MyViewHolder(@NonNull View itemView, ExerciseInterface exerciseInterface) {
            super(itemView);
            exerciseName = itemView.findViewById(R.id.exerciseView);
            cardView = itemView.findViewById(R.id.exerciseCardView);

            cardView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if(exerciseInterface != null) {
                        int pos = getAdapterPosition();

                        if(pos != RecyclerView.NO_POSITION) {
                            exerciseInterface.OnItemClick(pos);
                        }
                    }
                }
            });
        }
    }
}
