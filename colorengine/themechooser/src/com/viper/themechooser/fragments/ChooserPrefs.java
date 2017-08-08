/*
 * Copyright (C) 2017 ViperOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.viper.themechooser.fragments;

import android.app.AlertDialog;
import android.app.UiModeManager;
import android.content.ComponentName;
import android.content.ContentResolver;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.Resources;
import android.os.Bundle;
import android.preference.PreferenceFragment;
import android.util.Log;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.Toast;

import com.android.settings.R;
import com.kizitonwose.colorpreference.ColorDialog;
import com.kizitonwose.colorpreference.ColorPreference;
import com.viper.colorengine.utils.ColorEngineUtils;

import static android.content.Context.MODE_PRIVATE;

public class ChooserPrefs extends PreferenceFragment implements ColorDialog.OnColorSelectedListener {

    private static final String TAG = Thread.currentThread().getStackTrace()[1].getClassName();

    private static final int MENU_APPLY = Menu.FIRST;
    private static final int MENU_SETTINGS = Menu.FIRST + 1;
    private static final int MENU_RESET_DEFAULT_THEME = Menu.FIRST + 2;

    private ColorPreference primaryColor;
    private ColorPreference accentColor;

    private String KEY_PRIMARY_COLOR = "primary_color";
    private String KEY_ACCENT_COLOR = "accent_color";

    private String TAG_PRIMARY_COLOR = "color_primary_color";
    private String TAG_ACCENT_COLOR = "color_accent_color";

    private Menu menu;

    private UiModeManager uiManager;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        addPreferencesFromResource(R.xml.chooser_prefs);
        setHasOptionsMenu(true);
        ContentResolver resolver = getActivity().getContentResolver();
        Resources res = getResources();

        uiManager = (UiModeManager) getActivity().getSystemService(Context.UI_MODE_SERVICE);
        primaryColor = (ColorPreference) findPreference(KEY_PRIMARY_COLOR);
        accentColor = (ColorPreference) findPreference(KEY_ACCENT_COLOR);

        configurePrefs();

        primaryColor.setOnColorSelectedListener(this);
        accentColor.setOnColorSelectedListener(this);
    }

    private void configurePrefs(){
        primaryColor.setValue(ColorEngineUtils.getPrimaryColor(uiManager.getNightMode()));
        primaryColor.setColorsArray(ColorEngineUtils.getPrimaryColors());
        accentColor.setValue(ColorEngineUtils.getAccentColor(uiManager.getNightMode()));
        accentColor.setColorsArray(ColorEngineUtils.getAccentColors(primaryColor.getValue()));
    }

    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        View lv = getView().findViewById(android.R.id.list);
        if (lv != null) lv.setPadding(0, 0, 0, 0);
    }

    @Override
    public void onColorSelected(int newColor, String tag) {
        if (!tag.equals(TAG_PRIMARY_COLOR) && !tag.equals(TAG_ACCENT_COLOR)) {
            return;
        }
        if (tag.equals(TAG_PRIMARY_COLOR)) {
            primaryColor.setValue(newColor);
        } else if (tag.equals(TAG_ACCENT_COLOR)) {
            accentColor.setValue(newColor);
        }
        accentColor.setColorsArray(ColorEngineUtils.getAccentColors(primaryColor.getValue()));
        int currentNightMode = uiManager.getNightMode();
        int newNightMode = ColorEngineUtils.colorToNightModeInt(primaryColor.getValue(), accentColor.getValue());

        boolean isColorEqualsToAlreadyApplied = newNightMode == ColorEngineUtils.getAppliedColor(getActivity());
        setApplyIconEnabled(isColorEqualsToAlreadyApplied ? false : (currentNightMode != newNightMode));
        if (currentNightMode != newNightMode) {
            uiManager.setNightMode(newNightMode);
            updateResetToDefaultTheme();
        }
        showApplyToast();
    }

    @Override
    public void onResume() {
        super.onResume();
        setApplyIconEnabled((uiManager.getNightMode() == ColorEngineUtils.getAppliedColor(getActivity())) ? false : ColorEngineUtils.isApplyRequired(getActivity()));
        updateResetToDefaultTheme();
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        menu.add(0, MENU_APPLY, 0, R.string.apply_theme)
                .setIcon(R.drawable.ic_apply_theme)
                .setEnabled(ColorEngineUtils.isApplyRequired(getActivity()))
                .setShowAsAction(MenuItem.SHOW_AS_ACTION_ALWAYS);
        menu.add(0, MENU_SETTINGS, 0, R.string.theme_chooser_settings_title)
                .setShowAsAction(MenuItem.SHOW_AS_ACTION_NEVER);
        menu.add(0, MENU_RESET_DEFAULT_THEME, 0, R.string.reset_default_theme)
                .setEnabled(uiManager.getNightMode() != ColorEngineUtils.MODE_NIGHT_DEFAULT)
                .setShowAsAction(MenuItem.SHOW_AS_ACTION_NEVER);
        this.menu = menu;
    }

    private void setApplyIconEnabled(Boolean enabled) {
        ColorEngineUtils.setApplyRequired(getActivity(), enabled);
        if (menu == null) {
            return;
        }
        menu.getItem(MENU_APPLY).setEnabled(enabled);
    }

    private void showResetToDefaultThemeDialog() {
        AlertDialog.Builder builder = new AlertDialog.Builder(getActivity());
        builder.setTitle(R.string.reset_default_theme);
        builder.setMessage(R.string.reset_default_theme_message);
        builder.setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
            public void onClick(DialogInterface dialog, int which) {
                setApplyIconEnabled(false);
                ColorEngineUtils.resetToDefaultTheme(getActivity(), getActivity().getResources().getString(R.string.reset_default_progress));
                dialog.dismiss();
            }
        });

        builder.setNegativeButton(android.R.string.no, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });

        AlertDialog alert = builder.create();
        alert.show();
    }

    private void updateResetToDefaultTheme(){
        if (menu == null) {
            return;
        }
        menu.getItem(MENU_RESET_DEFAULT_THEME).setEnabled(uiManager.getNightMode() != ColorEngineUtils.MODE_NIGHT_DEFAULT);
    }

    private void showApplyToast(){
        SharedPreferences prefs = getActivity().getSharedPreferences("color_engine", MODE_PRIVATE);
        boolean alreadyShown = prefs.getInt("apply_toast_already_shown", 0) == 1;
        if (!alreadyShown){
            SharedPreferences.Editor editor = getActivity().getSharedPreferences("color_engine", MODE_PRIVATE).edit();
            editor.putInt("apply_toast_already_shown", 1);
            editor.apply();
            Toast.makeText(getActivity(), getActivity().getResources().getString(R.string.apply_theme_toast), Toast.LENGTH_LONG).show();
        }
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case MENU_APPLY:
                setApplyIconEnabled(false);
                ColorEngineUtils.apply(getActivity(), getActivity().getResources().getString(R.string.apply_theme_progress), false);
                return true;
            case MENU_SETTINGS:
                Intent intent = new Intent();
                intent.setComponent(new ComponentName("com.android.settings", "com.android.settings.Settings$ThemeChooserSettingsActivity"));
                intent.putExtra("show_back_icon", true);
                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK);
                getActivity().startActivity(intent);
                return true;
            case MENU_RESET_DEFAULT_THEME:
                showResetToDefaultThemeDialog();
                return true;
            default:
                return false;
        }
    }
}
