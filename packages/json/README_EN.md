# JSON Dart CLI - Command Line Tool + Build Runner (`jsond`)

> 🌐 **Language**: [中文](README.md) | [English](README_EN.md)

A powerful command-line tool and Build Runner integration for batch converting JSON files to Dart model classes. Supports multiple built-in templates and custom templates, making it an essential assistant for Flutter and Dart developers.

## 🌟 Key Features

### 📁 Batch Processing
- **Single File Processing**: Convert specified individual JSON files
- **Directory Batch Processing**: Batch process all JSON files in specified directories
- **Recursive Search**: Support recursive search for JSON files in subdirectories
- **File Type Support**: Support for both `.json` and `.json5` file formats

### 🔧 Build Runner Integration
- **Automatic Building**: Integrate into build_runner workflow
- **File Watching**: Support watch mode, automatically regenerate when files change
- **Flexible Configuration**: Detailed configuration through build.yaml
- **Build-time Generation**: Automatically generate Dart code during project build

### 🎨 Rich Template Selection
- **with_final**: Generate basic models with final modifiers
- **no_final**: Generate models without final modifiers
- **json_serializable**: Models integrated with json_annotation package
- **json_serializable_with_hivece**: Combined with Hive database annotations
- **freezed**: Generate immutable models using Freezed package
- **freezed_with_default**: Freezed models with default values
- **freezed_with_hivece**: Freezed models combined with Hive
- **freezed_with_default_hivece**: Freezed models with default values and Hive annotations
- **isar**: Models supporting Isar database
- **isar_with_json_serializable**: Isar combined with json_annotation
- **isar_with_freezed**: Isar combined with Freezed

### ⚙️ Advanced Configuration
- **Custom Templates**: Support for external Handlebars template files
- **Code Formatting**: Automatically format generated code using dart format
- **Flexible Output**: Automatically generate corresponding `.dart` files

## 🚀 Installation and Usage

### Global Installation
```bash
# Activate globally via pub
dart pub global activate jsond_cli

# Or install locally
dart pub get
dart pub global activate --source path .
```

### Basic Usage
```bash
# Process single file
jsond -p path/to/your/file.json

# Process entire directory
jsond -d path/to/your/json/directory

# Recursively process directory and subdirectories
jsond -d path/to/your/directory -r

# Use specific template
jsond -p file.json -t freezed

# Use custom template
jsond -p file.json -e path/to/custom/template.hbs

# Enable code formatting
jsond -p file.json -f
```

## 📖 Command Line Arguments

### Required Arguments (Choose One)
- `-p, --path <file>`: Specify the JSON file path to process
- `-d, --dir <directory>`: Specify the directory path containing JSON files

### Optional Arguments
- `-t, --template <name>`: Select built-in template (default: with_final)
- `-e, --external-template <file>`: Specify external custom template file path
- `-f, --dart-format`: Format generated code
- `-r, --recursive`: Recursively search subdirectories (only effective when specifying directory)
- `-h, --help`: Display help information

## 💡 Usage Examples

### Example 1: Basic Usage
```bash
# Process single API response file
jsond -p api_response.json -t json_serializable -f

# Output: api_response.json.dart (formatted)
```

### Example 2: Batch Processing
```bash
# Batch process all JSON files in models directory
jsond -d ./models -t freezed -f -r

# Processing results:
# models/user.json -> models/user.json.dart
# models/post.json -> models/post.json.dart
# models/api/response.json -> models/api/response.json.dart
```

### Example 3: Custom Template
```bash
# Process file using custom template
jsond -p data.json -e ./templates/my_template.hbs -f
```

## 🛠️ Custom Templates

### Template Syntax
The CLI tool uses the Handlebars template engine, supporting rich variables and helper functions:

```handlebars
{{# objs }}
class {{# @pascal_case }}{{ obj_naming }}{{/ @pascal_case }} {
  {{# obj_fields }}
  {{# field_nullable }}{{field_type}}?{{/ field_nullable }}{{^ field_nullable }}{{field_type}}{{/ field_nullable }} {{# @camel_case }}{{ field_key }}{{/ @camel_case }};
  {{/ obj_fields }}

  {{# @pascal_case }}{{ obj_naming }}{{/ @pascal_case }}();

  factory {{# @pascal_case }}{{ obj_naming }}{{/ @pascal_case }}.fromJson(Map<String, dynamic> json) {
    return {{# @pascal_case }}{{ obj_naming }}{{/ @pascal_case }}()
    {{# obj_fields }}
      ..{{# @camel_case }}{{ field_key }}{{/ @camel_case }} = {{ field_deser }}{{# field_is_last }};{{/ field_is_last }}{{^ field_is_last }}{{/ field_is_last }}
    {{/ obj_fields }}
  }
}
{{/ objs }}
```

### Available Variables and Helper Functions

#### Object-Level Variables
- `{{ obj_name }}`: Original object name
- `{{ obj_naming }}`: Processed object naming
- `{{ obj_custom_name }}`: Custom object name
- `{{ obj_fields_length }}`: Number of fields
- `{{ obj_index }}`: Object index

#### Field-Level Variables
- `{{ field_key }}`: Field key name
- `{{ field_type }}`: Field Dart type
- `{{ field_type_name }}`: Field type name
- `{{ field_deser }}`: Deserialization expression
- `{{ field_index }}`: Field index

#### Helper Functions
- `{{# @pascal_case }}{{/ @pascal_case }}`: Pascal case naming
- `{{# @camel_case }}{{/ @camel_case }}`: Camel case naming
- `{{# @constant_case }}{{/ @constant_case }}`: Constant case naming
- `{{# @snake_case }}{{/ @snake_case }}`: Snake case naming
- `{{# @header_case }}{{/ @header_case }}`: Header case naming
- `{{# @param_case }}{{/ @param_case }}`: Parameter case naming

#### Conditional Statements
- `{{# field_nullable }}{{/ field_nullable }}`: Whether field is nullable
- `{{# field_is_object }}{{/ field_is_object }}`: Whether field is object
- `{{# field_is_array }}{{/ field_is_array }}`: Whether field is array
- `{{# field_is_primitive }}{{/ field_is_primitive }}`: Whether field is primitive type
- `{{# obj_is_first }}{{/ obj_is_first }}`: Whether is first object
- `{{# obj_is_last }}{{/ obj_is_last }}`: Whether is last object

## 🎯 Typical Workflows

### 1. API Development Workflow
```bash
# Step 1: Get API response and save as JSON
curl https://api.example.com/users > users.json

# Step 2: Generate Dart model
jsond -p users.json -t json_serializable -f

# Step 3: Integrate into project
mv users.json.dart lib/models/
```

### 2. Database Modeling Workflow
```bash
# Generate models for Hive database
jsond -d ./schemas -t json_serializable_with_hivece -f -r

# Generate models for Isar database
jsond -d ./schemas -t isar_with_freezed -f -r
```

### 3. Batch Processing Workflow
```bash
# Process entire project's JSON Schema
jsond -d ./assets/schemas -t freezed -f -r

# Validate generated code
dart analyze lib/models/
```

## 🔧 Build System Integration

### Using build_runner
1. Add dependencies in `pubspec.yaml`:
```yaml
dependencies:
  jsond_core: ^1.0.0

dev_dependencies:
  jsond: ^1.0.0
  build_runner: ^2.3.3
```

2. Create `build.yaml` configuration:
```yaml
targets:
  $default:
    builders:
      jsond:
        enabled: true
        options:
          template: "freezed"
          use_dart_format: true
```

3. Run build:
```bash
dart run build_runner build
```

### Using Makefile
```makefile
# Makefile
.PHONY: models clean

models:
	@echo "Generating Dart models from JSON..."
	@jsond -d ./assets/json -t freezed -f -r
	@echo "Done!"

clean:
	@find . -name "*.json.dart" -type f -delete
	@echo "Cleaned generated files"

rebuild: clean models
```

## 🚀 Performance Features

### Processing Speed
- **Fast Parsing**: High-performance JSON5 parser based on ANTLR4
- **Parallel Processing**: Support for multi-file parallel processing (planned)
- **Incremental Updates**: Process only modified files (planned)

### Memory Optimization
- **Stream Processing**: Stream parsing for large files with low memory usage
- **Smart Caching**: Intelligent caching mechanism to reduce redundant calculations
- **Garbage Collection Friendly**: Optimized memory allocation strategy

## 🐛 Troubleshooting

### Common Issues

#### 1. File Permission Error
```bash
# Ensure read/write permissions
chmod +r input.json
chmod +w output_directory/
```

#### 2. JSON Format Error
```bash
# Use online tools to validate JSON format
# Or use jq for validation
cat your_file.json | jq .
```

#### 3. Template Not Found
```bash
# Check if template name is correct
jsond --help  # View available template list
```

#### 4. Generated Code Has Syntax Errors
```bash
# Enable code formatting
jsond -p file.json -f

# Manually check syntax
dart analyze generated_file.dart
```

## 🔮 Future Plans

### Upcoming Features
- **Configuration File Support**: Support for `jsond.yaml` configuration files
- **Plugin System**: Extensible plugin architecture
- **Incremental Processing**: Smart detection of file changes
- **Parallel Processing**: Multi-file parallel conversion
- **IDE Integration**: VS Code extension support

### Long-term Planning
- **GraphQL Schema Support**: Generate models from GraphQL Schema
- **TypeScript Support**: Generate TypeScript type definitions
- **Multi-language Support**: Support for other programming languages
- **Cloud Service**: Online conversion service

## 🤝 Contributing Guide

We welcome all forms of contribution!

### How to Contribute
1. Fork this repository
2. Create feature branch: `git checkout -b feature/my-new-feature`
3. Commit changes: `git commit -am 'Add some feature'`
4. Push to branch: `git push origin feature/my-new-feature`
5. Submit Pull Request

### Development Environment Setup
```bash
# Clone repository
git clone https://github.com/iota9star/json_dart.git
cd json_dart/packages/json

# Install dependencies
dart pub get

# Run tests
dart test

# Build executable
dart compile exe bin/main.dart -o jsond
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](../../LICENSE) file for details.

## 🔗 Related Links

- [Main Project Repository](https://github.com/iota9star/json_dart)
- [Flutter Application Documentation](../jsond/README_EN.md)
- [Core Library Documentation](../core/README_EN.md)
- [Issue Reports](https://github.com/iota9star/json_dart/issues)
- [Discussions](https://github.com/iota9star/json_dart/discussions)
