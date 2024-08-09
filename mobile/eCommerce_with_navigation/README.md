


                    ========================E-commerce Mobile Application=========================



This project is an E-commerce mobile application developed using Flutter. It supports basic CRUD (Create, Read, Update, Delete) functionalities for managing products.

Project Structure
The project is divided into three primary directories: models, widgets, and pages.



                            ===================Models==================



The models directory contains the data structures used within the application. These models outline the attributes and behavior of the objects, particularly the products. In this project, there is a single model:

product.dart: This file defines the Product model, representing a product entity in the application with fields such as name, description, price, and category.
product_manager.dart: This file defines the  product methods.



                                    ==========Widgets==========


The widgets directory houses reusable UI components that are utilized throughout the application. Here's a brief overview of each file:


card.dart: Contains the ProductCard widget, which is used to present individual products in a consistent and visually appealing format. It is utilized wherever product information is displayed in a card-like layout across the application.
detail_card.dart: Contains the DetailItem widget, which is used to present individual products in a consistent and visually appealing format. It is utilized wherever product information is displayed in a card-like layout across the application.



                                    ===========Pages========



The screens directory includes the various screens of the application. Below is a brief description of each file:

home.dart: The main screen displaying a list of all products.
detail.dart: This screen provides detailed information about a specific product.
add.dart: This screen contains a form for adding a new product to the list.
edit.dart: This screen contains a form for editing a product in the list.
search.dart: This screen offers a searching feature.



                                    =======Main Application File======


The main.dart file serves as the entry point of the application. It imports essential Flutter packages and the screens used in the application. It defines the MyApp class, which extends StatelessWidget and builds the MaterialApp with the title 'E-commerce Mobile Application'.



========================================Running the Application========================================


To run the application, open your terminal, navigate to the project directory, and execute the following commands:


flutter pub get
flutter run