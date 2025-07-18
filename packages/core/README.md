# JSON Dart Core - 核心库 (`jsond_core`)

> 🌐 **语言版本**: [中文](README.md) | [English](README_EN.md)

JSON Dart 项目的核心库，提供 JSON 到 Dart 代码生成的底层功能。该库使用 ANTLR4 解析器支持 JSON5 格式，并通过 Mustache 模板引擎生成高质量的 Dart 代码。

## 🌟 主要功能

### 🔍 强大的解析能力
- **JSON5 支持**: 基于 ANTLR4 的完整 JSON5 解析器
- **类型推断**: 智能推断 JSON 数据的 Dart 类型
- **嵌套结构**: 完美处理复杂嵌套对象和数组
- **空值处理**: 智能识别可空字段

### 🎨 灵活的代码生成
- **模板引擎**: 基于 Mustache 的强大模板系统
- **多种模板**: 内置多种主流代码生成模板
- **自定义模板**: 支持完全自定义的代码生成模板
- **代码格式化**: 集成 dart_style 进行代码美化

### 🏗️ 健壮的架构
- **类型安全**: 完整的类型系统和类型检查
- **错误处理**: 详细的错误信息和异常处理
- **扩展性**: 模块化设计，易于扩展新功能
- **性能优化**: 高效的解析和生成算法

## 🚀 快速开始

### 安装依赖
```yaml
dependencies:
  jsond_core: ^1.0.0
```

### 基本用法
```dart
import 'package:jsond_core/jsond_core.dart';

void main() {
  // JSON 字符串
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

  // 解析 JSON 并生成 Dart 代码
  final def = JSONDef.fromString(jsonString);
  final dartCode = render(
    jsonString,
    withFinal, // 使用内置模板
    dartFormat: true
  );

  print(dartCode);
}
```

### 从文件读取
```dart
import 'package:jsond_core/jsond_core.dart';

Future<void> generateFromFile() async {
  // 从文件读取并解析
  final def = await JSONDef.fromPath('data.json');

  // 生成代码
  final code = render(
    def.type.display,
    freezed, // 使用 Freezed 模板
    dartFormat: true,
  );

  // 保存到文件
  await File('models.dart').writeAsString(code);
}
```

## 📚 API 文档

### 核心类

#### JSONDef
JSON 定义的主要类，负责解析和类型推断。

```dart
class JSONDef {
  // 从字符串创建
  factory JSONDef.fromString(String json, {Map<String, String> symbols = builtInSymbols});

  // 从文件创建
  static Future<JSONDef> fromPath(String path, {Map<String, String> symbols = builtInSymbols});

  // 转换为模板数据
  Map<String, dynamic> toJson({Map<String, String> symbols = builtInSymbols});

  // 更新对象名称
  void updateObjName(ObjKey key, String name);

  // 属性
  JSONType get type;           // 根类型
  List<JSONObj> get objs;      // 所有对象
}
```

#### JSONType
表示 JSON 数据类型的抽象类。

```dart
abstract class JSONType {
  String get display;          // 显示字符串
  String get dartType;         // Dart 类型
  bool get nullable;           // 是否可空
  bool get isObject;          // 是否为对象
  bool get isArray;           // 是否为数组
  bool get isPrimitive;       // 是否为基础类型
}
```

#### JSONObj
表示 JSON 对象的类。

```dart
class JSONObj {
  ObjKey get key;             // 对象键
  String get name;            // 对象名称
  List<JSONField> get fields; // 字段列表

  // 获取自定义名称
  String naming({Map<String, String> symbols = builtInSymbols});
}
```

#### JSONField
表示 JSON 字段的类。

```dart
class JSONField {
  String get key;             // 字段键
  JSONType get type;          // 字段类型
  bool get nullable;          // 是否可空

  // 生成反序列化代码
  String generateDeserializationCode();
}
```

### 渲染函数

#### render
主要的代码生成函数。

```dart
String render(
  String json,                    // JSON 字符串
  String template,                // 模板字符串
  {
    Set<String> keywords = builtInDartKeywords,
    Map<String, String> symbols = builtInSymbols,
    bool dartFormat = false,      // 是否格式化代码
  }
);
```

#### renderObjs
直接从对象数据渲染代码。

```dart
String renderObjs(
  String template,                // 模板字符串
  Map<String, dynamic> data,      // 模板数据
  {
    Set<String> keywords = builtInDartKeywords,
  }
);
```

### 内置模板

库提供了多种内置模板：

```dart
// 基础模板
const String withFinal;         // 带 final 修饰符
const String noFinal;           // 不带 final 修饰符

// Json Serializable 模板
const String jsonSerializable;
const String jsonSerializableWithHiveCE;

// Freezed 模板
const String freezed;
const String freezedWithDefault;
const String freezedWithHiveCE;
const String freezedWithDefaultAndHiveCE;

// Isar 模板
const String isar;
const String isarWithJsonSerializable;
const String isarWithFreezed;
```

### 模板语法

#### 基本变量
```handlebars
{{# objs }}
  类名: {{ obj_name }}
  自定义名称: {{ obj_custom_name }}
  字段数量: {{ obj_fields_length }}

  {{# obj_fields }}
    字段名: {{ field_key }}
    字段类型: {{ field_type }}
    反序列化: {{ field_deser }}
  {{/ obj_fields }}
{{/ objs }}
```

#### 助手函数
```handlebars
{{# @pascal_case }}{{ obj_name }}{{/ @pascal_case }}     // PascalCase
{{# @camel_case }}{{ field_key }}{{/ @camel_case }}      // camelCase
{{# @snake_case }}{{ field_key }}{{/ @snake_case }}      // snake_case
{{# @constant_case }}{{ field_key }}{{/ @constant_case }} // CONSTANT_CASE
```

#### 条件判断
```handlebars
{{# field_nullable }}
  // 字段可空时的处理
  {{ field_type }}? {{ field_key }};
{{/ field_nullable }}

{{^ field_nullable }}
  // 字段不可空时的处理
  {{ field_type }} {{ field_key }};
{{/ field_nullable }}

{{# field_is_object }}
  // 字段是对象时的处理
{{/ field_is_object }}

{{# field_is_array }}
  // 字段是数组时的处理
{{/ field_is_array }}
```

### 类型系统

#### 基础类型映射
```dart
// JSON -> Dart 类型映射
String    -> String
int       -> int
double    -> double
bool      -> bool
null      -> dynamic
```

#### 复杂类型处理
```dart
// 对象类型
{"key": "value"} -> CustomClass

// 数组类型
[1, 2, 3] -> List<int>
[{"key": "value"}] -> List<CustomClass>

// 混合数组
[1, "str", true] -> List<dynamic>

// 可空类型
{"key": null} -> String? key
```

## 🛠️ 高级用法

### 自定义符号表
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

### 自定义关键字过滤
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

### 自定义模板
```dart
const customTemplate = '''
{{# objs }}
// 自定义模板示例
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

### 批量处理
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

## 🎯 实际应用示例

### REST API 模型生成
```dart
// API 响应 JSON
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

// 生成 JsonSerializable 模型
final code = render(apiResponse, jsonSerializable, dartFormat: true);
```

### 数据库模型生成
```dart
// 数据库记录 JSON
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

// 生成 Hive 模型
final code = render(dbRecord, jsonSerializableWithHiveCE, dartFormat: true);
```

### 配置文件模型生成
```dart
// 配置文件 JSON
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

// 生成不可变配置模型
final code = render(config, freezed, dartFormat: true);
```

## 🔧 工具集成

### VS Code 集成
可以创建 VS Code 任务来自动化代码生成：

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Generate Models",
      "type": "shell",
      "command": "dart",
      "args": ["run", "build_runner", "build"],
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

### Build Runner 集成
```yaml
# pubspec.yaml
dev_dependencies:
  jsond: ^1.0.0
  build_runner: ^2.3.3

# build.yaml
targets:
  $default:
    builders:
      jsond:json:
        enabled: true
        options:
          template: "freezed"
          use_dart_format: true
```

### 自定义构建脚本
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

## 🚀 性能优化

### 解析性能
- **ANTLR4 优化**: 使用高性能的 ANTLR4 解析器
- **增量解析**: 支持增量解析大型 JSON 文件
- **内存管理**: 优化的内存使用策略

### 生成性能
- **模板缓存**: 智能缓存编译后的模板
- **并行处理**: 支持多文件并行处理
- **代码优化**: 生成的代码经过优化

### 基准测试
```dart
// 性能测试示例
void benchmarkParsing() {
  final stopwatch = Stopwatch()..start();

  for (int i = 0; i < 1000; i++) {
    JSONDef.fromString(complexJsonString);
  }

  stopwatch.stop();
  print('1000 次解析耗时: ${stopwatch.elapsedMilliseconds}ms');
}
```

## 🧪 测试

### 单元测试
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

### 集成测试
```dart
void main() {
  group('Integration Tests', () {
    test('should handle complex nested structures', () {
      final json = File('test/fixtures/complex.json').readAsStringSync();
      final code = render(json, freezed, dartFormat: true);

      // 验证生成的代码能够通过 Dart 分析器
      expect(code, isValidDartCode);
    });
  });
}
```

## 📊 监控和调试

### 日志记录
```dart
import 'package:jsond_core/jsond_core.dart';

void main() {
  // 启用调试日志
  Logger.level = LogLevel.debug;

  const json = '{"test": "value"}';
  json.$debug(tag: 'INPUT');

  final def = JSONDef.fromString(json);
  def.toString().$info(tag: 'PARSED');

  final code = render(json, withFinal);
  code.$debug(tag: 'GENERATED');
}
```

### 错误处理
```dart
try {
  final def = JSONDef.fromString(invalidJson);
} on JSONParseException catch (e) {
  print('JSON 解析错误: ${e.message}');
  print('位置: 第 ${e.line} 行，第 ${e.column} 列');
} on TemplateException catch (e) {
  print('模板错误: ${e.message}');
} catch (e) {
  print('未知错误: $e');
}
```

## 🤝 贡献指南

### 开发环境设置
```bash
# 克隆项目
git clone https://github.com/iota9star/json_dart.git
cd json_dart/packages/core

# 安装依赖
dart pub get

# 运行测试
dart test

# 运行示例
dart run example/main.dart
```

### 添加新模板
1. 在 `lib/src/templates.dart` 中添加模板常量
2. 在测试中添加对应的测试用例
3. 更新文档和示例

### 贡献流程
1. Fork 项目
2. 创建功能分支
3. 编写测试
4. 实现功能
5. 提交 PR

## 📄 许可证

本项目使用 MIT 许可证 - 查看 [LICENSE](../../LICENSE) 文件了解详情。

## 🔗 相关资源

- [ANTLR4 文档](https://github.com/antlr/antlr4)
- [Mustache 模板语法](https://mustache.github.io/mustache.5.html)
- [JSON5 规范](https://json5.org/)
- [Dart 语言规范](https://dart.dev/guides/language/language-tour)
