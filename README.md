# PlaceFinder AI

**PlaceFinder AI** is a Flutter-based application that helps users discover places through an intuitive multi-step search flow and clean UI. Built with a scalable architecture and powered by Riverpod for state management, this app supports both mock and real data fetching mechanisms.

---

##  Features

-  Multi-step search experience using `PageView` and `SliderDrawer`
-  Dynamic place listing with mock and real API service abstraction
-  Riverpod-powered global state management
-  Animated welcome screen with typewriter-style intro
-  Easily switchable mock/real services for development and testing

---

##  State Management with Riverpod

This app uses **[Riverpod](https://riverpod.dev)** for predictable, scalable, and type-safe state management.

### Key Providers

* | **Provider**                      | **Type**                             | **Purpose**                                           |
* |----------------------------------|--------------------------------------|-------------------------------------------------------|
* | `placeServiceProvider`           | `Provider<PlaceService>`            | Injects either mock or real place-fetching service   |
* | `placeListProvider`              | `FutureProvider<List<Place>>`       | Asynchronously fetches place data                    |
* | `selectedStepProvider`           | `StateProvider<int>`                | Tracks the selected search step in the UI            |
* | `drawerStateProvider`            | `StateProvider<bool>`               | Tracks the open/close state of the slider drawer     |
* | `pageControllerProvider`         | `Provider<PageController>`          | Manages `PageView` navigation between steps          |
* | `welcomeTextControllerProvider`  | `StateNotifierProvider`             | Animates welcome screen text with typewriter effect  |


##  Project Structure

* lib/
* ├── models/ # Data models (e.g. Place)
* ├── services/ # PlaceService abstraction & implementations
* │ ├── mock_place_service.dart
* │ ├── real_place_service.dart
* │ ├── api_service.dart
* │ ├── mock_data.dart
* ├── providers/ # All Riverpod providers
* ├── views/ # UI components (screens, widgets)
* ├── Utils/ # Assets, fonts, etc.
* └── main.dart # App entry point