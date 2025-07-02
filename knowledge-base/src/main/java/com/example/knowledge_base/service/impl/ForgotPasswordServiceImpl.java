package com.example.knowledge_base.service.impl;


import com.example.knowledge_base.service.ForgotPasswordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class ForgotPasswordServiceImpl implements ForgotPasswordService {

    @Autowired
    private JavaMailSender mailSender;

    @Override
    public void send(String to, String subject, String body) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(to);
        message.setSubject(subject);
        message.setText(body);
        message.setFrom("mail2softdev@gmail.com"); // same as configured username
        mailSender.send(message);
    }
}
