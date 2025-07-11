package com.example.knowledge_base.model;
import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString

public class JwtResponse {
    private  String jwtToken;
    private String username;
}
