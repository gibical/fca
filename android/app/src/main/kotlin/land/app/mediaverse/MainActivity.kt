package land.app.mediaverse

import android.app.Activity
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.media.projection.MediaProjectionManager
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.core.content.ContextCompat
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import land.app.mediaverse.BuildConfig

class MainActivity : FlutterActivity() {

    private val REQUEST_CODE_SCREEN_CAPTURE = 1000
    private var rtmpUrl: String? = null

    // تغییر ۱: نام کانال را طبق طعم (flavor) ست می‌کنیم
    private var CHANNEL = "app.gibical.app/rtmp"

    // یک Reference به MethodChannel
    private lateinit var methodChannel: MethodChannel

    private lateinit var mediaProjectionManager: MediaProjectionManager

    // تغییر ۲: یک BroadcastReceiver برای دریافت پیام stopTheStream از سرویس
    private val screenCaptureBroadcastReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            val action = intent?.getStringExtra("action")
            if (action == "stopTheStream") {
                // هر متدی که می‌خواهید در فلاتر صدا بزنید
                methodChannel.invokeMethod("onStreamStopped", null)
            }
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // تعیین CHANNEL بر اساس طعم (flavor) برنامه
        if (BuildConfig.FLAVOR == "mediaverse") {
            CHANNEL = "land.mediaverse.app/rtmp"
        } else if (BuildConfig.FLAVOR == "gibical") {
            CHANNEL = "app.gibical.app/rtmp"
        } else if (BuildConfig.FLAVOR == "ravi") {
            CHANNEL = "ir.app.ravi"
        }

        // ساخت MethodChannel و پیاده‌سازی متدها
        methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "startScreenShare" -> {
                    rtmpUrl = call.argument<String>("rtmpUrl")
                    if (rtmpUrl != null) {
                        startScreenCapture()
                        result.success("Screen sharing started")
                    } else {
                        result.error("INVALID_ARGUMENT", "RTMP URL is required", null)
                    }
                }

                "stopScreenShare" -> {
                    stopScreenCapture()
                    result.success("Screen sharing stopped")
                }

                "isLive" -> {
                    val checkUrl = call.argument<String>("rtmpUrl")
                    if (checkUrl != null) {
                        val isLive = ScreenCaptureService.isCapturing &&
                                ScreenCaptureService.currentRtmpUrl == checkUrl
                        result.success(isLive)
                    } else {
                        // اگر بخواهید فقط بدانید هر استریمی فعال است یا نه
                        result.success(ScreenCaptureService.isCapturing)
                    }
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // مقداردهی MediaProjectionManager
        mediaProjectionManager = getSystemService(MEDIA_PROJECTION_SERVICE) as MediaProjectionManager

        // ثبت BroadcastReceiver برای دریافت پیام‌های سرویس
        LocalBroadcastManager.getInstance(this).registerReceiver(
            screenCaptureBroadcastReceiver,
            IntentFilter("com.app.gibical.SCREEN_CAPTURE_SERVICE")
        )
    }

    // فراخوانی Intent برای گرفتن Permission کپچر صفحه
    private fun startScreenCapture() {
        val captureIntent = mediaProjectionManager.createScreenCaptureIntent()
        startActivityForResult(captureIntent, REQUEST_CODE_SCREEN_CAPTURE)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUEST_CODE_SCREEN_CAPTURE && resultCode == Activity.RESULT_OK && data != null) {
            val serviceIntent = Intent(this, ScreenCaptureService::class.java).apply {
                putExtra("resultCode", resultCode)
                putExtra("data", data)
                putExtra("rtmpUrl", rtmpUrl)
            }
            methodChannel.invokeMethod("onStreamStarted", null)

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                ContextCompat.startForegroundService(this, serviceIntent)
            } else {
                startService(serviceIntent)
            }

        } else {
           // Toast.makeText(this, "Screen Cast Permission Denied", Toast.LENGTH_SHORT).show()
        }
    }

    private fun stopScreenCapture() {
        val serviceIntent = Intent(this, ScreenCaptureService::class.java)
        stopService(serviceIntent)

        methodChannel.invokeMethod("onStreamStopped", null)
    }

    override fun onDestroy() {
        super.onDestroy()
        // در صورت ترک اکتیویتی، سرویس را متوقف می‌کنیم
        stopScreenCapture()

        // آن‌ریجیستر کردن BroadcastReceiver
        LocalBroadcastManager.getInstance(this).unregisterReceiver(screenCaptureBroadcastReceiver)
    }
}
