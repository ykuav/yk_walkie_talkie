package cn.ykuav.walkietalkie.yk_walkie_talkie

import cn.ykuav.yikushoutapp.util.OpusUtils
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.nio.ByteBuffer
import java.nio.ByteOrder
import java.nio.charset.Charset
import java.nio.charset.StandardCharsets
import kotlin.reflect.typeOf

class MainActivity : FlutterActivity() {

    /* ======================================================= */
    /* Override/Implements Methods                             */
    /* ======================================================= */
    private final val TAG = "MainActivity"
    private val opus = OpusUtils()
    fun byteArrayToShortArray(byteArray: ByteArray): ShortArray {
        val shortArray = ShortArray(byteArray.size / 2)
        ByteBuffer.wrap(byteArray).order(ByteOrder.nativeOrder()).asShortBuffer().get(shortArray)
        return shortArray
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val messenger = flutterEngine.dartExecutor.binaryMessenger

        // 新建一个 Channel 对象
        val channel = MethodChannel(messenger, "abc")
        val rate = 8000
        val createEncoder = opus.createEncoder(rate, 1, 1)

        // 为 channel 设置回调
        channel.setMethodCallHandler { call, res ->
            // 根据方法名，分发不同的处理
            when (call.method) {
                "test" -> {
                    // 获取传入的参数
//                    val msg = call.argument<String>("msg")
//                    Log.i(TAG, "正在执行原生方法，传入的参数是：「$msg」")
                    // 通知执行成功
                    res.success("这是执行的结果")
                }
                "opusEncode" -> {
                    Log.i(
                        TAG,
                        "call.arguments:${call.arguments}"
                    )

                    val data = call.argument<ByteArray>("data")
//                    Log.i(TAG, "data:${data}")
                    if (data != null) {
                        val ret = ByteArray(data.size / 8)
                        opus.encode(
                            createEncoder,
                            byteArrayToShortArray(data),
                            0,
                            ret
                        )
                        res.success(ret)
                    }

                }

                else -> {
                    // 如果有未识别的方法名，通知执行失败
                    res.error("error_code", "error_message", null)
                }
            }
        }
    }
}
