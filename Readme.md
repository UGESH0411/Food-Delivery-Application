# Food Delivery Application

## Overview

The Food Delivery Application is a web-based platform designed to simplify online food ordering and restaurant management.
It allows customers to browse food items, view detailed information, add items to a shopping cart, place secure orders, and provide feedback.
Administrators can manage menus, view customer orders, and track feedback through a dedicated admin panel.

---

## Objective

The main objective of this project is to provide an interactive, user-friendly, and secure online food ordering system that benefits both customers and restaurant administrators.

It integrates key modules such as:

* Menu browsing
* Shopping cart management
* Order placement
* Online payment
* Feedback collection
* Admin management tools

---

## Implementation

### Frontend

The frontend is responsible for all user interactions and presentation.

**Technologies Used**

* HTML — Defines the web page structure (menu, cart, feedback forms)
* CSS — Enhances styling, layout, and responsiveness
* JavaScript — Adds dynamic behavior and form validation
* AJAX — Enables real-time cart updates without page reloads
* JSP / PHP — Used for dynamic content rendering and server communication

**Key Features**

* Browse available food items with price and description
* Add to cart, update, and remove items
* Checkout with secure payment options
* Submit feedback after order completion
* Fully responsive and mobile-friendly design

---

### Backend

Handles all business logic, server-side operations, and database management.

**Technologies Used**

* Servlets / JSP — Manage user sessions and handle requests
* PHP — Server-side scripting and API interaction
* MySQL — Stores user data, menu details, orders, and feedback
* XML — Used for configuration or structured data export

**Core Modules**

* User Management — Registration, login, and authentication
* Menu Management — Add, update, or delete food items
* Cart & Orders — Manage cart items and order confirmations
* Payment Processing — Handle secure transactions
* Feedback System — Collect and store customer feedback
* Admin Panel — Manage users, menu, and order data

---

## Testing

**Technologies Used**

* Selenium — Automated UI testing for flows like login, order placement, and feedback
* Manual Testing — Module-wise validation and bug fixing
* Cross-Browser Testing — Ensures functionality across browsers and devices

**Test Scope**

* Registration and Login validation
* Menu display and Cart operations
* Order confirmation and Payment verification
* Admin panel features
* Feedback submission and storage

---

## How to Run the Project

### Prerequisites

* XAMPP / WAMP (for PHP and MySQL)
* Apache Tomcat (if using JSP/Servlets)
* MySQL Server
* Modern browser (Chrome, Firefox, Edge)

### Steps

1. Clone this repository:

   ```bash
   git clone https://github.com/<your-username>/Food-Delivery-Application.git
   ```
2. Import the project into your IDE (Eclipse / VS Code).
3. Import the database:

   ```sql
   CREATE DATABASE fooddelivery;
   USE fooddelivery;
   SOURCE database/fooddelivery.sql;
   ```
4. Configure `web.xml` or `db_config.php` with your local database credentials.
5. Start the Apache/Tomcat server.
6. Open your browser and visit:

   ```
   http://localhost/FoodDeliveryApp/
   ```

---

## Future Enhancements

* Integration with UPI and digital wallets
* Real-time order tracking
* Mobile application support
* Push notifications for order status updates

---

## Contributors

* Ugesh K – Developer and Project Designer

---

## License

This project is licensed under the MIT License — you are free to use, modify, and distribute it with attribution.

---

## Support

If you find this project helpful, give it a star on GitHub.


