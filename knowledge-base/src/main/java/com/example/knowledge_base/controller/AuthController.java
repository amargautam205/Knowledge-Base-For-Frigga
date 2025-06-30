package com.example.knowledge_base.controller;

import com.example.knowledge_base.model.JwtRequest;
import com.example.knowledge_base.model.JwtResponse;
import com.example.knowledge_base.response.ApiResponse;
import com.example.knowledge_base.security.JwtHelper;
import com.example.knowledge_base.service.UserRegistrationService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    private AuthenticationManager manager;

    @Autowired
    private JwtHelper helper;

    @Autowired
    private UserRegistrationService userService;

    private final Logger logger = LoggerFactory.getLogger(AuthController.class);

    @PostMapping("/login")
    public ResponseEntity<ApiResponse<JwtResponse>> login(@RequestBody JwtRequest request) {
        try {
            // Load user
            UserDetails userDetails = userDetailsService.loadUserByUsername(request.getEmail());

            // Authenticate
            doAuthenticate(request.getEmail(), request.getPassword());

            // Generate JWT
            String token = helper.generateToken(userDetails);
            logger.info("Generated JWT Token: {}", token);

            JwtResponse response = JwtResponse.builder()
                    .jwtToken(token)
                    .username(userDetails.getUsername())
                    .build();

            ApiResponse<JwtResponse> apiResponse = new ApiResponse<>("success", "Login successful", response);
            return ResponseEntity.ok(apiResponse);

        } catch (BadCredentialsException e) {
            return new ResponseEntity<>(
                    new ApiResponse<>("fail", "Invalid credentials", null),
                    HttpStatus.UNAUTHORIZED
            );
        } catch (org.springframework.security.core.userdetails.UsernameNotFoundException e) {
            return new ResponseEntity<>(
                    new ApiResponse<>("fail", "User not found", null),
                    HttpStatus.NOT_FOUND
            );
        } catch (Exception e) {
            logger.error("Login error", e);
            return new ResponseEntity<>(
                    new ApiResponse<>("error", "Something went wrong", null),
                    HttpStatus.INTERNAL_SERVER_ERROR
            );
        }
    }

    private void doAuthenticate(String email, String password) {
        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(email, password);
        manager.authenticate(authentication);
    }
}
