package com.example.knowledge_base.service;


import com.example.knowledge_base.model.Document;

import java.util.List;

public interface DocumentService {

    Document create(Document document);

    List<Document> getAllByUser(String email);

    Document getById(Long id);

    Document update(Long id, Document updatedDoc);

    void delete(Long id);


}
