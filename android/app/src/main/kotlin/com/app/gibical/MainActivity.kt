package com.app.gibical

import android.content.Intent
import android.media.projection.MediaProjection
import android.media.projection.MediaProjectionManager
import android.os.Bundle
import android.util.DisplayMetrics
import android.widget.Toast
import com.pedro.rtplibrary.rtmp.RtmpCamera1
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import net.ossrs.rtmp.ConnectCheckerRtmp

class MainActivity : FlutterActivity(), ConnectCheckerRtmp {

    private lateinit var mediaProjectionManager: MediaProjectionManager
    private var mediaProjection: MediaProjection? = null
    private val REQUEST_CODE_SCREEN_CAPTURE = 1000
    private var rtmpUrl: String? = null
    private lateinit var rtmpCamera1: RtmpCamera1
    private val CHANNEL = "com.app.gibical/rtmp"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Initialize MethodChannel
        flutterEngine?.dartExecutor?.binaryMessenger?.let {
            MethodChannel(it, CHANNEL).setMethodCallHandler { call, result ->
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

        // Setup RTMP using RtmpCamera1
        rtmpCamera1 = RtmpCamera1(activity,this);

        val captureIntent = mediaProjectionManager.createScreenCaptureIntent()
        startActivityForResult(captureIntent, REQUEST_CODE_SCREEN_CAPTURE)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == REQUEST_CODE_SCREEN_CAPTURE && resultCode == RESULT_OK && data != null) {
            mediaProjection = mediaProjectionManager.getMediaProjection(resultCode, data)
            mediaProjection?.let {
                val metrics = DisplayMetrics()
                windowManager.defaultDisplay.getMetrics(metrics)
                if (!rtmpCamera1.isStreaming) {
                    if (rtmpCamera1.prepareAudio() && rtmpCamera1.prepareVideo()) {
                        rtmpCamera1.startStream(rtmpUrl)
                        Toast.makeText(this, "Streaming started to $rtmpUrl", Toast.LENGTH_SHORT).show()
                    } else {
                        Toast.makeText(this, "Error preparing stream", Toast.LENGTH_SHORT).show()
                    }
                }
            }
        } else {
            Toast.makeText(this, "Screen Cast Permission Denied", Toast.LENGTH_SHORT).show()
        }
    }

    private fun stopScreenCapture() {
        if (rtmpCamera1.isStreaming) {
            rtmpCamera1.stopStream()
            Toast.makeText(this, "Stream stopped", Toast.LENGTH_SHORT).show()
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
        }
    }

     fun onConnectionStartedRtmp(rtmpUrl: String) {
        TODO("Not yet implemented")
        Toast.makeText(this, "onConnectionStartedRtmp", Toast.LENGTH_SHORT).show()

    }

    override fun onDisconnectRtmp() {
        runOnUiThread {
            Toast.makeText(this, "Disconnected", Toast.LENGTH_SHORT).show()
        }
    }

    override fun onNewBitrateRtmp(bitrate: Long) {
        TODO("Not yet implemented")
        Toast.makeText(this, "onNewBitrateRtmp", Toast.LENGTH_SHORT).show()

    }

    override fun onAuthErrorRtmp() {
        runOnUiThread {
            Toast.makeText(this, "Auth Error", Toast.LENGTH_SHORT).show()
        }
    }

    override fun onAuthSuccessRtmp() {
        runOnUiThread {
            Toast.makeText(this, "Auth Success", Toast.LENGTH_SHORT).show()
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        stopScreenCapture()
    }
}
