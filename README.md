# 🛒 ABAP Webshop

![ABAP](https://img.shields.io/badge/ABAP-SAP-blue?style=flat-square&logo=sap)
![License](https://img.shields.io/badge/license-MIT-green?style=flat-square)
![Status](https://img.shields.io/badge/status-active-brightgreen?style=flat-square)
![SAP](https://img.shields.io/badge/SAP-ERP-orange?style=flat-square&logo=sap)

A fully functional webshop application built natively in **ABAP (Advanced Business Application Programming)**,
running on the SAP platform. This project leverages SAP's backend capabilities to deliver a robust,
scalable, and enterprise-grade e-commerce experience.

---

## 📌 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

---

## 📖 Overview

This project implements a webshop solution entirely within the SAP ecosystem using ABAP.
It integrates with core SAP modules to manage products, orders, customers, and inventory —
eliminating the need for external middleware and keeping all business logic within a
single, unified SAP environment.

---

## ✨ Features

- 🛍️ **Product Catalog** — Browse and search products with dynamic filtering
- 🛒 **Shopping Cart** — Add, update, and remove items in real time
- 👤 **Customer Management** — User registration, login, and profile management
- 📦 **Order Processing** — End-to-end order lifecycle management
- 💳 **Payment Integration** — Supports payment processing workflows
- 📊 **Inventory Management** — Real-time stock tracking via SAP MM integration
- 🔐 **Role-Based Access Control** — Secure access management using SAP authorization objects
- 📱 **Responsive UI** — Built with SAP UI5 / Fiori for a modern user experience

---

## 🛠️ Tech Stack

| Layer        | Technology                          |
|--------------|--------------------------------------|
| Backend      | ABAP (OOP)                           |
| Frontend     | SAP UI5 / SAP Fiori / BSP            |
| API Layer    | OData Services (SAP Gateway / REST)  |
| Database     | SAP HANA / SAP DB                    |
| Integration  | SAP MM, SAP SD, SAP FI modules       |
| Transport    | SAP Change & Transport System (CTS)  |

---

## ✅ Prerequisites

Before getting started, ensure you have the following:

- SAP NetWeaver 7.40 or higher (or SAP S/4HANA)
- SAP ABAP Development Tools (ADT) / SAP GUI
- SAP Gateway configured (for OData services)
- SAP Basis authorization to create/transport objects
- Access to an SAP Development system (DEV client)
- [Eclipse IDE](https://www.eclipse.org/) with ABAP Development Tools plugin (recommended)

---

## 🚀 Installation

### 1. Clone the Repository

```bash
git clone https://github.com/Lnaj/Book_app.git
cd Book_app
