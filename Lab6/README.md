# Lab 6

| Sr. no. | Student Name     | Student ID |
| ------- | ---------------- | ---------- |
| 1       | Aatman Shah      | 202001064  |
| 2       | Fenil Dalwala    | 202001130  |
| 3       | Aditya Nawal     | 202001402  |
| 4       | Rohan Champaneri | 202001414  |
| 5       | Kashish Shroff   | 202001425  |
| 6       | Het Patel        | 202001434  |
| 7       | Parth Thakrar    | 202001450  |
| 8       | Drashit Bhakhar  | 202001453  |
| 9       | Nandini Parekh   | 202001455  |
| 10      | Amol Patel       | 202001456  |
| 11      | Smit Bhavsar     | 202001464  |

# Domain Analysis Modelling

## **Boundary objects:**

1. **Authentication interface:**

   Login Page eventually provides user to log in and manage their personal information and manage their homes information, so in some sense Login Page is providing visual boundary between user and system.

2. **Dashboard:**
   It represents the interface between the user and the home finding system.
   It provides homes and preferable area that users add into their wish list for selecting home in the new city.
3. **Comparative market Analysis:**
   It provides information on the value of similar homes in the area. This can be helpful boundary object for users for selecting homes.
4. **Neighbourhood information:**
   Neighbourhood maps can be a useful boundary object for users who are unfamiliar with the area. They can help identify local amenities, schools, and other factors that may influence the decision to purchase a home.

## **Entity objects:**

1. **Property:**
   This entity represents a specific home is available for sale or rent. It can include attributes such as address, price, square footage, and other relevant features.
2. **Neighborhood:**
   This entity represents a specific geographical area or community that is relevant for the choose home in that area. It can include attributes such as population, demographics, crime rate, school quality, amenities, and other relevant factors that can impact the desirability of a neighborhood.
3. **User:**
   This entity represents a user, who is looking for a home in a particular neighborhood. It can include attributes such as search preferences, budget, and other relevant information that can help match the user with the right properties and neighborhoods.
4. **Search:**
   This entity represents a specific search query or apply filtering by preference to find best neighborhoods. It can include attributes such as the desired neighborhood, property type, price range, and other relevant factors that can help narrow down the search results.
5. **Comparison:**
   This entity represents a comparison between two or more neighborhoods based on specific criteria. It can include attributes such as the neighborhoods being compared, the criteria used for the comparison, and the results of the comparison (e.g., which neighborhood is considered more desirable based on the criteria).
6. **Recommendation:**
   This entity represents a recommendation of a specific property or neighborhood to a user based on their search criteria and preferences. It can include attributes such as the recommended property or neighborhood, the reasons for the recommendation, and any other relevant information that can help the user make an informed decision.

## **Control objects:**

1. **Verification:**
   System verify the log-in which user have entered. This controls that correct user will be logged in.
2. **Search bar:**
   It allows users to search for a specific city and specific area in that city. Because user control system’s behaviour of what content to be shown.
3. **Rating system:**
   It controls the visibility and popularity of the area in the city in various aspects like industrial area, area near school, area near public transport.
4. **Navigation:**
   This control object allows users to navigate in different area of the different cities and choose preferable area for home.

# Sequence Diagrams

## User Story 1

![UserStory-1.drawio.png](Lab%206%20bc697068023d43fc8b584fa81bbda194/UserStory-1.drawio.png)

## User Story 2

![UserStory-2.drawio.png](Lab%206%20bc697068023d43fc8b584fa81bbda194/UserStory-2.drawio.png)

## User Story 3

![user story 3 sequence diagram.png](Lab%206%20bc697068023d43fc8b584fa81bbda194/user_story_3_sequence_diagram.png)

## User Story 4

![user story 4 sequence diagram.png](Lab%206%20bc697068023d43fc8b584fa81bbda194/user_story_4_sequence_diagram.png)

## User Story 5

![Userstory_5.drawio.png](Lab%206%20bc697068023d43fc8b584fa81bbda194/Userstory_5.drawio.png)

## User Story 6

![Userstory_6.drawio.png](Lab%206%20bc697068023d43fc8b584fa81bbda194/Userstory_6.drawio.png)

## User Story 7

![User story-7.drawio.png](Lab%206%20bc697068023d43fc8b584fa81bbda194/User_story-7.drawio.png)

## User Story 8

![User story-8.drawio.png](Lab%206%20bc697068023d43fc8b584fa81bbda194/User_story-8.drawio.png)

## User Story 9

![user story 9.png](Lab%206%20bc697068023d43fc8b584fa81bbda194/user_story_9.png)

## User Story 10

![user story 10.png](Lab%206%20bc697068023d43fc8b584fa81bbda194/user_story_10.png)

# Class Diagram

![Class diagram.png](Lab%206%20bc697068023d43fc8b584fa81bbda194/Class_diagram.png)

# High Level System Design

## **High-Level Diagram for “Where Should You Live” Application**

![High_Level_Diagram.png](Lab%206%20bc697068023d43fc8b584fa81bbda194/High_Level_Diagram.png)

## **Architecture of Application**

We are going to follow the multi-tier architecture for the development of the “Where should you live” suggester application.
The architecture used is described below. The multi-tier architecture, also known as the multi-layer architecture, is a software architecture pattern used in designing large-scale, scalable and secure applications. It is divided into three layers, each responsible for a specific set of functionalities:

1. **Presentation Layer:** The presentation layer is responsible for presenting the data to the user in a user-friendly format. This layer is often referred to as the UI layer and includes user interfaces such as web pages, mobile applications, and desktop applications. It handles functions like interfaces of login, sign-up, home page, etc. It interacts with the business layer and displays the results to the user. We will be handling the frontend part via using the Flutter Dart UI.
2. **Application Layer (Back-end):** The application layer is responsible for implementing the business logic of the application. It is also referred to as the middle or business layer. This layer contains the application's core logic and handles tasks such as data authentication, processing, and manipulation. The application layer communicates with the presentation layer and the data layer to retrieve and manipulate data. This layer also supervises and analyse task flow control and caching. Along with handling all the queries of that are requested by the users. We will be using the Flutter framework to connect with the database. Overall, the Flutter framework will handle the backend of the application.
3. **Data Layer:** Is responsible for managing the application's data. It includes the database management system and the data access layer. The data layer is responsible for storing and retrieving data from a database or file system. It communicates with the application layer to retrieve data and send it back to the user via the presentation layer. Here all the data related to houses and all the attributes that are associated with it is managed by data layer. Data base that we have implement in this “Where should you live” application is Firebase. Firebase controller manages the actual Firebase database here.
4. **Services Layer:** All the third-party integration and other services that are already existing in the market, is integrated through the services layer and it is dependent on the application/business layer.
