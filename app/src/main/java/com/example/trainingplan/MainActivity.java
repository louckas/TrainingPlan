package com.example.trainingplan;

import androidx.appcompat.app.AppCompatActivity;
import androidx.viewpager.widget.ViewPager;
import android.os.Bundle;
import com.example.trainingplan.pager.MainPageAdapter;
import com.google.android.material.tabs.TabLayout;

public class MainActivity extends AppCompatActivity {

    ViewPager mainViewPager;
    TabLayout mainTabLayout;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mainViewPager = (ViewPager) findViewById(R.id.mainViewPager);
        mainTabLayout = (TabLayout) findViewById(R.id.mainTabLayout);

        //Added listener to handle when clicking on the tab instead of sweeping through the ViewPager,
        // I haven't  found anything functional that is cleaner.
        mainTabLayout.addOnTabSelectedListener( new TabLayout.OnTabSelectedListener() {
             @Override
             public void onTabSelected(TabLayout.Tab tab) { mainViewPager.setCurrentItem(tab.getPosition());}

             @Override
             public void onTabUnselected(TabLayout.Tab tab) {}

             @Override
             public void onTabReselected(TabLayout.Tab tab) {}
         });


        TabLayout.Tab planningTab = mainTabLayout.newTab();
        planningTab.setText("Planning");
        mainTabLayout.addTab(planningTab);

        TabLayout.Tab workoutTab = mainTabLayout.newTab();
        workoutTab.setText("Workout");
        mainTabLayout.addTab(workoutTab);

        TabLayout.Tab exerciseTab = mainTabLayout.newTab();
        exerciseTab.setText("Exercise");
        mainTabLayout.addTab(exerciseTab);

//        TabLayout.Tab settingsTab = mainTabLayout.newTab();
//        settingsTab.setText("Settings");
//        mainTabLayout.addTab(settingsTab);

        MainPageAdapter adapter = new MainPageAdapter(getSupportFragmentManager(), mainTabLayout.getTabCount());
        mainViewPager.setAdapter(adapter);
        mainViewPager.addOnPageChangeListener(new TabLayout.TabLayoutOnPageChangeListener(mainTabLayout)); // addOnPageChangeListener event will change the tab on swipe

    }


}