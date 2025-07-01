package com.example.knowledge_base.repositiory;


import com.example.knowledge_base.model.Document;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


import java.util.List;

public interface DocumentRepository extends JpaRepository<Document, Long> {
    List<Document> findByAuthorEmail(String authorEmail);


    @Query(value = "SELECT * FROM document " + "WHERE (title LIKE %:keyword% OR content LIKE %:keyword%) " + "AND author_email = :email", nativeQuery = true)
    List<Document> searchDocumentsByKeywordAndEmail(@Param("keyword") String keyword, @Param("email") String email);


    @Query(value = "SELECT * FROM document d WHERE d.is_public = true AND d.author_email <> :email", nativeQuery = true)
    List<Document> findAllPublicDocumentsExcludingUser(@Param("email") String currentUserEmail);

}
