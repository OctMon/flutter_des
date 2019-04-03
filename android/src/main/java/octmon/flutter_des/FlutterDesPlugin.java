package octmon.flutter_des;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import java.security.Key;
import java.security.spec.AlgorithmParameterSpec;
import java.util.ArrayList;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;

/** FlutterDesPlugin */
public class FlutterDesPlugin implements MethodCallHandler {
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_des");
    channel.setMethodCallHandler(new FlutterDesPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    ArrayList arguments = (ArrayList) call.arguments;
    String string = (String) arguments.get(0);
    String key = (String) arguments.get(1);
    String iv = (String) arguments.get(2);
    switch (call.method) {
      case "encrypt":
        result.success(encrypt(string, key, iv));
        break;
      case "decrypt":
        result.success(decrypt(string, key, iv));
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  private static final String ALGORITHM_DES = "DES/CBC/PKCS5Padding";

  /**
   * 加密
   */
  private static String encrypt(String originStr, String secretKey, String iv) {
    return encode(secretKey, iv, originStr);
  }

  /**
   * 解密
   */
  private static String decrypt(String encryptStr, String secretKey, String iv) {
    return decode(secretKey, iv, encryptStr);
  }

  /**
   * DES算法，加密
   *
   * @param data 待加密字符串
   * @param key  加密私钥，长度不能够小于8位
   * @param iv  偏移量
   * @return 加密后的字节数组，一般结合Base64编码使用
   */
  private static String encode(String key, String iv, String data) {
    if(data == null || iv ==null)
      return null;
    try{
      DESKeySpec dks = new DESKeySpec(key.getBytes());
      SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
      //key的长度不能够小于8位字节
      Key secretKey = keyFactory.generateSecret(dks);
      Cipher cipher = Cipher.getInstance(ALGORITHM_DES);
      AlgorithmParameterSpec paramSpec = new IvParameterSpec(iv.getBytes());
      cipher.init(Cipher.ENCRYPT_MODE, secretKey,paramSpec);
      byte[] bytes = cipher.doFinal(data.getBytes());
      return byte2hex(bytes);
    }catch(Exception e){
      e.printStackTrace();
      return data;
    }
  }

  /**
   * DES算法，解密
   *
   * @param data 待解密字符串
   * @param key  解密私钥，长度不能够小于8位
   * @param iv  偏移量
   * @return 解密后的字节数组
   */
  private static String decode(String key, String iv, String data) {
    if(data == null || iv == null)
      return null;
    try {
      DESKeySpec dks = new DESKeySpec(key.getBytes());
      SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
      //key的长度不能够小于8位字节
      Key secretKey = keyFactory.generateSecret(dks);
      Cipher cipher = Cipher.getInstance(ALGORITHM_DES);
      AlgorithmParameterSpec paramSpec = new IvParameterSpec(iv.getBytes());
      cipher.init(Cipher.DECRYPT_MODE, secretKey, paramSpec);
      return new String(cipher.doFinal(hex2byte(data.getBytes())));
    } catch (Exception e){
      e.printStackTrace();
      return "";
    }
  }

  /**
   * 二行制转字符串
   */
  private static String byte2hex(byte[] b) {
    StringBuilder hs = new StringBuilder();
    String stmp;
    for (int n = 0; b!=null && n < b.length; n++) {
      stmp = Integer.toHexString(b[n] & 0XFF);
      if (stmp.length() == 1)
        hs.append('0');
      hs.append(stmp);
    }
    return hs.toString().toUpperCase();
  }

  private static byte[] hex2byte(byte[] b) {
    if((b.length%2)!=0)
      throw new IllegalArgumentException();
    byte[] b2 = new byte[b.length/2];
    for (int n = 0; n < b.length; n+=2) {
      String item = new String(b,n,2);
      b2[n/2] = (byte)Integer.parseInt(item,16);
    }
    return b2;
  }
}
