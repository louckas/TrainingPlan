package com.example.trainingplan.parser;

import android.content.Context;
import android.os.Environment;
import android.util.JsonWriter;
import android.util.Log;

import com.example.trainingplan.exercise_view.ExerciseModel;
import com.example.trainingplan.folder_view.FolderModel;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

public class ExerciseParser {
    Context context_;
    ArrayList<FolderModel> folderList_ = new ArrayList<>();

    public ExerciseParser(Context context) {
        if(isExternalStorageReadable()) {
            context_ = context;
            try {
                File f = new File(context_.getExternalFilesDir(null), "exercise.json");
                FileInputStream file = new FileInputStream(f);

                int size = file.available();
                byte[] buffer = new byte[size];
                file.read(buffer);
                file.close();

                JSONObject json = new JSONObject(new String(buffer, StandardCharsets.UTF_8));
                JSONArray folders = json.getJSONArray("exerciseGroup");

                for (int i = 0; i < folders.length(); ++i) {
                    ArrayList<ExerciseModel> exercisesList = new ArrayList<>();
                    String folderName = folders.getString(i);

                    JSONObject bloc = json.getJSONObject(folderName);
                    JSONArray exercises = bloc.getJSONArray("exercise");
                    JSONArray exercisesDescription = bloc.getJSONArray("description");

                    for (int j = 0; (j < exercises.length()) && (j < exercisesDescription.length()); ++j) {
                        exercisesList.add(new ExerciseModel(exercises.getString(j), exercisesDescription.getString(j), folderName));
                    }

                    FolderModel folder = new FolderModel(folderName, false, exercisesList);
                    folderList_.add(folder);
                }
            } catch (IOException e) {
                Log.e("ExerciseParser", "Input File error");
                e.printStackTrace();

            } catch (JSONException e) {
                Log.e("ExerciseParser", "Invalid JSON error");
                e.printStackTrace();
            }
        }
    }

    public void saveList(ArrayList<FolderModel> folderList) {
        if(isExternalStorageWritable())
        {
            try {
                File f = new File(context_.getExternalFilesDir(null), "exercise.json");
                FileOutputStream file = new FileOutputStream(f);

                JsonWriter json = new JsonWriter(new OutputStreamWriter(file, StandardCharsets.UTF_8));
                json.setIndent("    ");

                json.beginObject();

                json.name("exerciseGroup").beginArray();
                for (int i = 0; i < folderList.size(); ++i) {
                    json.value(folderList.get(i).getFolderName_());
                }
                json.endArray();


                for (int i = 0; i < folderList.size(); ++i) {
                    json.name(folderList.get(i).getFolderName_()).beginObject();

                    List<ExerciseModel> list = folderList.get(i).getExerciseList_();

                    json.name("exercise").beginArray();
                    for (int j = 0; j < list.size(); ++j)
                        json.value(list.get(j).getExerciseName_());
                    json.endArray();

                    json.name("description").beginArray();
                    for (int j = 0; j < list.size(); ++j)
                        json.value(list.get(j).getDescription_());
                    json.endArray();

                    json.endObject();
                }

                json.endObject();
                json.flush();
                json.close();
                file.close();
            } catch(IOException e){
                e.printStackTrace();
            }
        }
    }

    public boolean isExternalStorageWritable() {
        String state = Environment.getExternalStorageState();
        if (Environment.MEDIA_MOUNTED.equals(state)) {
            return true;
        }
        return false;
    }

    public boolean isExternalStorageReadable() {
        String state = Environment.getExternalStorageState();
        if (Environment.MEDIA_MOUNTED.equals(state) ||
                Environment.MEDIA_MOUNTED_READ_ONLY.equals(state)) {
            return true;
        }
        return false;
    }

    public ArrayList<FolderModel> getFolderList_() { return folderList_; }

}
