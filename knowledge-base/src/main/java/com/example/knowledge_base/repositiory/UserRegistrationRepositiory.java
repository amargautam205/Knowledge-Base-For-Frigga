package com.example.knowledge_base.repositiory;
import com.example.knowledge_base.model.UserRegistration;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRegistrationRepositiory extends JpaRepository<UserRegistration,Long> {
    UserRegistration findByEmail(String email);
}
