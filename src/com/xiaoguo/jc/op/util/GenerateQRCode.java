package com.xiaoguo.jc.op.util;

import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.Map;


import com.google.zxing.EncodeHintType;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import org.apache.log4j.Logger;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;

/**
 * @ClassName: GenerateQRCode
 * @Description: 生成二维码
 * @version V1.0
 */
public final class GenerateQRCode {

    private static final Logger log = Logger.getLogger(GenerateQRCode.class);

    private static final GenerateQRCode instance = new GenerateQRCode();

    private GenerateQRCode() {
    }

    public static GenerateQRCode getInstance() {
        return instance;
    }

    private static final int BLACK = 0xff000000;
    private static final int WHITE = 0xFFFFFFFF;

    /**
     * @Title: generate
     * @Description: 生成二维码
     * @param params
     *            二维码信息
     * @param width
     *            生成的图片的宽
     * @param height
     *            生成的图片的高
     * @throws Exception
     * @return String 二维码图片名称
     * @author
     * @date 2012-11-9
     */
    public File generate(String params, int width, int height) throws Exception {

        log.info("GenerateQRCode-->start to generate qrcode.");

        File tempFile = File.createTempFile("yo_qrcode_" + System.currentTimeMillis(), ".jpg");

        Map<EncodeHintType, Object> hints = new HashMap<EncodeHintType, Object>();
        hints.put(EncodeHintType.MARGIN, 0);

        BitMatrix bitMatrix = new MultiFormatWriter().encode(params,
                BarcodeFormat.QR_CODE, width, height, hints);

        MatrixToImageWriter.writeToStream(bitMatrix, "jpeg", new FileOutputStream(tempFile));

        log.info("GenerateQRCode-->end to generate qrcode.");
        log.info(tempFile.getAbsolutePath());
        System.out.println(tempFile.getAbsolutePath());

        return tempFile;
    }

    public static void main(String[] args) throws Exception {
        GenerateQRCode.getInstance().generate("1", 350, 350);
    }
}
