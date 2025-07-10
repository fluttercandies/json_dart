# JSON Dart Core - Core Library (`jsond_core`)

> 🌐 **Language**: [中文](README.md) | [English](README_EN.md)

The core library of the JSON Dart project, providing underlying functionality for JSON to Dart code generation. This library uses an ANTLR4 parser to support JSON5 format and generates high-quality Dart code through the Mustache template engine.

## 🌟 Key Features

### 🔍 Powerful Parsing Capabilities
- **JSON5 Support**: Complete JSON5 parser based on ANTLR4
- **Type Inference**: Intelligent inference of Dart types from JSON data
- **Nested Structures**: Perfect handling of complex nested objects and arrays
- **Null Handling**: Smart recognition of nullable fields

### 🎨 Flexible Code Generation
- **Template Engine**: Powerful template system based on Mustache
- **Multiple Templates**: Built-in multiple mainstream code generation templates
- **Custom Templates**: Support for fully customized code generation templates
- **Code Formatting**: Integrated dart_style for code beautification

### 🏗️ Robust Architecture
- **Type Safety**: Complete type system and type checking
- **Error Handling**: Detailed error messages and exception handling
- **Extensibility**: Modular design, easy to extend with new features
- **Performance Optimization**: Efficient parsing and generation algorithms

## 🚀 Quick Start

### Install Dependencies
```yaml
dependencies:
  jsond_core: ^1.0.0
```

### Basic Usage
```dart
import 'package:jsond_core/jsond_core.dart';

void main() {
  // JSON string
  const jsonString = '''
  {
    "name": "John Doe",
    "age": 30,
    "email": "john@example.com",
    "address": {
      "street": "123 Main St",
      "city": "New York"
    },
    "hobbies": ["reading", "swimming"]
  }
  ''';

  // Parse JSON and generate Dart code
  final def = JSONDef.fromString(jsonString);
  final dartCode = render(
    jsonString,
    withFinal, // Use built-in template
    dartFormat: true
  );

  print(dartCode);
}
```

### Reading from File
```dart
import 'package:jsond_core/jsond_core.dart';

Future<void> generateFromFile() async {
  // Read and parse from file
  final def = await JSONDef.fromPath('data.json');

  // Generate code
  final code = render(
    def.type.display,
    freezed, // Use Freezed template
    dartFormat: true,
  );

  // Save to file
  await File('models.dart').writeAsString(code);
}
```

## 📚 API Documentation

### Core Classes

#### JSONDef
The main class for JSON definition, responsible for parsing and type inference.

```dart
class JSONDef {
  // Create from string
  factory JSONDef.fromString(String json, {Map<String, String> symbols = builtInSymbols});

  // Create from file
  static Future<JSONDef> fromPath(String path, {Map<String, String> symbols = builtInSymbols});

  // Convert to template data
  Map<String, dynamic> toJson({Map<String, String> symbols = builtInSymbols});

  // Update object name
  void updateObjName(ObjKey key, String name);

  // Properties
  JSONType get type;           // Root type
  List<JSONObj> get objs;      // All objects
}
```

#### JSONType
Abstract class representing JSON data types.

```dart
abstract class JSONType {
  String get display;          // Display string
  String get dartType;         // Dart type
  bool get nullable;           // Whether nullable
  bool get isObject;          // Whether is object
  bool get isArray;           // Whether is array
  bool get isPrimitive;       // Whether is primitive type
}
```

#### JSONObj
Class representing JSON objects.

```dart
class JSONObj {
  ObjKey get key;             // Object key
  String get name;            // Object name
  List<JSONField> get fields; // Field list

  // Get custom name
  String naming({Map<String, String> symbols = builtInSymbols});
}
```

#### JSONField
Class representing JSON fields.

```dart
class JSONField {
  String get key;             // Field key
  JSONType get type;          // Field type
  bool get nullable;          // Whether nullable

  // Generate deserialization code
  String generateDeserializationCode();
}
```

### Rendering Functions

#### render
Main code generation function.

```dart
String render(
  String json,                    // JSON string
  String template,                // Template string
  {
    Set<String> keywords = builtInDartKeywords,
    Map<String, String> symbols = builtInSymbols,
    bool dartFormat = false,      // Whether to format code
  }
);
```

#### renderObjs
Render code directly from object data.

```dart
String renderObjs(
  String template,                // Template string
  Map<String, dynamic> data,      // Template data
  {
    Set<String> keywords = builtInDartKeywords,
  }
);
```

### Built-in Templates

The library provides multiple built-in templates:

```dart
// Basic templates
const String withFinal;         // With final modifiers
const String noFinal;           // Without final modifiers

// Json Serializable templates
const String jsonSerializable;
const String jsonSerializableWithHiveCE;

// Freezed templates
const String freezed;
const String freezedWithDefault;
const String freezedWithHiveCE;
const String freezedWithDefaultAndHiveCE;

// Isar templates
const String isar;
const String isarWithJsonSerializable;
const String isarWithFreezed;
```

### Template Syntax

#### Basic Variables
```handlebars
{{# objs }}
  Class name: {{ obj_name }}
  Custom name: {{ obj_custom_name }}
  Field count: {{ obj_fields_length }}

  {{# obj_fields }}
    Field name: {{ field_key }}
    Field type: {{ field_type }}
    Deserialization: {{ field_deser }}
  {{/ obj_fields }}
{{/ objs }}
```

#### Helper Functions
```handlebars
{{# @pascal_case }}{{ obj_name }}{{/ @pascal_case }}     // PascalCase
{{# @camel_case }}{{ field_key }}{{/ @camel_case }}      // camelCase
{{# @snake_case }}{{ field_key }}{{/ @snake_case }}      // snake_case
{{# @constant_case }}{{ field_key }}{{/ @constant_case }} // CONSTANT_CASE
```

#### Conditional Statements
```handlebars
{{# field_nullable }}
  // Handling when field is nullable
  {{ field_type }}? {{ field_key }};
{{/ field_nullable }}

{{^ field_nullable }}
  // Handling when field is not nullable
  {{ field_type }} {{ field_key }};
{{/ field_nullable }}

{{# field_is_object }}
  // Handling when field is object
{{/ field_is_object }}

{{# field_is_array }}
  // Handling when field is array
{{/ field_is_array }}
```

### Type System

#### Basic Type Mapping
```dart
// JSON -> Dart type mapping
String    -> String
int       -> int
double    -> double
bool      -> bool
null      -> dynamic
```

#### Complex Type Handling
```dart
// Object types
{"key": "value"} -> CustomClass

// Array types
[1, 2, 3] -> List<int>
[{"key": "value"}] -> List<CustomClass>

// Mixed arrays
[1, "str", true] -> List<dynamic>

// Nullable types
{"key": null} -> String? key
```

## 🛠️ Advanced Usage

### Custom Symbol Table
```dart
final customSymbols = {
  r'$': 'Dollar',
  '@': 'At',
  '#': 'Hash',
  ...builtInSymbols,
};

final def = JSONDef.fromString(
  jsonString,
  symbols: customSymbols,
);
```

### Custom Keyword Filtering
```dart
final customKeywords = {
  'class',
  'const',
  'final',
  ...builtInDartKeywords,
};

final code = render(
  jsonString,
  template,
  keywords: customKeywords,
);
```

### Custom Templates
```dart
const customTemplate = '''
{{# objs }}
// Custom template example
class {{# @pascal_case }}{{ obj_name }}{{/ @pascal_case }} {
  {{# obj_fields }}
  final {{ field_type }} {{# @camel_case }}{{ field_key }}{{/ @camel_case }};
  {{/ obj_fields }}

  const {{# @pascal_case }}{{ obj_name }}{{/ @pascal_case }}({
    {{# obj_fields }}
    required this.{{# @camel_case }}{{ field_key }}{{/ @camel_case }},
    {{/ obj_fields }}
  });

  factory {{# @pascal_case }}{{ obj_name }}{{/ @pascal_case }}.fromJson(Map<String, dynamic> json) {
    return {{# @pascal_case }}{{ obj_name }}{{/ @pascal_case }}(
      {{# obj_fields }}
      {{# @camel_case }}{{ field_key }}{{/ @camel_case }}: {{ field_deser }},
      {{/ obj_fields }}
    );
  }
}
{{/ objs }}
''';

final code = render(jsonString, customTemplate, dartFormat: true);
```

### Batch Processing
```dart
Future<void> batchProcess() async {
  final jsonFiles = Directory('json_files')
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('.json'));

  for (final file in jsonFiles) {
    final content = await file.readAsString();
    final code = render(content, freezed, dartFormat: true);

    final outputPath = file.path
        .replaceAll('.json', '.dart')
        .replaceAll('json_files', 'lib/models');

    await File(outputPath).writeAsString(code);
  }
}
```

## 🎯 Real-World Examples

### REST API Model Generation
```dart
// API response JSON
const apiResponse = '''
{
  "status": "success",
  "data": {
    "users": [
      {
        "id": 1,
        "name": "John Doe",
        "email": "john@example.com",
        "profile": {
          "avatar": "https://example.com/avatar.jpg",
          "bio": "Software Developer"
        }
      }
    ],
    "pagination": {
      "page": 1,
      "limit": 10,
      "total": 100
    }
  }
}
''';

// Generate JsonSerializable model
final code = render(apiResponse, jsonSerializable, dartFormat: true);
```

### Database Model Generation
```dart
// Database record JSON
const dbRecord = '''
{
  "id": "uuid-string",
  "createdAt": "2023-01-01T00:00:00Z",
  "updatedAt": "2023-01-01T00:00:00Z",
  "data": {
    "title": "Example",
    "content": "Content here",
    "tags": ["tag1", "tag2"]
  }
}
''';

// Generate Hive model
final code = render(dbRecord, jsonSerializableWithHiveCE, dartFormat: true);
```

### Configuration File Model Generation
```dart
// Configuration file JSON
const config = '''
{
  "app": {
    "name": "My App",
    "version": "1.0.0",
    "debug": true
  },
  "database": {
    "host": "localhost",
    "port": 5432,
    "name": "myapp_db"
  },
  "features": {
    "auth": true,
    "analytics": false,
    "experimental": ["feature1", "feature2"]
  }
}
''';

// Generate immutable configuration model
final code = render(config, freezed, dartFormat: true);
```

## 🔧 Tool Integration

### VS Code Integration
You can create VS Code tasks to automate code generation:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Generate Models",
      "type": "shell",
      "command": "dart",
      "args": ["run", "jsond:generate"],
      "group": "build",
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "shared"
      }
    }
  ]
}
```

### Build Runner Integration
```yaml
# build.yaml
targets:
  $default:
    builders:
      jsond:
        enabled: true
        options:
          template: "freezed"
          use_dart_format: true
```

### Custom Build Script
```dart
// tool/generate_models.dart
import 'dart:io';
import 'package:jsond_core/jsond_core.dart';

Future<void> main() async {
  final inputDir = Directory('assets/json');
  final outputDir = Directory('lib/models');

  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }

  await for (final entity in inputDir.list()) {
    if (entity is File && entity.path.endsWith('.json')) {
      final content = await entity.readAsString();
      final code = render(content, freezed, dartFormat: true);

      final outputFile = File(
        '${outputDir.path}/${entity.uri.pathSegments.last}'
            .replaceAll('.json', '.dart')
      );

      await outputFile.writeAsString(code);
      print('Generated: ${outputFile.path}');
    }
  }
}
```

## 🚀 Performance Optimization

### Parsing Performance
- **ANTLR4 Optimization**: Uses high-performance ANTLR4 parser
- **Incremental Parsing**: Support for incremental parsing of large JSON files
- **Memory Management**: Optimized memory usage strategy

### Generation Performance
- **Template Caching**: Smart caching of compiled templates
- **Parallel Processing**: Support for multi-file parallel processing
- **Code Optimization**: Generated code is optimized

### Benchmarking
```dart
// Performance testing example
void benchmarkParsing() {
  final stopwatch = Stopwatch()..start();

  for (int i = 0; i < 1000; i++) {
    JSONDef.fromString(complexJsonString);
  }

  stopwatch.stop();
  print('1000 parses took: ${stopwatch.elapsedMilliseconds}ms');
}
```

## 🧪 Testing

### Unit Tests
```dart
import 'package:test/test.dart';
import 'package:jsond_core/jsond_core.dart';

void main() {
  group('JSONDef Tests', () {
    test('should parse simple JSON', () {
      const json = '{"name": "test", "value": 42}';
      final def = JSONDef.fromString(json);

      expect(def.objs.length, equals(1));
      expect(def.objs.first.fields.length, equals(2));
    });

    test('should generate correct Dart code', () {
      const json = '{"name": "test"}';
      final code = render(json, withFinal, dartFormat: true);

      expect(code, contains('class Obj'));
      expect(code, contains('final String name;'));
    });
  });
}
```

### Integration Tests
```dart
void main() {
  group('Integration Tests', () {
    test('should handle complex nested structures', () {
      final json = File('test/fixtures/complex.json').readAsStringSync();
      final code = render(json, freezed, dartFormat: true);

      // Verify generated code passes Dart analyzer
      expect(code, isValidDartCode);
    });
  });
}
```

## 📊 Monitoring and Debugging

### Logging
```dart
import 'package:jsond_core/jsond_core.dart';

void main() {
  // Enable debug logging
  Logger.level = LogLevel.debug;

  const json = '{"test": "value"}';
  json.$debug(tag: 'INPUT');

  final def = JSONDef.fromString(json);
  def.toString().$info(tag: 'PARSED');

  final code = render(json, withFinal);
  code.$debug(tag: 'GENERATED');
}
```

### Error Handling
```dart
try {
  final def = JSONDef.fromString(invalidJson);
} on JSONParseException catch (e) {
  print('JSON parse error: ${e.message}');
  print('Location: Line ${e.line}, Column ${e.column}');
} on TemplateException catch (e) {
  print('Template error: ${e.message}');
} catch (e) {
  print('Unknown error: $e');
}
```

## 🤝 Contributing Guide

### Development Environment Setup
```bash
# Clone project
git clone https://github.com/iota9star/json_dart.git
cd json_dart/packages/core

# Install dependencies
dart pub get

# Run tests
dart test

# Run examples
dart run example/main.dart
```

### Adding New Templates
1. Add template constants in `lib/src/templates.dart`
2. Add corresponding test cases in tests
3. Update documentation and examples

### Contribution Process
1. Fork the project
2. Create feature branch
3. Write tests
4. Implement features
5. Submit PR

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](../../LICENSE) file for details.

## 🔗 Related Resources

- [ANTLR4 Documentation](https://github.com/antlr/antlr4)
- [Mustache Template Syntax](https://mustache.github.io/mustache.5.html)
- [JSON5 Specification](https://json5.org/)
- [Dart Language Specification](https://dart.dev/guides/language/language-tour)
