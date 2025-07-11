package com.example.knowledge_base.service;

import com.example.knowledge_base.model.UserRegistration;

import java.util.List;

public interface UserRegistrationService {
    public UserRegistration createUserRegistration(UserRegistration user);

    public UserRegistration getUserRegistrationById(long user_id);

    public List<UserRegistration> getAllUserRegistration();

    public boolean findById(long user_id);

    void initiateForgotPassword(String email);
}
