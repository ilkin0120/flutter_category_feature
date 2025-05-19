# Flutter Category Feature

A modern Flutter application showcasing category and subcategory management with Clean Architecture, BLoC pattern, and Material Design 3. This project demonstrates best practices in Flutter development, including state management, dependency injection, and local storage implementation.

[![Flutter](https://img.shields.io/badge/Flutter-3.19-blue)](https://flutter.dev)
[![BLoC](https://img.shields.io/badge/BLoC-9.1.1-blueviolet)](https://bloclibrary.dev)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

## 🛠 Technologies

- **State Management**: BLoC/Cubit
- **Dependency Injection**: GetIt
- **Local Storage**: Hive
- **Code Generation**: Freezed, build_runner
- **UI Components**: Material Design
- **Routing**: Custom Router

## 🔑 Key Features

1. **Category Management**:
   - Create, edit, and delete categories
   - Drag-and-drop category reorganization
   - Icon and color support for categories

2. **Subcategory Management**:
   - Hierarchical structure of categories and subcategories
   - CRUD operations for subcategories
   - Automatic updates when parent categories change

3. **Modern UI**:
   - Light and dark theme support
   - Responsive design
   - Animations and transitions

4. **Architectural Features**:
   - Clean Architecture with layer separation
   - Feature-First code organization
   - Dependency Injection for dependency management
   - Use Cases for business logic

## 📦 Installation

1. Clone the repository:
```bash
git clone https://github.com/ilkin0120/flutter_category_feature.git
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run code generation:
```bash
flutter pub run build_runner build
```

4. Run the app:
```bash
flutter run
```

## 🎯 Usage

The project demonstrates:
- Proper code organization in a Flutter application
- Implementation of modern development practices
- Complex UI implementation with animations
- Local storage integration
- State management implementation
