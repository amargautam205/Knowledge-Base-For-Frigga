package com.example.knowledge_base.util;

import com.example.knowledge_base.model.UserRegistration;
import com.example.knowledge_base.model.dto.UserRegistrationDTO;

public class UserRegistrationConverter {
    public static UserRegistrationDTO convertToDTO(UserRegistration userRegistration){
        UserRegistrationDTO userRegistrationDTO = new UserRegistrationDTO();
        userRegistrationDTO.setUserId(userRegistration.getUserId());
        userRegistrationDTO.setFirstName(userRegistration.getFirstName());
        userRegistrationDTO.setLastName(userRegistration.getLastName());
        userRegistrationDTO.setEmail(userRegistration.getEmail());
        userRegistrationDTO.setPassword(userRegistration.getPassword());
        return userRegistrationDTO;
    }
    public static  UserRegistration convertToEntity(UserRegistrationDTO userRegistrationDTO){
        UserRegistration userRegistration = new UserRegistration();
        userRegistration.setUserId(userRegistrationDTO.getUserId());
        userRegistration.setFirstName(userRegistrationDTO.getFirstName());
        userRegistration.setLastName(userRegistrationDTO.getLastName());
        userRegistration.setEmail(userRegistrationDTO.getEmail());
        userRegistration.setPassword(userRegistrationDTO.getPassword());
        return userRegistration;
    }
}
