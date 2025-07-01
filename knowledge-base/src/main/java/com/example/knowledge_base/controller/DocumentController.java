package com.example.knowledge_base.controller;

import com.example.knowledge_base.model.Document;
import com.example.knowledge_base.repositiory.DocumentRepository;
import com.example.knowledge_base.response.ApiResponse;
import com.example.knowledge_base.service.DocumentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/documents")
public class DocumentController {

    @Autowired
    private DocumentService documentService;

    @PostMapping
    public ResponseEntity<ApiResponse<Document>> create(@RequestBody Document document, Authentication authentication) {
        try {
            document.setAuthorEmail(authentication.getName());
            Document created = documentService.create(document);
            return ResponseEntity.ok(new ApiResponse<>("success", "Document created successfully", created));
        } catch (Exception e) {
            return new ResponseEntity<>(new ApiResponse<>("error", "Failed to create document", null), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping
    public ResponseEntity<ApiResponse<List<Document>>> getAll(Authentication authentication) {
        try {
            List<Document> documents = documentService.getAllByUser(authentication.getName());
            return ResponseEntity.ok(new ApiResponse<>("success", "Documents fetched successfully", documents));
        } catch (Exception e) {
            return new ResponseEntity<>(new ApiResponse<>("error", "Failed to fetch documents", null), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<Document>> getById(@PathVariable Long id) {
        Document doc = documentService.getById(id);
        if (doc != null) {
            return ResponseEntity.ok(new ApiResponse<>("success", "Document fetched successfully", doc));
        } else {
            return new ResponseEntity<>(new ApiResponse<>("fail", "Document not found", null), HttpStatus.NOT_FOUND);
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<Document>> update(@PathVariable Long id, @RequestBody Document updatedDoc) {
        Document doc = documentService.update(id, updatedDoc);
        if (doc != null) {
            return ResponseEntity.ok(new ApiResponse<>("success", "Document updated successfully", doc));
        } else {
            return new ResponseEntity<>(new ApiResponse<>("fail", "Document not found", null), HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<String>> delete(@PathVariable Long id) {
        try {
            documentService.delete(id);
            return ResponseEntity.ok(new ApiResponse<>("success", "Document deleted successfully", "Document ID: " + id));
        } catch (Exception e) {
            return new ResponseEntity<>(new ApiResponse<>("error", "Failed to delete document", null), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    @GetMapping("/search")
    public ResponseEntity<ApiResponse<List<Document>>> search(
            @RequestParam String keyword,
            Authentication authentication) {

        List<Document> results = documentService.searchDocuments(keyword, authentication.getName());
        return ResponseEntity.ok(new ApiResponse<>("success", "Search successful", results));
    }

    @GetMapping("/public")
    public ResponseEntity<ApiResponse<List<Document>>> getPublicDocuments(Authentication authentication) {
        List<Document> documents = documentService.getAllPublicDocumentsExceptMyOwn(authentication.getName());
        return ResponseEntity.ok(new ApiResponse<>("success", "Fetched public documents", documents));
    }

}
