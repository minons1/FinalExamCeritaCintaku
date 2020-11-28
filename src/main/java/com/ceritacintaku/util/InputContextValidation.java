package com.ceritacintaku.util;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class InputContextValidation {
  public static String convertToMD5(String input) {
    try {
      MessageDigest md = MessageDigest.getInstance("MD5");
      byte[] messageDigest = md.digest(input.getBytes());
      BigInteger no = new BigInteger(1, messageDigest);
      String hashtext = no.toString(16);
      while (hashtext.length() < 32) {
        hashtext = "0" + hashtext;
      }
      return hashtext;
    } catch (NoSuchAlgorithmException e) {
      throw new RuntimeException(e);
    }
  }

  public static boolean checkEmailRegex(String email) {
    final String regex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
    // initialize the Pattern object
    Pattern pattern = Pattern.compile(regex);
    Matcher matcher = pattern.matcher(email);
    return matcher.matches();
  }

  public static boolean checkMaximumLength(String string, int length) {
    return string.length() <= length;
  }

  public static boolean checkMinimumLength(String string, int length) {
    return string.length() >= length;
  }

  public static boolean checkPasswordSame(String password, String confirmationPassword) {
    return password.equals(confirmationPassword);
  }
}
