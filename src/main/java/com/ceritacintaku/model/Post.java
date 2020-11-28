package com.ceritacintaku.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class Post {
  @NonNull
  private Long id;

  private User user;

  @NonNull
  private String title;

  @NonNull
  private String description;
}
