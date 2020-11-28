package com.ceritacintaku.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Comment {
  private Long id;

  private Post post;

  private User user;

  public String description;
}
