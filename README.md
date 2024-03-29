# Weather App

Weather App

## Overview

The Weather App is a Flutter application that provides users with real-time weather information for different cities. The app follows the MVVM clean architecture and incorporates effective state management, API integration, and dynamic UI updates.

## Features

- **MVVM Architecture:** The app is structured using the MVVM design pattern to ensure a clean separation of concerns between the model, view, and ViewModel layers.

- **State Management:** Implements a robust state management solution with Bloc advanced state management tool, to handle the app's state effectively.

- **API Integration:** Connects to a public weather API to fetch real-time weather data, including information such as temperature, humidity, wind speed, and weather conditions.

- **Dynamic UI Updates:** The UI updates dynamically based on the API responses. Efficiently implements loading, error, and data states.

- **Error Handling:** Utilizes a sophisticated error handling strategy for API calls  providing user-friendly error messages.

- **User Input:** Allows users to select different cities for which they want to see the weather. This could involve a search function or a dropdown menu.

- **Local Caching:** Implements local caching to store the most recent weather data for offline access.

- **Unit Testing:** Includes unit tests for the business logic to ensure the reliability of the codebase.

### Bonus Features

- **Advanced UI Interactions:** Enhances the user experience with animations or gestures for an interactive interface.

- **Theme Switching:** Implements a feature to toggle between light and dark themes for user customization.

- **Flavors:** Utilizes flavors in the app for different configurations. We use it in dev mode and production mode.
  Production mode: have a Device Preview Feature.
  Release mode : Disable Device Preview Feature 
- **Storing & Encryption:** Stores the fetched weather data for the week and encrypts it for enhanced security.

## Requirements

- **Flutter:** [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart:** [Install Dart](https://dart.dev/get-dart)

## Setup

1. Clone the repository:

```bash
git clone https://github.com/moaazsalama/weather_app.git
```

2. Navigate to the project directory:

```bash
cd weather_app
```

3. Install the dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```
