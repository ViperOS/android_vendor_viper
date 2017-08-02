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

package com.viper.themechooser;

import android.content.ContentResolver;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.provider.Settings;
import android.support.v14.preference.SwitchPreference;
import android.support.v7.preference.Preference;
import android.support.v7.preference.Preference.OnPreferenceChangeListener;
import android.view.MenuItem;
import android.app.ActivityManager;

import com.android.internal.logging.MetricsProto.MetricsEvent;
import com.android.settings.R;
import com.android.settings.SettingsPreferenceFragment;

public class ChooserSettingsActivity extends SettingsPreferenceFragment implements OnPreferenceChangeListener {

    private SwitchPreference mLauncherAllowAccent;

    private String KEY_LAUNCHER_ALLOW_ACCENT = "viper_colorengine_launcher_allow_accent";

    private String LAUNCHER_PACKAGE_NAME = "ch.deletescape.lawnchair";

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        addPreferencesFromResource(R.xml.chooser_settings);
        ContentResolver resolver = getActivity().getContentResolver();

        mLauncherAllowAccent = (SwitchPreference) findPreference(KEY_LAUNCHER_ALLOW_ACCENT);
        mLauncherAllowAccent.setOnPreferenceChangeListener(this);

        boolean isAllowed = Settings.Secure.getInt(resolver, Settings.Secure.VIPER_COLORENGINE_LAUNCHER_ALLOW_ACCENT, 1) == 1;
        mLauncherAllowAccent.setChecked(isAllowed);
        if (!isStockLauncher(getActivity())) {
            mLauncherAllowAccent.setEnabled(false);
        }
    }

    private Boolean isStockLauncher(Context context) {
        try {
            PackageInfo pInfo = context.getPackageManager().getPackageInfo(LAUNCHER_PACKAGE_NAME, PackageManager.GET_META_DATA);
            return pInfo.versionName.contains("-mod-viperos");
        } catch (PackageManager.NameNotFoundException ex) {
            return false;
        }
    }

    private void killStockLauncher(Context context) {
        try{
            ActivityManager am = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
            am.forceStopPackage(LAUNCHER_PACKAGE_NAME);
        }catch (Exception ex){
        }
    }

    @Override
    public boolean onPreferenceChange(Preference preference, Object newValue) {
        ContentResolver resolver = getActivity().getContentResolver();
        if (preference == mLauncherAllowAccent) {
            boolean isEnabled = ((Boolean) newValue);
            Settings.Secure.putInt(resolver, Settings.Secure.VIPER_COLORENGINE_LAUNCHER_ALLOW_ACCENT,
                    isEnabled ? 1 : 0);
            killStockLauncher(getActivity());
            return true;
        }
        return false;
    }


    @Override
    protected int getMetricsCategory() {
        return MetricsEvent.VENOM;
    }

    @Override
    public void onResume() {
        super.onResume();
    }

} 
