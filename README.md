# 🧠 Inventory Management System
The Inventory Management System is a comprehensive application designed to manage inventory items, providing features for creating, reading, updating, and deleting items. The system consists of a backend API built with Python and Cloud Functions, a frontend application built with React, and an infrastructure setup using Terraform and Google Cloud Platform (GCP) services.

## 🚀 Features
- Create, read, update, and delete inventory items
- Handle CORS responses and interact with Firestore database
- Use React for building the frontend application
- Implement Terraform for infrastructure management
- Utilize GCP services such as Cloud Functions, IAM, Cloud Firestore, and Cloud Storage
- Define API Gateway configuration using OpenAPI specification

## 🛠️ Tech Stack
- Backend: Python, Cloud Functions, Firestore
- Frontend: React, JavaScript
- Infrastructure: Terraform, Google Cloud Platform (GCP)
- Database: Cloud Firestore
- Storage: Cloud Storage
- API Gateway: OpenAPI specification
- Dependencies: `google-cloud-firestore`, `react`, `terraform`, `hashicorp/google`, `hashicorp/google-beta`

## 📦 Installation
To set up the project, follow these steps:
1. **Prerequisites**: Install Node.js, Python, and Terraform on your machine.
2. **Backend**:
    - Install required dependencies using `pip install -r requirements.txt`
    - Set up Cloud Functions and Firestore using the GCP console
3. **Frontend**:
    - Install required dependencies using `npm install`
    - Set up the React application using `npm start`
4. **Infrastructure**:
    - Initialize Terraform using `terraform init`
    - Apply the Terraform configuration using `terraform apply`

## 💻 Usage
To use the application, follow these steps:
1. Start the backend API using `python main.py`
2. Start the frontend application using `npm start`
3. Interact with the application using the provided API endpoints

## 📂 Project Structure
```markdown
.
├── backend
│   ├── src
│   │   ├── main.py
│   │   ├── utils.py
│   │   ├── create_item.py
│   │   ├── get_items.py
│   │   ├── update_item.py
│   │   └── delete_item.py
│   └── requirements.txt
├── frontend
│   ├── src
│   │   ├── App.jsx
│   │   ├── services
│   │   │   └── api.js
│   │   ├── components
│   │   │   ├── InventoryForm.jsx
│   │   │   ├── InventoryList.jsx
│   │   │   └── InventoryDetails.jsx
│   └── package.json
├── infrastructure
│   ├── provider.tf
│   ├── backend.tf
│   ├── main.tf
│   └── api-gateway
│       └── openapi.yaml
└── README.md
```

## 📸 Screenshots


## 🤝 Contributing
To contribute to the project, please follow these steps:
1. Fork the repository
2. Create a new branch for your feature or bug fix
3. Submit a pull request with a detailed description of your changes

## 📝 License
The project is licensed under the MIT License.

## 📬 Contact
For any questions or concerns, please contact us at [firmansyahwicaksono30@gmail.com](mailto:firmansyahwicaksono30@gmail.com).

💖 Thanks You
