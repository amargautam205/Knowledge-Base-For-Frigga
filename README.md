# Knowledge-Base-For-Frigga

#TechStack
| Layer    | Technology                       |
| -------- | -------------------------------- |
| Backend  | Java 17.0.9, Spring Boot 3.x     |
| Frontend | Flutter 3.19.6                   |
| Database | MySQL 8                          |
| Auth     | JWT (JSON Web Token)             |
| Editor   | Flutter Quill (Rich Text Editor) |
| Tools   | Intellij VSCode Mysql(workbench)  |

<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

#Features
✅ User Authentication (Login, Signup, Forgot Password)

✅ JWT-based secure API access

✅ Create / Edit / View Documents (Rich Text)

✅ Public and Private document visibility

✅ Document Search (title and content)

✅ Auto-save for document edits

✅ Logout functionality

✅ Responsive, card-based dashboard UI

<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

#Architecture Overview
+---------------------+     HTTP (REST API)      +-----------------------+
|     Flutter UI      |  <-------------------->  |   Spring Boot Backend |
|  (Frontend Layer)   |                          |  (Business + Security)|
+---------------------+                          +-----------------------+
        |                                                   |
        | JSON + JWT                                         |
        v                                                   v
+---------------------+                          +------------------------+
|  Flutter Quill WYSIWYG|                       |   MySQL (Document DB)   |
|  Editor (Document UI) |                       +------------------------+
+---------------------+

<><><><><><><><><><><><><><><><><><>To Run Project <><><><><><><><><><><><><><><><><><><><><><><><><>


# Clone the project
git clone https://github.com/amargautam205/Knowledge-Base-For-Frigga.git
Open the knowledge_base_front folder in VS Code/Android Studio (front-end code)
Open a knowledge_base folder in IntelliJ (Back-end code)

Create a database using MySQL (SQL) Name: knowledge_base
set database user/password: root 

Or you can update the application.prop for your database
# Update application.properties
spring.datasource.url=jdbc:mysql://localhost:3306/knowledge_base
spring.datasource.username=root
spring.datasource.password=root

# Run the application
Run the application from both IntelliJ and VS Code

Demo credential:
email:- mail2softdev@gmail.com
password:- 12345
