package com.example.myapp

import android.os.Build
import android.os.Bundle
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity
import io.isar.Isar
import com.example.myapp.ExpenseSchema
import com.example.myapp.CategorySchema
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import android.content.Context
import io.flutter.FlutterInjector

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Isar.initialize(this)
    }
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }
    override fun attachBaseContext(context: Context) {
        super.attachBaseContext(context)
        FlutterInjector.instance().flutterLoader().startInitialization(this)
    }
}
