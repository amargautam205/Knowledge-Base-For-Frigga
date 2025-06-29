package com.example.knowledge_base.controller;
import com.example.knowledge_base.model.UserRegistration;
import com.example.knowledge_base.model.dto.UserRegistrationDTO;
import com.example.knowledge_base.service.UserRegistrationService;
import com.example.knowledge_base.util.ResponseUtil;
import com.example.knowledge_base.util.UserRegistrationConverter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("userRegistration")
public class UserRegistrationController {
    @Autowired
    private UserRegistrationService userService;
    private Logger logger = LoggerFactory.getLogger(UserRegistrationController.class);
        @PostMapping("/createUserRegistration")
    public ResponseEntity<Object> createUserRegistration(@RequestBody UserRegistrationDTO userRegistrationDTO){
        try {
            UserRegistration userRegistration = UserRegistrationConverter.convertToEntity(userRegistrationDTO);
            userService.createUserRegistration(userRegistration);
            logger.info("Create New UserRegistration with ID: {}" , userRegistration.getUserId());
            return ResponseUtil.createSuccessResponse("Object created Successfully.");
        }catch (Exception ex){
            logger.error("failed to create UserRegistration: {}", ex.getMessage());
            return ResponseUtil.createErrorResponse("Failed to create UserRegistration", ex.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }
    @GetMapping("getUserRegistrationById/{user_id}")
    public ResponseEntity<Object> getUserRegistrationById(@PathVariable Long user_id){
        try {
            UserRegistration userRegistration = new UserRegistration();
            userRegistration = userService.getUserRegistrationById(user_id);
            logger.info("UserRegistration data Fetched with id : {}",userRegistration.getUserId());
            UserRegistrationDTO userRegistrationDTO = UserRegistrationConverter.convertToDTO(userRegistration);
            return ResponseUtil.getSuccessResponse("UserRegistration data found.",userRegistrationDTO);
        }catch (Exception ex ){
            logger.error("failed to get UserRegistration: {}",ex.getMessage());
            return  ResponseUtil.getErrorResponse("Failed to get UserRegistration.",ex.getMessage(),HttpStatus.BAD_REQUEST);
        }
    }

   @DeleteMapping("/deleteUserRegistrationById/{user_id}")
    public ResponseEntity<Object> deleteUserRegistrationById(@PathVariable Long user_id) {
    try {
        logger.info("Deleting UserRegistration with userId={}", user_id);
        userService.deleteUserRegistrationById(user_id);
        logger.info("UserRegistration with userId={} deleted successfully",user_id);
        return ResponseUtil.deleteSuccessResponse("UserRegistration Deleted Successfull.");
    } catch (Exception ex) {
        logger.error("Failed to delete UserRegistration: userId={}", user_id);
        return ResponseUtil.deleteErrorResponse("Failed to delete UserRegistration.");
    }
  }
    @PutMapping("/updateUserRegistrationById/{user_id}")
    public ResponseEntity<Object> updateUserRegistrationById(@PathVariable long user_id , @RequestBody UserRegistrationDTO userRegistrationDTO) {
        try {
            UserRegistration userRegistration = UserRegistrationConverter.convertToEntity(userRegistrationDTO);
            userRegistration.setUserId(user_id);
            userService.updateUserRegistration(userRegistration);
            logger.info("UserRegistration Updated Successfully: userId={}", user_id);
            return ResponseUtil.updateSuccessResponse("UserRegistration Updated Successfully.");
        } catch (Exception ex) {
            logger.error("Failed to update User: userId={}", user_id);
            return ResponseUtil.updateErrorResponse("UserRegistration not updated", ex.getMessage());
        }
    }
}
