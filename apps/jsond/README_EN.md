# JSON Dart App - Flutter GUI Application (`jsond_app`)

> 🌐 **Language**: [中文](README.md) | [English](README_EN.md)

A powerful Flutter GUI application for JSON to Dart code generation. This application provides an intuitive user interface that allows developers to quickly convert JSON data into Dart model classes.

## 🌟 Key Features

### 📝 JSON Input Support
- **Real-time Parsing**: Support for standard JSON and JSON5 formats
- **Formatting Functions**: Automatic formatting and beautification of JSON content
- **Unicode Escaping**: Support for Unicode string conversion
- **Error Messages**: Detailed JSON syntax error prompts

### 🎨 Multiple Built-in Templates
- **With Final**: Generate basic models with final modifiers
- **No Final**: Generate models without final modifiers
- **JsonSerializable**: Integrate with json_annotation package
- **JsonSerializable With HiveCE**: Combined with Hive database annotations
- **Freezed**: Generate immutable models using Freezed package
- **Freezed With Default**: Freezed models with default values
- **Freezed With HiveCE**: Freezed models combined with Hive
- **Isar**: Models supporting Isar database
- **Isar + JsonSerializable**: Isar combined with json_annotation
- **Isar + Freezed**: Isar combined with Freezed

### ⚙️ Custom Configuration
- **Custom Templates**: Support for custom template writing with Handlebars syntax
- **Object Naming**: Customizable generated class names
- **Theme System**: Support for light/dark theme switching
- **Color Themes**: Customizable application theme colors
- **Code Formatting**: Integrated Dart code formatting tool

### 💻 Cross-Platform Support
- **Desktop Applications**: Support for Windows, macOS, Linux
- **Mobile Applications**: Support for Android, iOS
- **Web Applications**: Support for browser execution

## 🚀 Quick Start

### Install Dependencies
```bash
# Clone the project
git clone https://github.com/iota9star/json_dart.git
cd json_dart

# Install dependencies
flutter pub get
```

### Run Application
```bash
# Run Flutter application
flutter run
```

### Usage Steps
1. **Input JSON**: Enter or paste JSON data in the left panel
2. **Select Template**: Choose appropriate code style from built-in templates
3. **Custom Names**: Optionally customize class names for generated classes
4. **Generate Code**: Right panel displays generated Dart code in real-time
5. **Copy Code**: Click copy button to copy code to clipboard

## 🛠️ Template Syntax

The application uses Handlebars template syntax, supporting the following variables and helper functions:

### Object-Level Variables
- `{{ obj_name }}`: Object name
- `{{ obj_naming }}`: Object naming
- `{{ obj_custom_name }}`: Custom object name
- `{{ obj_fields_length }}`: Number of fields
- `{{ obj_index }}`: Object index

### Field-Level Variables
- `{{ field_key }}`: Field key name
- `{{ field_type }}`: Field type
- `{{ field_type_name }}`: Field type name
- `{{ field_deser }}`: Deserialization code
- `{{ field_index }}`: Field index

### Helper Functions
- `{{# @pascal_case }}{{/ @pascal_case }}`: Pascal case naming
- `{{# @camel_case }}{{/ @camel_case }}`: Camel case naming
- `{{# @constant_case }}{{/ @constant_case }}`: Constant case naming
- `{{# @snake_case }}{{/ @snake_case }}`: Snake case naming

### Conditional Statements
- `{{# field_nullable }}{{/ field_nullable }}`: Field is nullable
- `{{# field_is_object }}{{/ field_is_object }}`: Field is object
- `{{# field_is_array }}{{/ field_is_array }}`: Field is array
- `{{# field_is_primitive }}{{/ field_is_primitive }}`: Field is primitive type

## 📱 Interface Introduction

### Left Template Panel
- **Built-in Template List**: Display all available built-in templates
- **Custom Templates**: Manage user-created custom templates
- **Template Operations**: View, edit, delete, copy templates
- **New Template**: Create custom templates

### Middle JSON Editor
- **Syntax Highlighting**: JSON syntax highlighting display
- **Code Folding**: Support for code folding of large JSON files
- **Quick Actions**: Format, escape, clear and other action buttons
- **Adjustable Width**: Drag separator to adjust editor width

### Right Code Preview
- **Real-time Generation**: Real-time code generation when JSON input changes
- **Syntax Highlighting**: Dart code syntax highlighting
- **Custom Naming Panel**: Expandable object naming customization panel

### Settings Panel
- **Theme Mode**: Choose light, dark, or follow system
- **Theme Color**: Customize application theme colors
- **Other Configurations**: Various personalization setting options

## 🔧 Technical Features

### Core Technology Stack
- **Flutter**: Cross-platform UI framework
- **jsond_core**: JSON parsing and code generation core library
- **ANTLR4**: JSON5 parser
- **Hive**: Local data storage
- **Mustache**: Template engine
- **Code Builder**: Dart code generation

### Performance Optimization
- **Incremental Parsing**: Parse only changed JSON parts
- **Lazy Rendering**: Chunked rendering of large code blocks
- **Memory Management**: Efficient memory usage strategy

### Data Persistence
- **Template Storage**: Persistent saving of custom templates
- **Settings Storage**: Automatic saving of user preference settings
- **History Records**: JSON input history records (optional)

## 🎯 Use Cases

### API Development
- Quickly convert API responses to Dart models
- Support for parsing complex nested structures
- Automatically generate serialization/deserialization code

### Database Modeling
- Generate models for Hive, Isar and other databases
- Support for relational and document database annotations
- Automatic type conversion handling

### Code Generation Tool Integration
- Integrate with json_serializable, Freezed and other packages
- Support build_runner workflow
- Compatible with existing code generation toolchain

## 🤝 Contributing Guide

We welcome community contributions! Please check the project's contributing guide to learn how to participate.

### Development Environment Setup
```bash
# Install Flutter
# Ensure Flutter SDK version >= 3.32.6

# Clone project
git clone https://github.com/iota9star/json_dart.git
cd json_dart

# Get dependencies
flutter pub get

# Run tests
flutter test
```

## 📄 License

This project uses the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Related Links

- [GitHub Repository](https://github.com/iota9star/json_dart)
- [Issue Reports](https://github.com/iota9star/json_dart/issues)
- [Feature Requests](https://github.com/iota9star/json_dart/discussions)
