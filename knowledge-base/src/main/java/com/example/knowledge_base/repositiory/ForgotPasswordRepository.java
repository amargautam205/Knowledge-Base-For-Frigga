package com.example.knowledge_base.repositiory;


import com.example.knowledge_base.model.ForgotPassword;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ForgotPasswordRepository extends JpaRepository<ForgotPassword, Long> {
    ForgotPassword findByToken(String token);
}
