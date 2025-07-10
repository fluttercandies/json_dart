# JSON Dart - 完整的 JSON 到 Dart 代码生成解决方案

> 🌐 **语言版本**: [中文](README.md) | [English](README_EN.md)

<p align="center">
  <img src="apps/jsond/assets/JSON.png" width="120" alt="JSON Dart Logo">
</p>

<p align="center">
  <strong>🚀 强大、灵活、易用的 JSON 到 Dart 代码生成工具套件</strong>
</p>

<p align="center">
  <a href="https://github.com/iota9star/json_dart/releases"><img src="https://img.shields.io/github/v/release/iota9star/json_dart" alt="Release"></a>
  <a href="https://github.com/iota9star/json_dart/blob/main/LICENSE"><img src="https://img.shields.io/github/license/iota9star/json_dart" alt="License"></a>
  <a href="https://github.com/iota9star/json_dart/stargazers"><img src="https://img.shields.io/github/stars/iota9star/json_dart" alt="Stars"></a>
  <a href="https://github.com/iota9star/json_dart/issues"><img src="https://img.shields.io/github/issues/iota9star/json_dart" alt="Issues"></a>
</p>

## 📖 项目简介

JSON Dart 是一个完整的工具套件，旨在简化 Flutter 和 Dart 开发中从 JSON 数据生成 Dart 模型类的过程。无论您是在处理 REST API 响应、配置文件，还是数据库记录，JSON Dart 都能为您提供高效、灵活的解决方案。

### 🎯 核心优势

- **🎨 多样化模板**: 支持 JsonSerializable、Freezed、Hive、Isar 等主流代码生成框架
- **🖥️ 跨平台支持**: 提供 Flutter GUI 应用和命令行工具
- **⚡ 高性能解析**: 基于 ANTLR4 的 JSON5 解析器，支持复杂数据结构
- **🛠️ 高度可定制**: 支持自定义模板和完全可配置的代码生成规则
- **📱 现代化 UI**: 精美的 Material Design 3 界面，支持主题定制

## 🏗️ 项目架构

本项目采用 monorepo 架构，包含以下组件：

```
json_dart/
├── 📱 apps/
│   └── jsond/                 # Flutter GUI 应用 (jsond_app)
├── 📦 packages/
│   ├── core/                  # 核心解析和生成库 (jsond_core)
│   └── json/                  # 命令行工具 + Build Runner (jsond)
└── 🛠️ scripts/               # 构建和工具脚本
```

### 组件说明

| 组件 | 包名 | 描述 | 技术栈 | 用途 |
|------|------|------|--------|------|
| **JSON Dart App** | `jsond_app` | 跨平台 GUI 应用 | Flutter, Material 3 | 可视化 JSON 到 Dart 转换 |
| **JSON Dart CLI** | `jsond` | 命令行工具 + Build Runner | Dart, Build | 批量处理、CI/CD 集成、构建时代码生成 |
| **JSON Dart Core** | `jsond_core` | 核心库 | Dart, ANTLR4, Mustache | 解析引擎和代码生成 |

## 🚀 快速开始

### 📋 环境要求

- **Flutter**: >= 3.32.6
- **Dart**: >= 2.18.0
- **操作系统**: Windows, macOS, Linux

### 🛠️ 安装方式

#### 方式一：使用 Flutter GUI 应用

```bash
# 克隆项目
git clone https://github.com/iota9star/json_dart.git
cd json_dart

# 安装依赖
flutter pub get

# 运行应用
flutter run
```

#### 方式二：安装命令行工具

```bash
# 全局安装 CLI 工具
dart pub global activate jsond

# 使用 CLI 工具
jsond -p example.json -t freezed -f
```

#### 方式三：作为库依赖

```yaml
# pubspec.yaml
dependencies:
  jsond_core: ^1.0.0

dev_dependencies:
  jsond: ^1.0.0
  build_runner: ^2.3.3
```

#### 方式四：集成到 Build Runner

```yaml
# pubspec.yaml
dev_dependencies:
  jsond: ^1.0.0
  build_runner: ^2.3.3

# build.yaml (可选配置)
targets:
  $default:
    builders:
      jsond:json:
        options:
          template: "freezed"
          use_dart_format: true
```

### 🎯 基本用法

#### GUI 应用使用
1. 启动 Flutter 应用
2. 在左侧 JSON 编辑器中输入 JSON 数据
3. 从模板列表中选择合适的代码生成模板
4. 在右侧查看生成的 Dart 代码
5. 点击复制按钮获取代码

#### CLI 工具使用
```bash
# 处理单个文件
jsond -p data.json -t json_serializable -f

# 批量处理目录
jsond -d ./json_files -t freezed -f -r

# 使用自定义模板
jsond -p data.json -e custom_template.hbs -f
```

#### Build Runner 使用
```bash
# 将 JSON 文件放在项目中（如 assets/json/）
# 运行构建生成 Dart 代码
dart run build_runner build

# 监听模式（开发时使用）
dart run build_runner watch
```

#### 程序库使用
```dart
import 'package:jsond_core/jsond_core.dart';

void main() {
  const json = '{"name": "John", "age": 30}';
  final dartCode = render(json, freezed, dartFormat: true);
  print(dartCode);
}
```

## 🎨 支持的模板

### 📝 基础模板
- **With Final**: 生成带 `final` 修饰符的基础模型
- **No Final**: 生成可变字段的基础模型

### 🔄 序列化模板
- **JsonSerializable**: 使用 `json_annotation` 包
- **JsonSerializable + HiveCE**: 结合 Hive 数据库注解

### ❄️ 不可变模板
- **Freezed**: 基础 Freezed 不可变模型
- **Freezed + Default**: 带默认值的 Freezed 模型
- **Freezed + HiveCE**: 结合 Hive 的 Freezed 模型
- **Unfreezed**: 可变的 Freezed 风格模型

### 🗃️ 数据库模板
- **Isar**: 专为 Isar 数据库设计
- **Isar + JsonSerializable**: Isar 与序列化结合
- **Isar + Freezed**: Isar 与不可变模型结合

## 💡 功能特性

### 🔍 强大的解析能力
- **JSON5 支持**: 完整支持 JSON5 格式（注释、尾随逗号等）
- **类型推断**: 智能推断 Dart 数据类型
- **嵌套结构**: 完美处理复杂嵌套对象和数组
- **空值处理**: 智能识别可空字段和联合类型

### 🎛️ 灵活的配置
- **自定义模板**: 支持 Handlebars 语法的完全自定义模板
- **命名规则**: 支持多种命名约定（camelCase、PascalCase、snake_case 等）
- **关键字处理**: 自动处理 Dart 关键字冲突
- **代码格式化**: 集成 `dart format` 自动格式化

### 🖥️ 用户体验
- **实时预览**: JSON 输入时实时生成 Dart 代码
- **错误提示**: 详细的 JSON 语法错误信息
- **主题定制**: 支持明亮/暗黑主题和自定义配色
- **快捷操作**: 丰富的快捷键和工具栏操作

### 🔧 开发者友好
- **批量处理**: CLI 工具支持批量转换多个文件
- **CI/CD 集成**: 完美适配持续集成工作流
- **Build Runner**: 支持 build_runner 集成
- **插件系统**: 可扩展的插件架构（规划中）

## 📚 详细文档

### 语言版本
- 🇨🇳 [中文文档](README.md) (当前文档)
- 🇺🇸 [English Documentation](README_EN.md)

### 组件文档
- 📱 [Flutter 应用文档](apps/jsond/README.md) | [English](apps/jsond/README_EN.md) - GUI 应用完整使用指南
- 💻 [CLI 工具文档](packages/json/README.md) | [English](packages/json/README_EN.md) - 命令行工具详细说明
- 🔧 [核心库文档](packages/core/README.md) | [English](packages/core/README_EN.md) - API 参考和高级用法

### 技术指南
- 📋 [项目问题分析](PROJECT_ISSUES.md) - 代码质量分析和修复建议
- 🎯 [发布日志](CHANGELOG.md) - 版本更新记录
- 🔧 [开发指南](CONTRIBUTING.md) - 详细的开发和贡献指南

## 🎯 使用场景

### 🌐 API 开发
```bash
# 从 API 响应快速生成模型
curl https://api.example.com/users | jsond -t json_serializable -f > lib/models/user.dart
```

### 🗄️ 数据库建模
```dart
// 为 Hive 数据库生成类型安全的模型
final code = render(schemaJson, jsonSerializableWithHiveCE, dartFormat: true);
```

### ⚙️ 配置管理
```dart
// 将配置文件转换为类型安全的 Dart 类
final configModel = render(configJson, freezed, dartFormat: true);
```

### 🔄 代码生成工作流
```yaml
# build.yaml - 集成到 build_runner 工作流
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
# 项目结构示例
lib/
  models/
    user.json          # JSON 数据文件
    user.json.dart     # 自动生成的 Dart 代码

# 构建命令
dart run build_runner build --delete-conflicting-outputs
```

## 🎨 模板示例

### 基础模板输出
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

### Freezed 模板输出
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

## 🛣️ 发展路线图

### 🎯 近期目标 (v1.0)
- [ ] **配置文件支持**: `jsond.yaml` 配置文件
- [ ] **增量处理**: 智能检测文件变化，增量更新
- [ ] **并行处理**: 多文件并行转换支持
- [ ] **插件系统**: 可扩展的插件架构

### 🚀 中期目标 (v1.5)
- [ ] **GraphQL 支持**: 从 GraphQL Schema 生成模型
- [ ] **TypeScript 支持**: 生成 TypeScript 类型定义
- [ ] **IDE 扩展**: VS Code 和 IntelliJ 插件
- [ ] **云端服务**: 在线转换服务

### 🌟 长期愿景 (v2.0)
- [ ] **多语言支持**: 支持更多编程语言
- [ ] **AI 辅助**: 智能模板推荐和代码优化
- [ ] **团队协作**: 模板共享和版本控制
- [ ] **性能分析**: 代码性能分析和优化建议

## 📊 性能基准

### 解析性能
| JSON 大小 | 解析时间 | 内存占用 |
|-----------|----------|----------|
| 1KB       | < 1ms    | < 1MB    |
| 100KB     | < 50ms   | < 10MB   |
| 1MB       | < 500ms  | < 50MB   |

### 生成性能
| 对象数量 | 生成时间 | 代码行数 |
|----------|----------|----------|
| 1-10     | < 10ms   | 50-500   |
| 11-100   | < 100ms  | 500-5K   |
| 100+     | < 1s     | 5K+      |

## 🤝 贡献指南

我们热烈欢迎社区贡献！无论是 bug 报告、功能请求、代码贡献还是文档改进，都非常感谢。

### 🛠️ 开发环境设置

```bash
# 1. Fork 并克隆项目
git clone https://github.com/YOUR_USERNAME/json_dart.git
cd json_dart

# 2. 安装依赖
flutter pub get

# 3. 运行测试
flutter test

# 4. 创建功能分支
git checkout -b feature/amazing-feature

# 5. 提交更改
git commit -m "feat: add amazing feature"

# 6. 推送分支
git push origin feature/amazing-feature

# 7. 创建 Pull Request
```

### 📝 贡献类型

#### 🐛 Bug 报告
发现 bug？请创建 [Issue](https://github.com/iota9star/json_dart/issues) 并包含：
- 详细的重现步骤
- 期望行为和实际行为
- 环境信息（操作系统、Flutter 版本等）
- 相关的错误日志

#### 💡 功能请求
有好想法？我们很乐意听到！请在 [Discussions](https://github.com/iota9star/json_dart/discussions) 中分享您的想法。

#### 🔧 代码贡献
- 遵循项目的代码风格
- 添加适当的测试
- 更新相关文档
- 确保所有测试通过

#### 📖 文档改进
- 修复文档中的错误
- 添加示例和用例
- 改进 API 文档
- 翻译文档到其他语言

### 🏆 贡献者

感谢所有为项目做出贡献的开发者！

<a href="https://github.com/iota9star/json_dart/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=iota9star/json_dart" />
</a>

## 📄 许可证

本项目使用 [MIT 许可证](LICENSE)。您可以自由地使用、修改和分发本软件。

## 🔗 相关链接

### 📱 项目资源
- [GitHub 仓库](https://github.com/iota9star/json_dart)
- [发布页面](https://github.com/iota9star/json_dart/releases)
- [问题追踪](https://github.com/iota9star/json_dart/issues)
- [讨论区](https://github.com/iota9star/json_dart/discussions)

### 📚 技术文档
- [Flutter 官方文档](https://docs.flutter.dev/)
- [Dart 语言指南](https://dart.dev/guides)
- [JSON5 规范](https://json5.org/)
- [ANTLR4 文档](https://github.com/antlr/antlr4)

### 🛠️ 相关工具
- [json_serializable](https://pub.dev/packages/json_serializable)
- [freezed](https://pub.dev/packages/freezed)
- [hive](https://pub.dev/packages/hive)
- [isar](https://pub.dev/packages/isar)

---

<p align="center">
  <strong>🌟 如果这个项目对您有帮助，请给我们一个 Star！🌟</strong>
</p>

<p align="center">
  Made with ❤️ by <a href="https://github.com/iota9star">iota9star</a> and <a href="https://github.com/iota9star/json_dart/graphs/contributors">contributors</a>
</p>
