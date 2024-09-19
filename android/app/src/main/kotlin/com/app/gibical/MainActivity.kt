package com.app.gibical

import android.content.Intent
import android.media.projection.MediaProjection
import android.media.projection.MediaProjectionManager
import android.os.Bundle
import android.util.DisplayMetrics
import android.util.Log
import android.widget.Toast
import com.pedro.rtplibrary.rtmp.RtmpDisplay
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import net.ossrs.rtmp.ConnectCheckerRtmp

class MainActivity : FlutterActivity(), ConnectCheckerRtmp {

    private lateinit var mediaProjectionManager: MediaProjectionManager
    private var mediaProjection: MediaProjection? = null
    private val REQUEST_CODE_SCREEN_CAPTURE = 1000
    private var rtmpUrl: String? = null
    private lateinit var rtmpDisplay: RtmpDisplay
    private val CHANNEL = "com.app.gibical/rtmp"

    private lateinit var methodChannel: MethodChannel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        flutterEngine?.dartExecutor?.binaryMessenger?.let {
            methodChannel = MethodChannel(it, CHANNEL)
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
                    else -> {
                        result.notImplemented()
                    }
                }
            }
        }
    }

    private fun startScreenCapture() {
        mediaProjectionManager = getSystemService(MEDIA_PROJECTION_SERVICE) as MediaProjectionManager
        val serviceIntent = Intent(this, ScreenCaptureService::class.java)
        startService(serviceIntent)

        rtmpDisplay = RtmpDisplay(this, true, this)

        val captureIntent = mediaProjectionManager.createScreenCaptureIntent()
        captureIntent.flags = Intent.FLAG_ACTIVITY_SINGLE_TOP

        startActivityForResult(captureIntent, REQUEST_CODE_SCREEN_CAPTURE)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUEST_CODE_SCREEN_CAPTURE && resultCode == RESULT_OK && data != null) {
            mediaProjection = mediaProjectionManager.getMediaProjection(resultCode, data)

            if (mediaProjection != null) {
                val metrics = DisplayMetrics()
                windowManager.defaultDisplay.getMetrics(metrics)

                rtmpDisplay.setIntentResult(resultCode, data)

                if (!rtmpDisplay.isStreaming) {
                    if (rtmpDisplay.prepareAudio() && rtmpDisplay.prepareVideo(
                            metrics.widthPixels,
                            metrics.heightPixels,
                            30,
                            3000 * 1024,
                            0,
                            320
                        )
                    ) {
                        rtmpDisplay.startStream(rtmpUrl)
                        Toast.makeText(this, "Screen sharing started to $rtmpUrl", Toast.LENGTH_SHORT)
                            .show()
                    } else {
                        Toast.makeText(this, "Error preparing stream", Toast.LENGTH_SHORT).show()
                    }
                }
            } else {
                Toast.makeText(this, "Error: MediaProjection is null", Toast.LENGTH_SHORT).show()
            }
        } else {
            Toast.makeText(this, "Screen Cast Permission Denied", Toast.LENGTH_SHORT).show()
        }
    }

    private fun stopScreenCapture() {
        if (::rtmpDisplay.isInitialized && rtmpDisplay.isStreaming) {
            rtmpDisplay.stopStream()
            Toast.makeText(this, "Stream stopped", Toast.LENGTH_SHORT).show()
            methodChannel.invokeMethod("stopTheStream", null)
        }
        mediaProjection?.stop()
        mediaProjection = null
    }

    override fun onConnectionSuccessRtmp() {
        runOnUiThread {
            Toast.makeText(this, "Connection Success", Toast.LENGTH_SHORT).show()
        }
    }

    override fun onConnectionFailedRtmp(reason: String) {
        runOnUiThread {
            Toast.makeText(this, "Connection Failed: $reason", Toast.LENGTH_SHORT).show()
            stopScreenCapture()
            methodChannel.invokeMethod("stopTheStream", null)
        }
    }

    override fun onDisconnectRtmp() {
        runOnUiThread {
            Toast.makeText(this, "Disconnected", Toast.LENGTH_SHORT).show()
            stopScreenCapture()
            methodChannel.invokeMethod("stopTheStream", null)
        }
    }

    override fun onAuthErrorRtmp() {
        runOnUiThread {
            Toast.makeText(this, "Auth Error", Toast.LENGTH_SHORT).show()
            stopScreenCapture()
            methodChannel.invokeMethod("stopTheStream", null)
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

    override fun onDestroy() {
        super.onDestroy()
        stopScreenCapture()
    }
}
