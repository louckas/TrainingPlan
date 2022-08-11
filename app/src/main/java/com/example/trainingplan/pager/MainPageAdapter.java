package com.example.trainingplan.pager;

import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentStatePagerAdapter;

import com.example.trainingplan.tabs.ExerciseTab;
import com.example.trainingplan.tabs.PlanningTab;
import com.example.trainingplan.tabs.WorkoutTab;

public class MainPageAdapter extends FragmentStatePagerAdapter {

    int numOfTabs_;

    public MainPageAdapter(FragmentManager fm, int NumOfTabs) {
        super(fm);
        numOfTabs_ = NumOfTabs;
    }

    @Override
    public Fragment getItem(int position) {

        switch (position) {
            case 0:
                PlanningTab tab1 = new PlanningTab();
                return tab1;
            case 1:
                WorkoutTab tab2 = new WorkoutTab();
                return tab2;
            case 2:
                ExerciseTab tab3 = new ExerciseTab();
                return tab3;
            default:
                return null;
        }
    }

    @Override
    public int getCount() {
        return numOfTabs_;
    }

}
