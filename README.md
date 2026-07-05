
# ☕ Cafe Service Automation

**Intelligent Cafe Order Automation System**

[![Flutter](https://img.shields.io/badge/Flutter-3.2+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Node.js](https://img.shields.io/badge/Node.js-18+-339933?logo=node.js&logoColor=white)](https://nodejs.org)
[![MariaDB](https://img.shields.io/badge/MariaDB-10.11+-003545?logo=mariadb&logoColor=white)](https://mariadb.org)
[![License](https://img.shields.io/badge/License-MIT-yellow)](https://opensource.org/licenses/MIT)

[Overview](#overview) • [Features](#features) • [Architecture](#architecture) • [Setup](#setup) • [Tech Stack](#tech-stack) • [Contact](#contact)

---

## Overview

A complete, professional automation system for cafes that digitizes and streamlines the ordering process. Customers sit at a table, scan the QR code, browse the digital menu, place their order, and the barista receives the notification instantly on a professional admin dashboard. No paper, no waiting, with an exceptional UX and a stunning light/dark theme.

---

## Features

📱 **Customer Panel (Flutter - Android):**
* App-free entry by simply scanning the QR code on the table
* Digital menu with categories (Hot, Cold, Desserts...)
* Smart cart with the ability to leave notes for the barista
* "Call Barista" button with anti-spam rate limiting
* Customer loyalty club and points collection system

💻 **Admin Dashboard (Web/Desktop):**
* Dashboard with weekly revenue charts and category share pie charts (`fl_chart`)
* Full product management (Add, Edit, Delete with images)
* Discount, Barista, and User management
* Real-time order monitoring and status updates

🔄 **Backend & Infrastructure:**
* Real-time communication between customer and barista via `Socket.io`
* Secure JWT authentication (Separating Admin and Customer access)
* Fully Persian (RTL) interface with a warm caramel color palette
* Light and Dark theme support
* PWA support for iOS users (No App Store release needed)

---

## Architecture

```
┌─────────────────────────────────────────────────────┐
│                   CLIENT LAYER                      │
│  ┌─────────────────────┐   ┌─────────────────────┐  │
│  │  Flutter App (Android)│   │  PWA (iOS / Web)   │  │
│  └──────────┬──────────┘   └──────────┬──────────┘  │
└─────────────┼───────────────────────────┼────────────┘
              │      REST / WebSocket     │
┌─────────────┼───────────────────────────┼────────────┐
│             ▼       API LAYER          ▼            │
│  ┌──────────────────────────────────────────────┐   │
│  │           Node.js + Express.js               │   │
│  │    (Auth, Orders, Products, Socket.io)       │   │
│  └──────────────────────┬───────────────────────┘   │
└─────────────────────────┼───────────────────────────┘
                          │
┌─────────────────────────┼───────────────────────────┐
│           DATA LAYER    ▼                           │
│  ┌────────────────────────────────────┐  ┌───────┐  │
│  │          MariaDB 10.11+           │  │ Redis │  │
│  │  (Users, Orders, Products, ...)   │  │ Cache │  │
│  └────────────────────────────────────┘  └───────┘  │
└─────────────────────────────────────────────────────┘
```

---

## Setup

Prerequisites: `Node.js`, `Flutter SDK`, `MariaDB`

**1. Clone the repository:**
```bash
git clone https://github.com/TssHacK/Coffee-System-Management.git
cd Coffee-System-Management
```

**2. Configure the Backend:**
```bash
cd Backend
npm install
```
Create a `.env` file and add your database and JWT credentials:
```env
PORT=3000
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=cafe_service
JWT_SECRET=your_super_secret_key
```
Import the database schema and start the server:
```bash
npm run dev
```

**3. Configure Flutter:**
```bash
cd ../App/coffee
flutter pub get
flutter run
```

---

## Tech Stack

| Section | Technologies |
| :--- | :--- |
| **Frontend** | Flutter 3.2+, Provider, GoRouter, FlChart, Cached Network Image |
| **Backend** | Node.js, Express.js, Socket.io, JWT, Joi, Multer |
| **Database** | MariaDB, Redis (Caching & Rate Limiting) |
| **Tools** | Git, VS Code, Postman, Android Studio |

---

## Contact

<table>
  <tr>
    <td>
      <a href="https://github.com/TssHacK">
        <img src="https://github.com/TssHacK.png" width="100" style="border-radius: 50%;" alt="Ehsan Fazli"/>
      </a>
    </td>
    <td>
      <b>Ehsan Fazli</b> <br>
      🌐 <a href="https://ehsanjs.ir">ehsanjs.ir</a> &bull; <a href="https://ehsanfazli.ir">ehsanfazli.ir</a> <br>
      💼 <a href="https://github.com/TssHacK">TssHacK</a> <br>
      📱 <a href="https://t.me/abj0o">@abj0o</a> <br>
      📸 <a href="https://instagram.com/_devehsan_">_devehsan_</a>
    </td>
  </tr>
</table>

---

<div align="center">
Never underestimate a cup of coffee ☕
</div>