package com.example.knowledge_base.controller;

import com.example.knowledge_base.model.UserRegistration;
import com.example.knowledge_base.model.dto.UserRegistrationDTO;
import com.example.knowledge_base.response.ApiResponse;
import com.example.knowledge_base.service.ForgotPasswordService;
import com.example.knowledge_base.service.UserRegistrationService;
import com.example.knowledge_base.util.ResponseUtil;
import com.example.knowledge_base.util.UserRegistrationConverter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("userRegistration")
public class UserRegistrationController {
    @Autowired
    private UserRegistrationService userService;


    @Autowired
    private ForgotPasswordService forgotPasswordService;
    private Logger logger = LoggerFactory.getLogger(UserRegistrationController.class);

    @PostMapping("/createUserRegistration")
    public ResponseEntity<Object> createUserRegistration(@RequestBody UserRegistrationDTO userRegistrationDTO) {
        try {
            UserRegistration userRegistration = UserRegistrationConverter.convertToEntity(userRegistrationDTO);
            userService.createUserRegistration(userRegistration);
            logger.info("Create New UserRegistration with ID: {}", userRegistration.getUserId());
            return ResponseUtil.createSuccessResponse("User created Successfully.");
        } catch (Exception ex) {
            logger.error("failed to create UserRegistration: {}", ex.getMessage());
            return ResponseUtil.createErrorResponse("Failed to create UserRegistration", ex.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }


    @PostMapping("/forgot-password")
    public ResponseEntity<ApiResponse<String>> forgotPassword(@RequestBody Map<String, String> body) {
        try {
            String email = body.get("email");
            userService.initiateForgotPassword(email);
            return ResponseEntity.ok(new ApiResponse<>("success", "Reset link sent", null));
        } catch (RuntimeException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ApiResponse<>("fail", e.getMessage(), null));
        }
    }

}
