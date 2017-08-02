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

package com.viper.colorengine.utils;

import android.app.ProgressDialog;
import android.app.UiModeManager;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.os.UserHandle;
import android.provider.Settings;
import android.graphics.Color;
import android.app.Activity;

import java.util.Arrays;
import java.util.List;

import static android.content.Context.MODE_PRIVATE;

public class ColorEngineUtils {

    private static final int MODE_NIGHT_AUTO = 0;
    private static final int MODE_NIGHT_NO = 1;
    private static final int MODE_NIGHT_YES = 2;
    private static final int MODE_NIGHT_YES_PINK = 3;
    private static final int MODE_NIGHT_YES_AMBER = 4;
    private static final int MODE_NIGHT_YES_RED = 5;
    private static final int MODE_NIGHT_YES_TEAL = 6;
    private static final int MODE_NIGHT_YES_AQUA = 7;
    private static final int MODE_NIGHT_NO_WHITEPINK = 8;
    private static final int MODE_NIGHT_NO_WHITEAMBER = 9;
    private static final int MODE_NIGHT_NO_WHITERED = 10;
    private static final int MODE_NIGHT_NO_WHITETEAL = 11;
    private static final int MODE_NIGHT_NO_WHITEAQUA = 12;
    private static final int MODE_NIGHT_YES_PURPLE = 13;
    private static final int MODE_NIGHT_NO_WHITEPURPLE = 14;

    public static final int MODE_NIGHT_DEFAULT = MODE_NIGHT_NO;

    private static final String THEME_ENGINE_COLOR_WHITE = "#ffffff";
    private static final String THEME_ENGINE_COLOR_BLACK = "#000000";
    private static final String THEME_ENGINE_COLOR_BLUE = "#4285f4";
    private static final String THEME_ENGINE_COLOR_AMBER = "#ffc107";
    private static final String THEME_ENGINE_COLOR_AQUA = "#00bcd4";
    private static final String THEME_ENGINE_COLOR_TEAL = "#009688";
    private static final String THEME_ENGINE_COLOR_PINK = "#e91e63";
    private static final String THEME_ENGINE_COLOR_RED = "#e50914";
    private static final String THEME_ENGINE_COLOR_PURPLE = "#673ab7";

    private static final List<String> THEME_ENGINE_PRIMARY_COLORS = Arrays.asList(
            THEME_ENGINE_COLOR_WHITE, THEME_ENGINE_COLOR_BLACK);

    private static final List<String> THEME_ENGINE_ACCENT_COLORS = Arrays.asList(
            THEME_ENGINE_COLOR_BLUE, THEME_ENGINE_COLOR_AMBER,
            THEME_ENGINE_COLOR_AQUA, THEME_ENGINE_COLOR_TEAL,
            THEME_ENGINE_COLOR_PINK, THEME_ENGINE_COLOR_RED,
            THEME_ENGINE_COLOR_PURPLE);

    private static final List<String> THEME_ENGINE_ACCENT_COLORS_BLACK = Arrays.asList(
            THEME_ENGINE_COLOR_BLUE, THEME_ENGINE_COLOR_AMBER,
            THEME_ENGINE_COLOR_AQUA, THEME_ENGINE_COLOR_TEAL,
            THEME_ENGINE_COLOR_PINK, THEME_ENGINE_COLOR_RED,
            THEME_ENGINE_COLOR_PURPLE);

    private static final String INTENT_RESTART_SYSTEMUI = "restart_systemui";

    public static int[] getPrimaryColors(){
        String[] primaryColors = THEME_ENGINE_PRIMARY_COLORS.toArray(new String[THEME_ENGINE_PRIMARY_COLORS.size()]);
        return extractColorArray(primaryColors);
    }

    public static int[] getAccentColors(int primaryColor){
        String[] accentColors = THEME_ENGINE_ACCENT_COLORS.toArray(new String[THEME_ENGINE_ACCENT_COLORS.size()]);
        if (primaryColor == Color.parseColor(THEME_ENGINE_COLOR_WHITE)){
            accentColors = THEME_ENGINE_ACCENT_COLORS.toArray(new String[THEME_ENGINE_ACCENT_COLORS.size()]);
        } else if (primaryColor == Color.parseColor(THEME_ENGINE_COLOR_BLACK)){
            accentColors = THEME_ENGINE_ACCENT_COLORS_BLACK.toArray(new String[THEME_ENGINE_ACCENT_COLORS_BLACK.size()]);
        }
        return extractColorArray(accentColors);
    }

    private static int[] extractColorArray(String colors[]) {
        int[] result = new int[colors.length];
        for (int i = 0; i < colors.length; i++) {
            result[i] = Color.parseColor(colors[i]);
        }
        return result;
    }

    public static void restartSystemUI(Context context) {
        try {
            context.sendBroadcastAsUser(new Intent(INTENT_RESTART_SYSTEMUI), new UserHandle(UserHandle.USER_ALL));
        } catch (Exception ex) {
        }
    }

    public static int getDefaultPrimaryColor() {
        return Color.parseColor(THEME_ENGINE_COLOR_WHITE);
    }

    public static int getDefaultAccentColor() {
        return Color.parseColor(THEME_ENGINE_COLOR_BLUE);
    }

    public static int getPrimaryColor(int nightMode) {
        switch (nightMode) {
            case MODE_NIGHT_YES:
            case MODE_NIGHT_YES_PINK:
            case MODE_NIGHT_YES_AMBER:
            case MODE_NIGHT_YES_RED:
            case MODE_NIGHT_YES_TEAL:
            case MODE_NIGHT_YES_AQUA:
            case MODE_NIGHT_YES_PURPLE:
                return Color.parseColor(THEME_ENGINE_COLOR_BLACK);
            case MODE_NIGHT_AUTO:
            case MODE_NIGHT_NO:
            case MODE_NIGHT_NO_WHITEPINK:
            case MODE_NIGHT_NO_WHITEAMBER:
            case MODE_NIGHT_NO_WHITERED:
            case MODE_NIGHT_NO_WHITETEAL:
            case MODE_NIGHT_NO_WHITEAQUA:
            case MODE_NIGHT_NO_WHITEPURPLE:
                return Color.parseColor(THEME_ENGINE_COLOR_WHITE);
        }
        return getDefaultPrimaryColor();
    }

    public static int getAccentColor(int nightMode) {
        switch (nightMode) {
            case MODE_NIGHT_AUTO:
            case MODE_NIGHT_YES:
            case MODE_NIGHT_NO:
                return Color.parseColor(THEME_ENGINE_COLOR_BLUE);
            case MODE_NIGHT_YES_PINK:
            case MODE_NIGHT_NO_WHITEPINK:
                return Color.parseColor(THEME_ENGINE_COLOR_PINK);
            case MODE_NIGHT_YES_AMBER:
            case MODE_NIGHT_NO_WHITEAMBER:
                return Color.parseColor(THEME_ENGINE_COLOR_AMBER);
            case MODE_NIGHT_YES_RED:
            case MODE_NIGHT_NO_WHITERED:
                return Color.parseColor(THEME_ENGINE_COLOR_RED);
            case MODE_NIGHT_YES_TEAL:
            case MODE_NIGHT_NO_WHITETEAL:
                return Color.parseColor(THEME_ENGINE_COLOR_TEAL);
            case MODE_NIGHT_YES_AQUA:
            case MODE_NIGHT_NO_WHITEAQUA:
                return Color.parseColor(THEME_ENGINE_COLOR_AQUA);
            case MODE_NIGHT_YES_PURPLE:
            case MODE_NIGHT_NO_WHITEPURPLE:
                return Color.parseColor(THEME_ENGINE_COLOR_PURPLE);
        }
        return getDefaultAccentColor();
    }

    public static int colorToNightModeInt(int primaryColor, int accentColor) {
        Boolean isPrimaryColorWhite = primaryColor == Color.parseColor(THEME_ENGINE_COLOR_WHITE);
        Boolean isPrimaryColorBlack = primaryColor == Color.parseColor(THEME_ENGINE_COLOR_BLACK);

        if (accentColor == Color.parseColor(THEME_ENGINE_COLOR_AMBER)){
            if (isPrimaryColorWhite){ return  9; }
            if (isPrimaryColorBlack){ return  4; }
        } else if (accentColor == Color.parseColor(THEME_ENGINE_COLOR_AQUA)){
            if (isPrimaryColorWhite){ return 12; }
            if (isPrimaryColorBlack){ return  7; }
        } else if (accentColor == Color.parseColor(THEME_ENGINE_COLOR_BLUE)){
            if (isPrimaryColorWhite){ return  1; }
            if (isPrimaryColorBlack){ return  2; }
        } else if (accentColor == Color.parseColor(THEME_ENGINE_COLOR_PINK)){
            if (isPrimaryColorWhite){ return  8; }
            if (isPrimaryColorBlack){ return  3; }
        } else if (accentColor == Color.parseColor(THEME_ENGINE_COLOR_PURPLE)){
            if (isPrimaryColorWhite){ return 14; }
            if (isPrimaryColorBlack){ return 13; }
        } else if (accentColor == Color.parseColor(THEME_ENGINE_COLOR_RED)){
            if (isPrimaryColorWhite){ return 10; }
            if (isPrimaryColorBlack){ return  5; }
        } else if (accentColor == Color.parseColor(THEME_ENGINE_COLOR_TEAL)){
            if (isPrimaryColorWhite){ return 11; }
            if (isPrimaryColorBlack){ return  6; }
        }
        /*else if (accentColor == Color.parseColor(THEME_ENGINE_COLOR_WHITE)){
            if (isPrimaryColorWhite){ return 11;  }
            return 1;
        }*/
        return 1;
    }

    public static Boolean isApplyRequired(Context context) {
        return Settings.Secure.getIntForUser(context.getContentResolver(), Settings.Secure.VIPER_COLORENGINE_IS_APPLY_REQUIRED, 0, UserHandle.USER_CURRENT) == 1;
    }

    public static void setApplyRequired(Context context, Boolean required) {
        Settings.Secure.putIntForUser(context.getContentResolver(), Settings.Secure.VIPER_COLORENGINE_IS_APPLY_REQUIRED, required ? 1 : 0, UserHandle.USER_CURRENT);
    }

    private static void saveAppliedColor(Context context){
        UiModeManager uiManager = (UiModeManager) context.getSystemService(Context.UI_MODE_SERVICE);
        SharedPreferences.Editor editor = context.getSharedPreferences("color_engine", MODE_PRIVATE).edit();
        editor.putInt("applied_color", uiManager.getNightMode());
        editor.apply();
    }

    public static int getAppliedColor(Context context){
        if (!isApplyRequired(context)){
            //return MODE_NIGHT_DEFAULT;
        }
        SharedPreferences prefs = context.getSharedPreferences("color_engine", MODE_PRIVATE);
        return prefs.getInt("applied_color", MODE_NIGHT_DEFAULT);
    }

    public static void apply(final Context context, final String dialogMessage, final Boolean closeThemeChooser) {
        saveAppliedColor(context);
        new AsyncTask<Void, Void, Void>() {
            private ProgressDialog dialog;

            protected void onPreExecute() {
                if (dialogMessage != null){
                    dialog = new ProgressDialog(context);
                    dialog.setMessage(dialogMessage);
                    dialog.setCancelable(false);
                    dialog.setIndeterminate(true);
                    dialog.show();
                }
            }

            protected Void doInBackground(Void... unused) {
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    // Ignore
                }
                return null;
            }

            protected void onPostExecute(Void unused) {
                setApplyRequired(context, false);
                restartSystemUI(context);
                try{
                    dialog.dismiss();
                } catch (Exception e) {
                }
                if (closeThemeChooser){
                    try{
                        ((Activity) context).finish();
                    } catch (Exception e) {
                    }
                }
            }
        }.execute();
    }

    public static void resetToDefaultTheme(final Context context, final String dialogMessage) {

        new AsyncTask<Void, Void, Void>() {
            private ProgressDialog dialog;

            protected void onPreExecute() {
                dialog = new ProgressDialog(context);
                dialog.setMessage(dialogMessage);
                dialog.setCancelable(false);
                dialog.setIndeterminate(true);
                dialog.show();
            }
            protected Void doInBackground(Void... unused) {
                try {
                    Thread.sleep(1000);
                    UiModeManager uiManager = (UiModeManager) context.getSystemService(Context.UI_MODE_SERVICE);
                    uiManager.setNightMode(MODE_NIGHT_DEFAULT);
                    Thread.sleep(1000);
                } catch (Exception e) {
                    // Ignore
                }
                return null;
            }
            protected void onPostExecute(Void unused) {
                saveAppliedColor(context);
                setApplyRequired(context, false);
                restartSystemUI(context);
                try{
                    dialog.dismiss();
                } catch (Exception e) {
                }
            }
        }.execute();
    }

    public static void onSystemUIStarted(Context context) {
        setApplyRequired(context,false);
        saveAppliedColor(context);
    }
}
