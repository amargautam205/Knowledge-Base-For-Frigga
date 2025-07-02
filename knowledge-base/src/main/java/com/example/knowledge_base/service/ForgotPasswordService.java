package com.example.knowledge_base.service;


public interface ForgotPasswordService {
    void send(String to, String subject, String body);


}
