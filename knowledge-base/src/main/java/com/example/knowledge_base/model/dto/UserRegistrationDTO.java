package com.example.knowledge_base.model.dto;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class UserRegistrationDTO {
    private Long userId;
    private String firstName;
    private String lastName;
    private String email;
    private String password;
}
