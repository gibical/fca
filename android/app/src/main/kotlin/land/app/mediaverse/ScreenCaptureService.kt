package land.app.mediaverse

import android.app.*
import android.content.Context
import android.content.Intent
import android.os.Build
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.util.Log
import android.widget.Toast
import androidx.core.app.NotificationCompat
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import com.abolfazlirani.rtmp.utils.ConnectCheckerRtmp
import com.abolfazlirani.rtplibrary.rtmp.RtmpDisplay
import land.app.mediaverse.R

class ScreenCaptureService : Service(), ConnectCheckerRtmp {

    private val TAG = "ScreenCaptureService"
    private val CHANNEL_ID = "ScreenCaptureServiceChannel"
    private lateinit var rtmpDisplay: RtmpDisplay
    private var rtmpUrl: String? = null

    // تغییر ۱: افزودن Companion object برای نگهداری وضعیت سرویس
    companion object {
        var isCapturing = false
        var currentRtmpUrl: String? = null
    }

    override fun onCreate() {
        super.onCreate()
        createNotificationChannel()
        Log.d(TAG, "Service created and notification channel initialized.")
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        Log.d(TAG, "onStartCommand called.")

        if (isCapturing) {
            Log.w(TAG, "Already capturing. Ignoring new start command.")
            return START_NOT_STICKY
        }

        val resultCode = intent?.getIntExtra("resultCode", Activity.RESULT_CANCELED) ?: Activity.RESULT_CANCELED
        val data = intent?.getParcelableExtra<Intent>("data")
        rtmpUrl = intent?.getStringExtra("rtmpUrl")

        Log.d(TAG, "Received intent with resultCode: $resultCode, data: $data, rtmpUrl: $rtmpUrl")

        if (resultCode == Activity.RESULT_OK && data != null && rtmpUrl != null) {
            val notification = createNotification()
            startForeground(1, notification)
            Log.d(TAG, "Foreground service started with notification.")

            // Initialize RtmpDisplay
            rtmpDisplay = RtmpDisplay(this, false, this)
            rtmpDisplay.setIntentResult(resultCode, data)
            Log.d(TAG, "RtmpDisplay initialized.")

            try {
                if (!rtmpDisplay.isStreaming) {
                    val width = 1280
                    val height = 720
                    val fps = 30
                    val bitrate = 2500 * 1024 // 2.5 Mbps
                    val rotation = 0
                    val dpi = resources.displayMetrics.densityDpi

                    Log.d(TAG, "Preparing video with width=$width, height=$height, fps=$fps, bitrate=$bitrate, rotation=$rotation, dpi=$dpi")
                    if (rtmpDisplay.prepareVideo(width, height, fps, bitrate, rotation, dpi)) {
                        Log.d(TAG, "Video prepared successfully. Starting stream.")
                        rtmpDisplay.startStream(rtmpUrl)
                        Log.d(TAG, "Stream started to $rtmpUrl")

                        // تغییر ۲: ست کردن وضعیت سرویس در Companion object
                        isCapturing = true
                        currentRtmpUrl = rtmpUrl
                    } else {
                        Log.e(TAG, "prepareVideo failed.")
                        stopScreenCapture()
                    }
                } else {
                    Log.d(TAG, "Already streaming.")
                }
            } catch (e: Exception) {
                Log.e(TAG, "Error starting stream: ${e.message}")
                stopScreenCapture()
            }
        } else {
            Log.e(TAG, "Invalid intent data or RTMP URL.")
            stopScreenCapture()
        }

        return START_NOT_STICKY
    }

    private fun stopScreenCapture() {
        Log.d(TAG, "Stopping screen capture.")
        if (::rtmpDisplay.isInitialized && rtmpDisplay.isStreaming) {
            rtmpDisplay.stopStream()
            Log.d(TAG, "Stream stopped.")
        }
        // به فلاتر هم پیام ارسال می‌کنیم که استریم متوقف شده
        sendBroadcastMessage("stopTheStream")

        isCapturing = false
        currentRtmpUrl = null
        Log.d(TAG, "MediaProjection stopped.")

        stopForeground(true)
        stopSelf()
        Log.d(TAG, "Foreground service stopped.")
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d(TAG, "Service destroyed.")
        stopScreenCapture()
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val serviceChannel = NotificationChannel(
                CHANNEL_ID,
                "Screen Capture Service Channel",
                NotificationManager.IMPORTANCE_LOW
            )
            val manager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(serviceChannel)
            Log.d(TAG, "Notification channel created.")
        }
    }

    private fun createNotification(): Notification {
        val notificationIntent = Intent(this, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(
            this, 0, notificationIntent,
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
        )

        Log.d(TAG, "Creating notification.")
        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("Screen Capture Service")
            .setContentText("Recording screen...")
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentIntent(pendingIntent)
            .build()
    }

    // پیاده‌سازی متدهای ConnectCheckerRtmp

    override fun onConnectionSuccessRtmp() {
        Log.i(TAG, "Connection Success")
        runOnUiThread {
            Toast.makeText(this, "Connection Success", Toast.LENGTH_SHORT).show()
        }
    }

    override fun onConnectionFailedRtmp(reason: String) {
        Log.e(TAG, "Connection Failed: $reason")
        runOnUiThread {
            Toast.makeText(this, "Connection Failed: $reason", Toast.LENGTH_SHORT).show()
        }
        // اگر اتصال قطع شود، سرویس را متوقف کرده و به فلاتر پیام می‌دهیم
        stopScreenCapture()
    }

    override fun onConnectionStartedRtmp(rtmpUrl: String) {
        Log.i(TAG, "Connection Started: $rtmpUrl")
    }

    override fun onDisconnectRtmp() {
        Log.w(TAG, "Disconnected from RTMP")
        runOnUiThread {
            Toast.makeText(this, "Disconnected", Toast.LENGTH_SHORT).show()
        }
        // با قطع شدن اتصال، سرویس را متوقف کرده و پیام ارسال می‌کنیم
        stopScreenCapture()
    }

    override fun onAuthErrorRtmp() {
        Log.e(TAG, "Auth Error")
        runOnUiThread {
            Toast.makeText(this, "Auth Error", Toast.LENGTH_SHORT).show()
        }
        stopScreenCapture()
    }

    override fun onAuthSuccessRtmp() {
        Log.i(TAG, "Auth Success")
        runOnUiThread {
            Toast.makeText(this, "Auth Success", Toast.LENGTH_SHORT).show()
        }
    }

    override fun onNewBitrateRtmp(bitrate: Long) {
        Log.d(TAG, "New bitrate: $bitrate bps")
    }

    private fun runOnUiThread(action: Runnable) {
        Handler(Looper.getMainLooper()).post(action)
    }

    private fun sendBroadcastMessage(action: String) {
        val intent = Intent("com.app.gibical.SCREEN_CAPTURE_SERVICE")
        intent.putExtra("action", action)
        LocalBroadcastManager.getInstance(this).sendBroadcast(intent)
        Log.d(TAG, "Broadcast message sent: $action")
    }
}
