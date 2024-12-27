package com.example.universal_printer_flutter.provide

import android.graphics.BitmapFactory
import android.graphics.Typeface
import com.eiviayw.library.Constant
import com.eiviayw.library.bean.param.BaseParam
import com.eiviayw.library.bean.param.GraphicsParam
import com.eiviayw.library.bean.param.LineDashedParam
import com.eiviayw.library.bean.param.MultiElementParam
import com.eiviayw.library.bean.param.TextParam
import com.eiviayw.library.draw.BitmapOption
import com.eiviayw.library.provide.BaseProvide
import com.eiviayw.library.util.BitmapUtils
import com.example.universal_printer_flutter.R
import com.example.universal_printer_flutter.BaseApplication

/**
 * 指路：https://github.com/Yiwei099
 *
 * Created with Android Studio.
 * @Author: YYW
 * @Date: 2023-11-26 20:39
 * @Version Copyright (c) 2023, Android Engineer YYW All Rights Reserved.
 *
 * 收据数据提供者
 */
class ReceiptProvide : BaseProvide(BitmapOption()) {

    fun startBuild(): ByteArray {
        return startDraw(generateDrawParam())
    }

    private fun generateDrawParam() = mutableListOf<BaseParam>().apply {
        add(
            TextParam(
                text = "动漫新城",
                align = Constant.Companion.Align.ALIGN_CENTER
            ).apply {
                size = 30f
            }
        )

        add(
            MultiElementParam(
                param1 = TextParam(
                    text = "单据号：XS08897381",
                    weight = 0.5
                ),
                param2 = TextParam(
                    text = "结账单",
                    weight = 0.5,
                    align = Constant.Companion.Align.ALIGN_END
                )
            )
        )

        add(
            TextParam(
                text = "日期：2024-04-09"
            )
        )

        add(
            TextParam(
                text = "会员：散客"
            )
        )
        add(LineDashedParam())
        add(MultiElementParam(
            param1 = TextParam(
                text = "商品",
                weight = 0.2
            ),
            param2 = TextParam(
                text = "数量",
                weight = 0.2
            ),
            param3 = TextParam(
                text = "单价",
                weight = 0.2
            ),
            param4 = TextParam(
                text = "折扣",
                weight = 0.2
            ),
            param5 = TextParam(
                text = "金额",
                weight = 0.2,
                align = Constant.Companion.Align.ALIGN_END
            )
        ))
        add(LineDashedParam())

        for (index in 0..2){
            add(TextParam(text = "超人迪加奥特曼喜羊羊与灰太狼熊出没哆啦A梦梦梦梦"))
            add(MultiElementParam(
                param1 = TextParam(
                    text = "黑色/XL码",
                    weight = 0.2,
                    autoWrap = false
                ),
                param2 = TextParam(
                    text = "1",
                    weight = 0.2,
                ).apply {
                    gravity = Constant.Companion.Gravity.BOTTOM
                },
                param3 = TextParam(
                    text = "$123.50",
                    weight = 0.2
                ).apply {
                    gravity = Constant.Companion.Gravity.BOTTOM
                },
                param4 = TextParam(
                    text = "88.0%",
                    weight = 0.2
                ).apply {
                    gravity = Constant.Companion.Gravity.BOTTOM
                },
                param5 = TextParam(
                    text = "88.00",
                    weight = 0.2,
                    align = Constant.Companion.Align.ALIGN_END
                ).apply {
                    gravity = Constant.Companion.Gravity.BOTTOM
                }
            ))

        }

        add(LineDashedParam())
        add(TextParam(
            text = "销售：1款，2件，88元"
        ))
        add(TextParam(
            text = "整单折扣：88.0%"
        ))
        add(MultiElementParam(
            param1 = TextParam(
                text = "应收：",
                weight = -1.0
            ).apply {
                gravity = Constant.Companion.Gravity.BOTTOM
            },
            param2 = TextParam(
                text = "$88.0",
                weight = -1.0,
            ).apply {
                size = 60f
                typeface = Typeface.DEFAULT_BOLD
            }
        ))
        add(MultiElementParam(
            param1 = TextParam(
                text = "实收：",
                weight = -1.0,
            ).apply {
                gravity = Constant.Companion.Gravity.BOTTOM
            },
            param2 = TextParam(
                text = "$88.0",
                weight = -1.0,
            ).apply {
                size = 60f
                typeface = Typeface.DEFAULT_BOLD
            }
        ))
        add(TextParam(
            text = "(现：50元，支50元)"
        ))
        add(LineDashedParam())
        add(TextParam(
            text = "操作人：周杰伦"
        ))
        add(TextParam(
            text = "操作时间：2024-04-09 10:09:29"
        ))
        add(TextParam(
            text = "联系电话：13800138000"
        ))
        add(TextParam(
            text = "联系地址：香港深水埗长沙湾道989-139号101铺"
        ))
        add(TextParam(
            text = "温馨提示：7天无理由退换"
        ))
        val bitmap = BitmapFactory.decodeResource(
            BaseApplication.getInstance().resources,
            R.drawable.we_chat
        )
        BitmapUtils.getInstance().zoomBitmap(bitmap,bitmap.width.div(2).toDouble(),bitmap.height.div(2).toDouble())?.let {
            val byteArray = BitmapUtils.getInstance().compressBitmapToByteArray(it)
            add(GraphicsParam(byteArray,it.width,it.height))

            bitmap.recycle()
            it.recycle()
        }
        add(TextParam(
            text = "微信扫一扫成为好友",
            align = Constant.Companion.Align.ALIGN_CENTER
        ))
        add(TextParam(
            text = "An Android library that makes developers get pos receipts extremely easy.",
            align = Constant.Companion.Align.ALIGN_CENTER,
            autoWrap = true
        ))
        add(TextParam(
            text = "一个Android库，让开发者非常容易地获得pos收据。",
            align = Constant.Companion.Align.ALIGN_CENTER
        ))
    }

    companion object {
        const val KEY = "ReceiptProvide"
    }
}