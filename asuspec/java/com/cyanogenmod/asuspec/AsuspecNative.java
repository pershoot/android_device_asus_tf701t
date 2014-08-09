/*
 * Copyright (C) 2012 The CyanogenMod Project
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

package com.cyanogenmod.asuspec;

import android.util.Log;

public final class AsuspecNative {

    private static final String TAG = "AsuspecNative";

    private static final boolean DEBUG = false;

    private static boolean sLoaded = false;

    public static synchronized void loadAsuspecLib() {
        if (!sLoaded) {
            System.loadLibrary("asuspec_jni");
            sLoaded = true;
            if (DEBUG) {
                Log.i(TAG, "Asuspec native library loaded");
            }
        }
    }

}
