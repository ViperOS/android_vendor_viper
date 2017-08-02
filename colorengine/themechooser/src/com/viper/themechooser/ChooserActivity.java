/*
 * Copyright (C) 2015 The Android Open Source Project
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

import android.content.Context;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.os.Bundle;
import android.support.v4.view.ViewPager;
import android.support.v4.view.ViewPager.OnPageChangeListener;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.accessibility.AccessibilityEvent;

import com.android.internal.logging.MetricsProto.MetricsEvent;
import com.android.settings.R;
import com.android.settings.SettingsPreferenceFragment;
import com.android.settings.search.BaseSearchIndexProvider;
import com.android.settings.search.Indexable;
import com.android.settings.search.SearchIndexableRaw;
import com.android.settings.widget.DotsPageIndicator;
import com.viper.themechooser.adapters.PreviewPagerAdapter;
import com.viper.themechooser.fragments.ChooserPrefs;

import java.util.ArrayList;
import java.util.List;

public class ChooserActivity extends SettingsPreferenceFragment implements Indexable {
    /**
     * Index provider used to expose this fragment in search.
     */
    public static final SearchIndexProvider SEARCH_INDEX_DATA_PROVIDER = new BaseSearchIndexProvider() {
        @Override
        public List<SearchIndexableRaw> getRawDataToIndex(Context context, boolean enabled) {
            final Resources res = context.getResources();
            final SearchIndexableRaw data = new SearchIndexableRaw(context);
            data.title = res.getString(R.string.theme_chooser_title);
            data.screenTitle = res.getString(R.string.theme_chooser_title);
            data.keywords = res.getString(R.string.theme_chooser_keywords);
            final List<SearchIndexableRaw> result = new ArrayList<>(1);
            result.add(data);
            return result;
        }
    };
    /**
     * Index of the entry corresponding to current value of the settings.
     */
    protected int mCurrentIndex;
    /**
     * Resource id of the layout that defines the contents inside preview screen.
     */
    private int[] mPreviewSampleResIds;
    private ViewPager mPreviewPager;
    private PreviewPagerAdapter mPreviewPagerAdapter;
    private DotsPageIndicator mPageIndicator;
    private OnPageChangeListener mPreviewPageChangeListener = new OnPageChangeListener() {
        @Override
        public void onPageScrollStateChanged(int state) {
            // Do nothing.
        }

        @Override
        public void onPageScrolled(int position, float positionOffset,
                                   int positionOffsetPixels) {
            // Do nothing.
        }

        @Override
        public void onPageSelected(int position) {
            mPreviewPager.sendAccessibilityEvent(AccessibilityEvent.TYPE_ANNOUNCEMENT);
        }
    };
    private OnPageChangeListener mPageIndicatorPageChangeListener = new OnPageChangeListener() {
        @Override
        public void onPageScrollStateChanged(int state) {
            // Do nothing.
        }

        @Override
        public void onPageScrolled(int position, float positionOffset,
                                   int positionOffsetPixels) {
            // Do nothing.
        }

        @Override
        public void onPageSelected(int position) {
            setPagerIndicatorContentDescription(position);
        }
    };

    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.chooser_activity, container, false);

        Configuration origConfig = getResources().getConfiguration();
        boolean isLayoutRtl = origConfig.getLayoutDirection() == View.LAYOUT_DIRECTION_RTL;

        // This should be replaced once the final preview sample screen is in place.
        mPreviewSampleResIds = new int[]{R.layout.screen_zoom_preview_settings,
                R.layout.viper_logo_preview_layout};

        mPreviewPager = (ViewPager) view.findViewById(R.id.preview_pager);
        mPreviewPagerAdapter = new PreviewPagerAdapter(getActivity(), origConfig, mPreviewSampleResIds);
        mPreviewPager.setAdapter(mPreviewPagerAdapter);
        mPreviewPager.setCurrentItem(isLayoutRtl ? mPreviewSampleResIds.length - 1 : 0);
        mPreviewPager.addOnPageChangeListener(mPreviewPageChangeListener);

        mPageIndicator = (DotsPageIndicator) view.findViewById(R.id.page_indicator);
        if (mPreviewSampleResIds.length > 1) {
            mPageIndicator.setViewPager(mPreviewPager);
            mPageIndicator.setVisibility(View.VISIBLE);
            mPageIndicator.setOnPageChangeListener(mPageIndicatorPageChangeListener);
        } else {
            mPageIndicator.setVisibility(View.GONE);
        }

        setPreviewLayer(0, false);

        if (savedInstanceState == null) {
            getFragmentManager().beginTransaction()
                    .add(R.id.pref, new ChooserPrefs())
                    .commit();
        }

        return view;

    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
    }

    @Override
    public void onSaveInstanceState(Bundle saveState) {
        super.onSaveInstanceState(saveState);
    }

    @Override
    protected int getMetricsCategory() {
        return MetricsEvent.VENOM;
    }

    @Override
    public void onResume() {
        super.onResume();
    }

    private void setPreviewLayer(int index, boolean animate) {
        setPagerIndicatorContentDescription(mPreviewPager.getCurrentItem());
        mPreviewPagerAdapter.setPreviewLayer(index, mCurrentIndex,
                mPreviewPager.getCurrentItem(), animate);

        mCurrentIndex = index;
    }

    private void setPagerIndicatorContentDescription(int position) {
        mPageIndicator.setContentDescription(
                getPrefContext().getString(R.string.preview_page_indicator_content_description,
                        position + 1, mPreviewSampleResIds.length));
    }

}