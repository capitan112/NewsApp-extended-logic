# News Reader(version 2.0) - SwiftUI with MV Pattern Approach extended with logic
## Overview

This project is a simple news reader application built using SwiftUI and follows the Model-View (MV) Pattern. The app is designed to demonstrate the core idea of the MV pattern while avoiding unnecessary complexity. It consists of two main screens:

Headlines View: Displays a list of news article headlines.
Stories View: Shows the full story when a headline is tapped.
The app fetches data from a mock API layer provided in the project, which includes implementations for async/await. This project uses the async/await approach for API requests, ensuring clean and modern asynchronous code.

## Key Focus Areas:

### Simplicity: The project is intentionally kept simple to highlight the use of the MV pattern and its benefits, such as separation of concerns and modularity.
### Caching: In-memory caching is implemented to store the last fetched headlines and stories, improving performance and providing a fallback when network requests fail.
### State and Error Handling: The app includes robust handling of loading states, network errors, and edge cases to ensure a smooth user experience.
This project serves as a practical example of how to structure a SwiftUI app using the MV pattern, with a focus on clarity, maintainability, and scalability. It also demonstrates essential features like caching and network error handling, which are critical for real-world applications.


## Features

### Headlines View/Store:

Displays a scrollable list of headlines.
Each headline shows the title and author's name.
Handles loading and error states.
Fetches data from the API when the view appears.

### Stories View/Store:
Displays the full story, including the title, author, content, and published date.
Handles loading and error states.
Fetches data from the API when a headline is tapped.

## Advantages of the MV Pattern Approach
Separation of Concerns
The Store handles data fetching and business logic.
The View is responsible for UI rendering and user interaction.
This separation makes the codebase more modular and easier to maintain.


### Scalability:
The pattern makes it easier to add new features or modify existing ones without affecting other parts of the app.
The clear structure helps in onboarding new developers to the project.

### Reusability:
Components like the loading and error states can be reused across different views.
The in-memory cache logic can be extended or reused in other parts of the app.

### Improved Readability
The code is organized in a way that is easy to follow and understand.
The use of SwiftUI's declarative syntax further enhances readability.

## Network layer:
Contains the mock API layer with methods getHeadlines and getStory.
Includes implementations for async/await.

## Stores for Aggregate Data

Stores have been added to aggregate and expose data to the views.
Views can directly access the store objects and retrieve the required data.
This approach improves data management and ensures a clear separation between data handling and UI rendering.

### Scalability with Multiple Stores
As your business grows, a single store might not be sufficient to maintain the lifecycle and side effects of the entire application.
To address this, the app introduces multiple stores based on the bounded context of the application.
Bounded Context: Refers to a specific area of the system with clear boundaries, designed to serve a particular business purpose.
For example, one store might handle news headlines, while another manages user preferences or analytics.
This modular approach ensures that each store is responsible for a specific domain, making the application more maintainable and scalable.

### Why Use Stores?
Centralized Data Management: Stores act as a single source of truth for specific data domains.
Lifecycle Management: Each store can manage its own lifecycle and side effects, such as API calls or caching.
Improved Testability: Stores can be easily mocked or tested in isolation.
Flexibility: New stores can be added as the application grows, without disrupting existing functionality.
Future Enhancements

Can be introduce additional stores for features like user authentication, saved articles, or personalized recommendations.



