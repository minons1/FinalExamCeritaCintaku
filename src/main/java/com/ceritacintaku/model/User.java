package com.ceritacintaku.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@NoArgsConstructor
@Data
@AllArgsConstructor
public class User {

  @NonNull
  private Long id;

  @NonNull
  private String name;

  @NonNull
  private String email;

  private String password;
}
