package com.ceritacintaku.payload;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserLoginRequest {
  @NonNull
  private String email;
  @NonNull
  private String password;
}