package com.iris.finance

import android.os.Bundle
import android.os.PersistableBundle
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        this.cacheDir.deleteRecursively()
        super.onCreate(savedInstanceState, persistentState)
    }
}