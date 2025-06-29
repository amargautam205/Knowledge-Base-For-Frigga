package com.example.knowledge_base.util;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.HashMap;
import java.util.Map;
public class ResponseUtil {

    public static ResponseEntity<Object> createSuccessResponse(String message) {
        Map<String,Object> createSuccessResponse = new HashMap<>();
        createSuccessResponse.put("status", "success");
        createSuccessResponse.put("message", message);
        return new ResponseEntity<>(createSuccessResponse, HttpStatus.OK);
    }

    public static ResponseEntity<Object> createErrorResponse(String message, String errorDetails, HttpStatus httpStatus) {
        Map<String, Object> createErrorResponse = new HashMap<>();
        createErrorResponse.put("status", "error");
        createErrorResponse.put("message", message);
        createErrorResponse.put("errorDetails", errorDetails);
        return new ResponseEntity<>(createErrorResponse, httpStatus);
    }
    public static ResponseEntity<Object> getSuccessResponse(String message , Object data){
        Map<String,Object> getSuccessResponse = new HashMap<>();
        getSuccessResponse.put("status","Success");
        getSuccessResponse.put("message",message);
        getSuccessResponse.put("data",data);
        return new ResponseEntity<>(getSuccessResponse,HttpStatus.OK);
    }
    public static  ResponseEntity<Object> getErrorResponse(String message, String errorDetails , HttpStatus httpStatus){
        Map<String , Object> getErrorResponse = new HashMap<>();
        getErrorResponse.put("status","error");
        getErrorResponse.put("message",message);
        getErrorResponse.put("errorDetail",errorDetails);
        return  new ResponseEntity<>(getErrorResponse,httpStatus);
    }
    public static ResponseEntity<Object> deleteSuccessResponse(String message){
        Map<String,Object> deleteSuccessResponse = new HashMap<>();
        deleteSuccessResponse.put("status","Sucess");
        deleteSuccessResponse.put("message",message);
        return new ResponseEntity<>(deleteSuccessResponse,HttpStatus.OK);
    }

    public static ResponseEntity<Object> deleteErrorResponse(String message) {
        Map<String,Object> deleteErrorResponse = new HashMap<>();
        deleteErrorResponse.put("status","failed");
        deleteErrorResponse.put("message",message);
        return new ResponseEntity<>(deleteErrorResponse,HttpStatus.OK);
    }
    public static ResponseEntity<Object> updateSuccessResponse(String message){
        Map<String,Object> updateSuccessResponse = new HashMap<>();
        updateSuccessResponse.put("status","update.");
        updateSuccessResponse.put("message",message);
        return new ResponseEntity<>(updateSuccessResponse,HttpStatus.OK);
    }
    public static  ResponseEntity<Object> updateErrorResponse(String message,String errorDetails){
        Map<String,Object> updateErrorResponse = new HashMap<>();
        updateErrorResponse.put("status","failed");
        updateErrorResponse.put("message",message);
        return new ResponseEntity<>(updateErrorResponse,HttpStatus.OK);
    }
}

