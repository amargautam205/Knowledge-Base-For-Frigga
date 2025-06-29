package com.example.knowledge_base.service.impl;


import com.example.knowledge_base.model.UserRegistration;
import com.example.knowledge_base.repositiory.UserRegistrationRepositiory;
import com.example.knowledge_base.service.UserRegistrationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserRegistrationServiceImpl implements UserRegistrationService {
    @Autowired
    UserRegistrationRepositiory userRepositiory;
    @Autowired
    PasswordEncoder passwordEncoder;

    @Override
    public boolean findById(long user_id) {
        boolean result = userRepositiory.existsById(user_id);
        return result;
    }

    @Override
    public UserRegistration createUserRegistration(UserRegistration userRegistration) {
        userRegistration.setPassword(passwordEncoder.encode(userRegistration.getPassword()));
        return userRepositiory.save(userRegistration);
    }

    @Override
    public UserRegistration getUserRegistrationById(long user_id) {
        UserRegistration userRegistration = new UserRegistration();
        Optional<UserRegistration> userOptional = userRepositiory.findById(user_id);
        if (userOptional.isPresent()) {
            userRegistration = userOptional.get();
            return userRegistration;
        } else {
            return userRegistration;
        }
    }

    @Override
    public List<UserRegistration> getAllUserRegistration() {
        List<UserRegistration> userRegistrationList = userRepositiory.findAll();
        return userRegistrationList;
    }

    @Override
    public boolean deleteUserRegistrationById(long user_id) {
        userRepositiory.deleteById(user_id);
        return true;
    }

    @Override
    public void updateUserRegistration(UserRegistration userRegistration) {
        if (userRepositiory.existsById(userRegistration.getUserId())) {
            userRepositiory.save(userRegistration);
        }
    }
}
