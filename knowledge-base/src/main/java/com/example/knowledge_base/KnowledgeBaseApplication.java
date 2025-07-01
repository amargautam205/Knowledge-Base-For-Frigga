	package com.example.knowledge_base;

	import org.springframework.boot.SpringApplication;
	import org.springframework.boot.autoconfigure.SpringBootApplication;
	import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

	@SpringBootApplication
	@EnableJpaAuditing
	public class KnowledgeBaseApplication {

		public static void main(String[] args) {
			SpringApplication.run(KnowledgeBaseApplication.class, args);
		}

	}
