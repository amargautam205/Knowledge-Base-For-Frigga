package com.example.knowledge_base.service.impl;


import com.example.knowledge_base.model.ForgotPassword;
import com.example.knowledge_base.model.UserRegistration;
import com.example.knowledge_base.repositiory.ForgotPasswordRepository;
import com.example.knowledge_base.repositiory.UserRegistrationRepositiory;
import com.example.knowledge_base.service.ForgotPasswordService;
import com.example.knowledge_base.service.UserRegistrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class UserRegistrationServiceImpl implements UserRegistrationService {
    @Autowired
    UserRegistrationRepositiory userRepository;
    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired
    private ForgotPasswordRepository forgotPasswordRepository;

    @Autowired
    private ForgotPasswordService forgotPasswordService;

    @Override
    public boolean findById(long user_id) {
        boolean result = userRepository.existsById(user_id);
        return result;
    }

    @Override
    public UserRegistration createUserRegistration(UserRegistration userRegistration) {
        userRegistration.setPassword(passwordEncoder.encode(userRegistration.getPassword()));
        return userRepository.save(userRegistration);
    }

    @Override
    public UserRegistration getUserRegistrationById(long user_id) {
        UserRegistration userRegistration = new UserRegistration();
        Optional<UserRegistration> userOptional = userRepository.findById(user_id);
        if (userOptional.isPresent()) {
            userRegistration = userOptional.get();
            return userRegistration;
        } else {
            return userRegistration;
        }
    }

    @Override
    public List<UserRegistration> getAllUserRegistration() {
        List<UserRegistration> userRegistrationList = userRepository.findAll();
        return userRegistrationList;
    }

//    @Override
//    public boolean deleteUserRegistrationById(long user_id) {
//        userRepositiory.deleteById(user_id);
//        return true;
//    }
//
//    @Override
//    public void updateUserRegistration(UserRegistration userRegistration) {
//        if (userRepositiory.existsById(userRegistration.getUserId())) {
//            userRepositiory.save(userRegistration);
//        }
//    }

    @Override
    public void initiateForgotPassword(String email) {
        UserRegistration user = userRepository.findByEmail(email);
        if (user == null) {
            throw new RuntimeException("Email not found");
        }

        // Generate token
        String token = UUID.randomUUID().toString();
        ForgotPassword resetToken = new ForgotPassword();
        resetToken.setToken(token);
        resetToken.setUser(user);
        resetToken.setExpiryDate(LocalDateTime.now().plusHours(1));
        forgotPasswordRepository.save(resetToken);

        String resetLink = "http://192.168.137.137:5000/reset-password?token=" + token;
        forgotPasswordService.send(user.getEmail(), "Reset your password", "Click here: " + resetLink);
    }
}
