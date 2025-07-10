# JSON Dart - Complete JSON to Dart Code Generation Solution

> 🌐 **Language**: [中文](README.md) | [English](README_EN.md)

<p align="center">
  <img src="apps/jsond/assets/JSON.png" width="120" alt="JSON Dart Logo">
</p>

<p align="center">
  <strong>🚀 Powerful, Flexible, and Easy-to-Use JSON to Dart Code Generation Toolkit</strong>
</p>

<p align="center">
  <a href="https://github.com/iota9star/json_dart/releases"><img src="https://img.shields.io/github/v/release/iota9star/json_dart" alt="Release"></a>
  <a href="https://github.com/iota9star/json_dart/blob/main/LICENSE"><img src="https://img.shields.io/github/license/iota9star/json_dart" alt="License"></a>
  <a href="https://github.com/iota9star/json_dart/stargazers"><img src="https://img.shields.io/github/stars/iota9star/json_dart" alt="Stars"></a>
  <a href="https://github.com/iota9star/json_dart/issues"><img src="https://img.shields.io/github/issues/iota9star/json_dart" alt="Issues"></a>
</p>

## 📖 Project Overview

JSON Dart is a comprehensive toolkit designed to simplify the process of generating Dart model classes from JSON data in Flutter and Dart development. Whether you're working with REST API responses, configuration files, or database records, JSON Dart provides an efficient and flexible solution.

### 🎯 Core Advantages

- **🎨 Diverse Templates**: Support for mainstream code generation frameworks like JsonSerializable, Freezed, Hive, Isar
- **🖥️ Cross-Platform Support**: Provides both Flutter GUI application and command-line tool
- **⚡ High-Performance Parsing**: ANTLR4-based JSON5 parser supporting complex data structures
- **🛠️ Highly Customizable**: Support for custom templates and fully configurable code generation rules
- **📱 Modern UI**: Beautiful Material Design 3 interface with theme customization

## 🏗️ Project Architecture

This project uses a monorepo architecture with the following components:

```
json_dart/
├── 📱 apps/
│   └── jsond/                 # Flutter GUI Application (jsond_app)
├── 📦 packages/
│   ├── core/                  # Core Parsing and Generation Library (jsond_core)
│   └── json/                  # Command Line Tool + Build Runner (jsond)
└── 🛠️ scripts/               # Build and Tool Scripts
```

### Component Description

| Component | Package Name | Description | Tech Stack | Purpose |
|-----------|--------------|-------------|------------|---------|
| **JSON Dart App** | `jsond_app` | Cross-platform GUI application | Flutter, Material 3 | Visual JSON to Dart conversion |
| **JSON Dart CLI** | `jsond` | Command-line tool + Build Runner | Dart, Build | Batch processing, CI/CD integration, build-time code generation |
| **JSON Dart Core** | `jsond_core` | Core library | Dart, ANTLR4, Mustache | Parsing engine and code generation |

## 🚀 Quick Start

### 📋 Requirements

- **Flutter**: >= 3.32.6
- **Dart**: >= 2.18.0
- **Operating System**: Windows, macOS, Linux

### 🛠️ Installation Methods

#### Method 1: Using Flutter GUI Application

```bash
# Clone the project
git clone https://github.com/iota9star/json_dart.git
cd json_dart

# Install dependencies
flutter pub get

# Run the application
flutter run
```

#### Method 2: Install Command Line Tool

```bash
# Global installation of CLI tool
dart pub global activate jsond

# Use CLI tool
jsond -p example.json -t freezed -f
```

#### Method 3: As Library Dependency

```yaml
# pubspec.yaml
dependencies:
  jsond_core: ^1.0.0

dev_dependencies:
  jsond: ^1.0.0
  build_runner: ^2.3.3
```

#### Method 4: Build Runner Integration

```yaml
# pubspec.yaml
dev_dependencies:
  jsond: ^1.0.0
  build_runner: ^2.3.3

# build.yaml (optional configuration)
targets:
  $default:
    builders:
      jsond:json:
        options:
          template: "freezed"
          use_dart_format: true
```

### 🎯 Basic Usage

#### GUI Application Usage
1. Launch the Flutter application
2. Input JSON data in the left JSON editor
3. Select appropriate code generation template from the template list
4. View generated Dart code on the right panel
5. Click copy button to get the code

#### CLI Tool Usage
```bash
# Process single file
jsond -p data.json -t json_serializable -f

# Batch process directory
jsond -d ./json_files -t freezed -f -r

# Use custom template
jsond -p data.json -e custom_template.hbs -f
```

#### Build Runner Usage
```bash
# Place JSON files in your project (e.g., assets/json/)
# Run build to generate Dart code
dart run build_runner build

# Watch mode (for development)
dart run build_runner watch
```

#### Library Usage
```dart
import 'package:jsond_core/jsond_core.dart';

void main() {
  const json = '{"name": "John", "age": 30}';
  final dartCode = render(json, freezed, dartFormat: true);
  print(dartCode);
}
```

## 🎨 Supported Templates

### 📝 Basic Templates
- **With Final**: Generate basic models with `final` modifiers
- **No Final**: Generate models with mutable fields

### 🔄 Serialization Templates
- **JsonSerializable**: Using `json_annotation` package
- **JsonSerializable + HiveCE**: Combined with Hive database annotations

### ❄️ Immutable Templates
- **Freezed**: Basic Freezed immutable models
- **Freezed + Default**: Freezed models with default values
- **Freezed + HiveCE**: Freezed models combined with Hive
- **Unfreezed**: Mutable Freezed-style models

### 🗃️ Database Templates
- **Isar**: Designed specifically for Isar database
- **Isar + JsonSerializable**: Isar combined with serialization
- **Isar + Freezed**: Isar combined with immutable models

## 💡 Feature Highlights

### 🔍 Powerful Parsing Capabilities
- **JSON5 Support**: Full support for JSON5 format (comments, trailing commas, etc.)
- **Type Inference**: Intelligent Dart data type inference
- **Nested Structures**: Perfect handling of complex nested objects and arrays
- **Null Handling**: Smart recognition of nullable fields and union types

### 🎛️ Flexible Configuration
- **Custom Templates**: Full custom templates with Handlebars syntax support
- **Naming Conventions**: Support for multiple naming conventions (camelCase, PascalCase, snake_case, etc.)
- **Keyword Handling**: Automatic handling of Dart keyword conflicts
- **Code Formatting**: Integrated `dart format` automatic formatting

### 🖥️ User Experience
- **Real-time Preview**: Real-time Dart code generation during JSON input
- **Error Messages**: Detailed JSON syntax error information
- **Theme Customization**: Support for light/dark themes and custom colors
- **Quick Actions**: Rich shortcuts and toolbar operations

### 🔧 Developer Friendly
- **Batch Processing**: CLI tool supports batch conversion of multiple files
- **CI/CD Integration**: Perfect fit for continuous integration workflows
- **Build Runner**: Support for build_runner integration
- **Plugin System**: Extensible plugin architecture (planned)

## 📚 Detailed Documentation

### Language Versions
- 🇨🇳 [中文文档](README.md)
- 🇺🇸 [English Documentation](README_EN.md) (Current)

### Component Documentation
- 📱 [Flutter App Documentation](apps/jsond/README_EN.md) | [中文](apps/jsond/README.md) - Complete GUI application guide
- 💻 [CLI Tool Documentation](packages/json/README_EN.md) | [中文](packages/json/README.md) - Detailed command-line tool instructions
- 🔧 [Core Library Documentation](packages/core/README_EN.md) | [中文](packages/core/README.md) - API reference and advanced usage

### Technical Guides
- 📋 [Project Issues Analysis](PROJECT_ISSUES.md) - Code quality analysis and fix recommendations
- 🎯 [Changelog](CHANGELOG.md) - Version update records
- 🔧 [Contributing Guide](CONTRIBUTING.md) - Detailed development and contribution guidelines

## 🎯 Use Cases

### 🌐 API Development
```bash
# Quickly generate models from API responses
curl https://api.example.com/users | jsond -t json_serializable -f > lib/models/user.dart
```

### 🗄️ Database Modeling
```dart
// Generate type-safe models for Hive database
final code = render(schemaJson, jsonSerializableWithHiveCE, dartFormat: true);
```

### ⚙️ Configuration Management
```dart
// Convert configuration files to type-safe Dart classes
final configModel = render(configJson, freezed, dartFormat: true);
```

### 🔄 Code Generation Workflow
```yaml
# build.yaml - Integration with build_runner workflow
targets:
  $default:
    builders:
      jsond:json:
        options:
          template: "freezed"
          use_dart_format: true
          use_built_in: true
```

```bash
# Project structure example
lib/
  models/
    user.json          # JSON data file
    user.json.dart     # Auto-generated Dart code

# Build command
dart run build_runner build --delete-conflicting-outputs
```

## 🎨 Template Examples

### Basic Template Output
```dart
class User {
  User();

  factory User.fromJson(Map<String, dynamic> json) {
    return User()
      ..id = json['id']
      ..name = json['name']
      ..email = json['email'];
  }

  late int id;
  late String name;
  late String email;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
```

### Freezed Template Output
```dart
@freezed
class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String email,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
```

## 🛣️ Roadmap

### 🎯 Short-term Goals (v1.0)
- [ ] **Configuration File Support**: `jsond.yaml` configuration files
- [ ] **Incremental Processing**: Smart detection of file changes, incremental updates
- [ ] **Parallel Processing**: Multi-file parallel conversion support
- [ ] **Plugin System**: Extensible plugin architecture

### 🚀 Medium-term Goals (v1.5)
- [ ] **GraphQL Support**: Generate models from GraphQL Schema
- [ ] **TypeScript Support**: Generate TypeScript type definitions
- [ ] **IDE Extensions**: VS Code and IntelliJ plugins
- [ ] **Cloud Service**: Online conversion service

### 🌟 Long-term Vision (v2.0)
- [ ] **Multi-language Support**: Support for more programming languages
- [ ] **AI Assistance**: Smart template recommendations and code optimization
- [ ] **Team Collaboration**: Template sharing and version control
- [ ] **Performance Analysis**: Code performance analysis and optimization suggestions

## 📊 Performance Benchmarks

### Parsing Performance
| JSON Size | Parse Time | Memory Usage |
|-----------|------------|--------------|
| 1KB       | < 1ms      | < 1MB        |
| 100KB     | < 50ms     | < 10MB       |
| 1MB       | < 500ms    | < 50MB       |

### Generation Performance
| Object Count | Generation Time | Code Lines |
|-------------|-----------------|------------|
| 1-10        | < 10ms          | 50-500     |
| 11-100      | < 100ms         | 500-5K     |
| 100+        | < 1s            | 5K+        |

## 🤝 Contributing Guide

We warmly welcome community contributions! Whether it's bug reports, feature requests, code contributions, or documentation improvements, we greatly appreciate them all.

### 🛠️ Development Environment Setup

```bash
# 1. Fork and clone the project
git clone https://github.com/YOUR_USERNAME/json_dart.git
cd json_dart

# 2. Install dependencies
flutter pub get

# 3. Run tests
flutter test

# 4. Create feature branch
git checkout -b feature/amazing-feature

# 5. Commit changes
git commit -m "feat: add amazing feature"

# 6. Push branch
git push origin feature/amazing-feature

# 7. Create Pull Request
```

### 📝 Contribution Types

#### 🐛 Bug Reports
Found a bug? Please create an [Issue](https://github.com/iota9star/json_dart/issues) and include:
- Detailed reproduction steps
- Expected vs actual behavior
- Environment information (OS, Flutter version, etc.)
- Relevant error logs

#### 💡 Feature Requests
Have a great idea? We'd love to hear it! Please share your thoughts in [Discussions](https://github.com/iota9star/json_dart/discussions).

#### 🔧 Code Contributions
- Follow the project's code style
- Add appropriate tests
- Update relevant documentation
- Ensure all tests pass

#### 📖 Documentation Improvements
- Fix errors in documentation
- Add examples and use cases
- Improve API documentation
- Translate documentation to other languages

### 🏆 Contributors

Thanks to all developers who have contributed to the project!

<a href="https://github.com/iota9star/json_dart/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=iota9star/json_dart" />
</a>

## 📄 License

This project is licensed under the [MIT License](LICENSE). You are free to use, modify, and distribute this software.

## 🔗 Related Links

### 📱 Project Resources
- [GitHub Repository](https://github.com/iota9star/json_dart)
- [Releases](https://github.com/iota9star/json_dart/releases)
- [Issue Tracker](https://github.com/iota9star/json_dart/issues)
- [Discussions](https://github.com/iota9star/json_dart/discussions)

### 📚 Technical Documentation
- [Flutter Official Documentation](https://docs.flutter.dev/)
- [Dart Language Guide](https://dart.dev/guides)
- [JSON5 Specification](https://json5.org/)
- [ANTLR4 Documentation](https://github.com/antlr/antlr4)

### 🛠️ Related Tools
- [json_serializable](https://pub.dev/packages/json_serializable)
- [freezed](https://pub.dev/packages/freezed)
- [hive](https://pub.dev/packages/hive)
- [isar](https://pub.dev/packages/isar)

---

<p align="center">
  <strong>🌟 If this project helps you, please give us a Star! 🌟</strong>
</p>

<p align="center">
  Made with ❤️ by <a href="https://github.com/iota9star">iota9star</a> and <a href="https://github.com/iota9star/json_dart/graphs/contributors">contributors</a>
</p>
