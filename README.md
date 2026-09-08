# AcuteFlow

A Flutter application designed to streamline clinical decision-making through an decision tree system. AcuteFlow guides homeopathic healthcare practitioners through systematic patient assessment and remedy selection, with particular emphasis on constitutional and symptomatic indicators.

## Overview

AcuteFlow provides a structured approach to patient evaluation by mapping activity states to targeted therapeutic recommendations. The application leverages a comprehensive decision tree architecture to navigate complex clinical scenarios, from baseline states to acute presentations, ensuring practitioners have access to evidence-based remedy suggestions tailored to individual patient profiles.

## Key Features

- **Hierarchical Decision Tree Navigation**: Systematically assess patient activity states through an intuitive, multi-level classification system
- **Contextual Remedy Recommendations**: Intelligent filtering of remedies based on thermal sensitivity, hydration status, and behavioral indicators
- **Offline Functionality**: Complete access to the remedy database and decision protocols without internet connectivity
- **Responsive Design**: Seamlessly adapts to mobile and tablet displays with careful attention to usability
- **Fast Performance**: Leverages Hive database for optimized local data persistence and quick retrieval

## Getting Started

### Prerequisites

- Flutter SDK 3.13.1 or higher
- Dart 3.13.1 or higher
- Android Studio or Xcode (for device emulation or physical testing)

### Installation

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd acuteflow
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Build Code Generators**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the Application**
   ```bash
   flutter run
   ```

## Project Architecture

AcuteFlow follows clean architecture principles with clear separation of concerns:

### Layer Structure

- **Presentation Layer**: Flutter UI components, BLoC state management cubits
- **Domain Layer**: Abstract repository interfaces defining business logic contracts
- **Data Layer**: Repository implementations, data models, and local persistence via Hive

### Key Components

#### Decision Tree System
The decision tree is loaded from JSON and structured hierarchically:
- **Root States**: Primary activity classifications (No Change, Decreased Activity, Increased Activity, AWOTA)
- **Sub-Categories**: Refined classifications based on presentation
- **Leaf Nodes**: Terminal states that map to specific remedy suggestions

#### Remedy Resolution Engine
Smart algorithm for remedy selection based on:
- Direct remedies (simple mapping from node)
- Branch-based remedies (thermal sensitivity dependent)
- Matrix-based remedies (combined thermal and hydration factors)

#### State Management
BLoC pattern implementation with dedicated cubits:
- `ActivityStateCubit`: Manages root activity state loading and transitions
- `RemedySelectionCubit`: Handles remedy filtering based on patient indicators

## Project Structure

```
lib/
├── core/
│   ├── database/         # Hive initialization and asset loading
│   ├── di/              # Dependency injection setup
│   └── utils/           # Icon mapping, navigation, enums
├── features/
│   └── decision_tree/
│       ├── data/        # Repository implementations, models
│       ├── domain/      # Abstract repositories
│       └── presentation/ # Screens, cubits, widgets
└── consts/
    └── constants.dart   # Colors, text styles, icons
```

## Core Dependencies

- **flutter_bloc**: State management and business logic separation
- **hive & hive_flutter**: Efficient local data persistence
- **get_it**: Service locator for dependency injection
- **flutter_svg**: Vector graphic rendering
- **google_fonts**: Typography consistency
- **flutter_native_splash**: Branded app launch experience

## Data Structure

### Decision Tree Format
```json
{
  "activity_states": [
    {
      "id": "no_change",
      "label": "No Change",
      "description": "Patient shows baseline activity level...",
      "requires_thermal": false,
      "requires_hydration": false,
      "remedies": ["opium", "natrum_mur"]
    }
  ]
}
```

### Remedy Format
```json
{
  "id": "remedy_id",
  "name": "Remedy Name",
  "decisive_symptoms": ["Symptom 1", "Symptom 2"],
  "other_behaviors": ["Behavior 1", "Behavior 2"]
}
```

## Development Workflow

### Building for Distribution

**Android:**
```bash
flutter build apk --split-per-abi
```

**iOS:**
```bash
flutter build ios
```

### Code Generation

The project uses Hive code generation for model adapters. After modifying model files:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Responsive Scaling

The app implements a custom responsive scaling system via `ResponsiveScaler` extension:
- Base design width: 440dp (mobile)
- Tablet base width: 835dp
- Automatic scaling ensures consistent spacing across devices

## Testing & Quality

The project is structured to facilitate testing. Mock repositories can be easily injected via the DI container for unit and integration testing.

## Customization

### Adding New Activity States

1. Update `assets/data/decision_tree.json` with new states
2. Add corresponding SVG icon to `assets/icons/`
3. Update `icon_mapper.dart` to map the new state ID to its icon
4. Regenerate Hive models if needed

### Extending Remedy Database

Add new remedies to `assets/data/remedy_details.json`. The system will automatically load them on first app launch.

## Performance Considerations

- Initial app load includes 2-second splash screen for database initialization
- Hive database is seeded only once (on first launch)
- All remedy lookups use indexed access for O(1) retrieval
- SVG assets are rendered efficiently with appropriate caching

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

**Author**: Shahzaib Ahmad  
**Version**: 1.0.0  
**Last Updated**: 2026

For questions or contributions, please contact.
