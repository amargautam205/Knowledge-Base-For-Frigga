package com.example.knowledge_base.service.impl;

import com.example.knowledge_base.model.Document;
import com.example.knowledge_base.repositiory.DocumentRepository;
import com.example.knowledge_base.service.DocumentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DocumentServiceImpl implements DocumentService {

    @Autowired
    private DocumentRepository documentRepository;

    @Override
    public Document create(Document document) {
        return documentRepository.save(document);
    }

    @Override
    public List<Document> getAllByUser(String email) {
        return documentRepository.findByAuthorEmail(email);
    }

    @Override
    public Document getById(Long id) {
        return documentRepository.findById(id).orElse(null);
    }

    @Override
    public Document update(Long id, Document updatedDoc) {
        Document doc = documentRepository.findById(id).orElse(null);
        if (doc != null) {
            doc.setTitle(updatedDoc.getTitle());
            doc.setContent(updatedDoc.getContent());
            doc.setPublic(updatedDoc.isPublic());
            return documentRepository.save(doc);
        }
        return null;
    }

    @Override
    public void delete(Long id) {
        documentRepository.deleteById(id);
    }

    @Override
    public List<Document> searchDocuments(String keyword, String email) {
        return documentRepository.searchDocumentsByKeywordAndEmail(keyword, email);
    }
    @Override
    public List<Document> getAllPublicDocumentsExceptMyOwn(String email) {
        return documentRepository.findAllPublicDocumentsExcludingUser(email);
    }

}
