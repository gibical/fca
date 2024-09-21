package com.app.gibical

import android.app.*
import android.content.Context
import android.content.Intent
import android.media.projection.MediaProjection
import android.media.projection.MediaProjectionManager
import android.os.Build
import android.os.IBinder
import android.util.Log
import android.widget.Toast
import androidx.core.app.NotificationCompat
import com.pedro.rtplibrary.rtmp.RtmpDisplay
import net.ossrs.rtmp.ConnectCheckerRtmp

class ScreenCaptureService : Service(), ConnectCheckerRtmp {

    private val CHANNEL_ID = "ScreenCaptureServiceChannel"
    private var mediaProjection: MediaProjection? = null
    private lateinit var mediaProjectionManager: MediaProjectionManager
    private lateinit var rtmpDisplay: RtmpDisplay
    private var rtmpUrl: String? = null

    override fun onCreate() {
        super.onCreate()
        createNotificationChannel()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val resultCode = intent?.getIntExtra("resultCode", Activity.RESULT_CANCELED) ?: Activity.RESULT_CANCELED
        val data = intent?.getParcelableExtra<Intent>("data")
        rtmpUrl = intent?.getStringExtra("rtmpUrl")

        if (resultCode == Activity.RESULT_OK && data != null && rtmpUrl != null) {
            val notification = createNotification()
            startForeground(1, notification)

            mediaProjectionManager = getSystemService(Context.MEDIA_PROJECTION_SERVICE) as MediaProjectionManager

            // ایجاد mediaProjection پس از شروع سرویس Foreground
            mediaProjection = mediaProjectionManager.getMediaProjection(resultCode, data)

            // ثبت MediaProjection.Callback
            mediaProjection?.registerCallback(object : MediaProjection.Callback() {
                override fun onStop() {
                    super.onStop()
                    Log.d("ScreenCaptureService", "MediaProjection stopped")
                    stopScreenCapture()
                }
            }, null)

            if (mediaProjection != null) {
                val width = 1280
                val height = 720
                val fps = 30
                val bitrate = 2500 * 1024
                val rotation = 0
                val dpi = resources.displayMetrics.densityDpi

                rtmpDisplay = RtmpDisplay(this, true, this)
                rtmpDisplay.setIntentResult(resultCode, data)

                try {
                    if (!rtmpDisplay.isStreaming) {
                        if (rtmpDisplay.prepareAudio() && rtmpDisplay.prepareVideo(
                                width,
                                height,
                                fps,
                                bitrate,
                                rotation,
                                dpi
                            )
                        ) {
                            rtmpDisplay.startStream(rtmpUrl)
                        } else {
                            stopScreenCapture()
                        }
                    }
                } catch (e: Exception) {
                    stopScreenCapture()
                }
            } else {
                stopScreenCapture()
            }
        } else {
            stopScreenCapture()
        }

        return START_STICKY
    }

    private fun stopScreenCapture() {
        if (::rtmpDisplay.isInitialized && rtmpDisplay.isStreaming) {
            rtmpDisplay.stopStream()
            // در صورت نیاز، پیام به MainActivity ارسال کنید
        }
        mediaProjection?.stop()
        mediaProjection = null
        stopForeground(true)
        stopSelf()
    }

    override fun onDestroy() {
        super.onDestroy()
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
                NotificationManager.IMPORTANCE_DEFAULT
            )
            val manager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(serviceChannel)
        }
    }

    private fun createNotification(): Notification {
        val notificationIntent = Intent(this, MainActivity::class.java)
        val pendingIntent = PendingIntent.getActivity(
            this, 0, notificationIntent,
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
        )

        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setContentTitle("Screen Capture Service")
            .setContentText("Recording screen...")
            .setSmallIcon(R.mipmap.launcher_icon)
            .setContentIntent(pendingIntent)
            .build()
    }

    // پیاده‌سازی متدهای ConnectCheckerRtmp

    override fun onConnectionSuccessRtmp() {
        runOnUiThread {
            Toast.makeText(this, "Connection Success", Toast.LENGTH_SHORT).show()
        }
    }

    override fun onConnectionFailedRtmp(reason: String) {
        runOnUiThread {
            Toast.makeText(this, "Connection Failed: $reason", Toast.LENGTH_SHORT).show()
            stopScreenCapture()
        }
    }

    override fun onDisconnectRtmp() {
        runOnUiThread {
            Toast.makeText(this, "Disconnected", Toast.LENGTH_SHORT).show()
            stopScreenCapture()
        }
    }

    override fun onAuthErrorRtmp() {
        runOnUiThread {
            Toast.makeText(this, "Auth Error", Toast.LENGTH_SHORT).show()
            stopScreenCapture()
        }
    }

    override fun onAuthSuccessRtmp() {
        runOnUiThread {
            Toast.makeText(this, "Auth Success", Toast.LENGTH_SHORT).show()
        }
    }

    override fun onNewBitrateRtmp(bitrate: Long) {
        runOnUiThread {
            Log.d("onNewBitrateRtmp:", " New bitrate: $bitrate bps")
        }
    }

    private fun runOnUiThread(action: Runnable) {
        val handler = android.os.Handler(mainLooper)
        handler.post(action)
    }
}
