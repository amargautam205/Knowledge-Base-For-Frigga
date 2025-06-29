package com.example.knowledge_base.service;
import com.example.knowledge_base.model.UserRegistration;
import com.example.knowledge_base.repositiory.UserRegistrationRepositiory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailService implements UserDetailsService {
    @Autowired
    private UserRegistrationRepositiory userRepositiory;
    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException{
        UserRegistration userRegistration = this.userRepositiory.findByEmail(email);
        return userRegistration;
    }
}
