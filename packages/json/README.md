# JSON Dart CLI - 命令行工具 + Build Runner (`jsond`)

> 🌐 **语言版本**: [中文](README.md) | [English](README_EN.md)

一个强大的命令行工具和 Build Runner 集成，用于将 JSON 文件批量转换为 Dart 模型类。支持多种内置模板和自定义模板，是 Flutter 和 Dart 开发者的得力助手。

## 🌟 主要功能

### 📁 批量处理
- **单文件处理**: 指定单个 JSON 文件进行转换
- **目录批处理**: 批量处理指定目录下的所有 JSON 文件
- **递归搜索**: 支持递归搜索子目录中的 JSON 文件
- **文件类型支持**: 同时支持 `.json` 和 `.json5` 文件格式

### 🔧 Build Runner 集成
- **自动构建**: 集成到 build_runner 工作流中
- **文件监听**: 支持 watch 模式，文件变化时自动重新生成
- **配置灵活**: 通过 build.yaml 进行详细配置
- **构建时生成**: 在项目构建时自动生成 Dart 代码

### 🎨 丰富的模板选择
- **with_final**: 生成带 final 修饰符的基础模型
- **no_final**: 生成不带 final 修饰符的模型
- **json_serializable**: 集成 json_annotation 包的模型
- **json_serializable_with_hivece**: 结合 Hive 数据库注解
- **freezed**: 使用 Freezed 包生成不可变模型
- **freezed_with_default**: 带默认值的 Freezed 模型
- **freezed_with_hivece**: 结合 Hive 的 Freezed 模型
- **freezed_with_default_hivece**: 带默认值和 Hive 注解的 Freezed 模型
- **isar**: 支持 Isar 数据库的模型
- **isar_with_json_serializable**: Isar 与 json_annotation 结合
- **isar_with_freezed**: Isar 与 Freezed 结合

### ⚙️ 高级配置
- **自定义模板**: 支持外部 Handlebars 模板文件
- **代码格式化**: 自动使用 dart format 格式化生成的代码
- **灵活输出**: 自动生成对应的 `.dart` 文件

## 🚀 安装使用

### 方式一：全局安装命令行工具
```bash
# 通过 pub 全局激活
dart pub global activate jsond

# 或者本地安装
dart pub get
dart pub global activate --source path .
```

### 方式二：集成到项目中
```yaml
# pubspec.yaml
dev_dependencies:
  jsond: ^1.0.0
  build_runner: ^2.3.3
```

### 基本用法

#### 命令行工具
```bash
# 处理单个文件
jsond -p path/to/your/file.json

# 处理整个目录
jsond -d path/to/your/json/directory

# 递归处理目录及子目录
jsond -d path/to/your/directory -r

# 使用特定模板
jsond -p file.json -t freezed

# 使用自定义模板
jsond -p file.json -e path/to/custom/template.hbs

# 启用代码格式化
jsond -p file.json -f
```

#### Build Runner 集成
```bash
# 在项目根目录运行构建
dart run build_runner build

# 监听模式（开发时使用）
dart run build_runner watch

# 清理已生成的文件
dart run build_runner clean
```

## 📖 命令行参数

### 必需参数（二选一）
- `-p, --path <file>`: 指定要处理的 JSON 文件路径
- `-d, --dir <directory>`: 指定包含 JSON 文件的目录路径

### 可选参数
- `-t, --template <name>`: 选择内置模板（默认: with_final）
- `-e, --external-template <file>`: 指定外部自定义模板文件路径
- `-f, --dart-format`: 对生成的代码进行格式化
- `-r, --recursive`: 递归搜索子目录（仅在指定目录时有效）
- `-h, --help`: 显示帮助信息

## ⚙️ Build Runner 配置

### 基本配置
```yaml
# build.yaml
targets:
  $default:
    builders:
      jsond:json:
        enabled: true
        options:
          template: "freezed"
          use_dart_format: true
          use_built_in: true
```

### 配置选项
- `template`: 选择内置模板名称（如 "freezed", "json_serializable" 等）
- `use_dart_format`: 是否使用 dart format 格式化生成的代码
- `use_built_in`: 是否使用内置模板（推荐设为 true）

### 文件扩展
- `.json` 文件 → `.json.dart` 文件
- `.json5` 文件 → `.json5.dart` 文件

## 💡 使用示例

### 示例 1: 基础用法
```bash
# 处理单个 API 响应文件
jsond -p api_response.json -t json_serializable -f

# 输出: api_response.json.dart (已格式化)
```

### 示例 2: 批量处理
```bash
# 批量处理 models 目录下的所有 JSON 文件
jsond -d ./models -t freezed -f -r

# 处理结果:
# models/user.json -> models/user.json.dart
# models/post.json -> models/post.json.dart
# models/api/response.json -> models/api/response.json.dart
```

### 示例 3: 自定义模板
```bash
# 使用自定义模板处理文件
jsond -p data.json -e ./templates/my_template.hbs -f
```

## 🛠️ 自定义模板

### 模板语法
CLI 工具使用 Handlebars 模板引擎，支持丰富的变量和助手函数：

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

### 可用变量和助手函数

#### 对象级变量
- `{{ obj_name }}`: 原始对象名称
- `{{ obj_naming }}`: 处理后的对象命名
- `{{ obj_custom_name }}`: 自定义对象名称
- `{{ obj_fields_length }}`: 字段数量
- `{{ obj_index }}`: 对象索引

#### 字段级变量
- `{{ field_key }}`: 字段键名
- `{{ field_type }}`: 字段 Dart 类型
- `{{ field_type_name }}`: 字段类型名称
- `{{ field_deser }}`: 反序列化表达式
- `{{ field_index }}`: 字段索引

#### 助手函数
- `{{# @pascal_case }}{{/ @pascal_case }}`: 帕斯卡命名
- `{{# @camel_case }}{{/ @camel_case }}`: 驼峰命名
- `{{# @constant_case }}{{/ @constant_case }}`: 常量命名
- `{{# @snake_case }}{{/ @snake_case }}`: 下划线命名
- `{{# @header_case }}{{/ @header_case }}`: Header 命名
- `{{# @param_case }}{{/ @param_case }}`: 参数命名

#### 条件判断
- `{{# field_nullable }}{{/ field_nullable }}`: 字段是否可空
- `{{# field_is_object }}{{/ field_is_object }}`: 字段是否为对象
- `{{# field_is_array }}{{/ field_is_array }}`: 字段是否为数组
- `{{# field_is_primitive }}{{/ field_is_primitive }}`: 字段是否为基础类型
- `{{# obj_is_first }}{{/ obj_is_first }}`: 是否为第一个对象
- `{{# obj_is_last }}{{/ obj_is_last }}`: 是否为最后一个对象

## 🎯 典型工作流

### 1. API 开发工作流
```bash
# 第一步: 获取 API 响应并保存为 JSON
curl https://api.example.com/users > users.json

# 第二步: 生成 Dart 模型
jsond -p users.json -t json_serializable -f

# 第三步: 集成到项目中
mv users.json.dart lib/models/
```

### 2. 数据库建模工作流
```bash
# 为 Hive 数据库生成模型
jsond -d ./schemas -t json_serializable_with_hivece -f -r

# 为 Isar 数据库生成模型
jsond -d ./schemas -t isar_with_freezed -f -r
```

### 3. 批量处理工作流
```bash
# 处理整个项目的 JSON Schema
jsond -d ./assets/schemas -t freezed -f -r

# 验证生成的代码
dart analyze lib/models/
```

## 🔧 集成到构建系统

### 使用 build_runner
1. 在 `pubspec.yaml` 中添加依赖：
```yaml
dependencies:
  jsond_core: ^1.0.0

dev_dependencies:
  jsond: ^1.0.0
  build_runner: ^2.3.3
```

2. 创建 `build.yaml` 配置：
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

3. 运行构建：
```bash
dart run build_runner build
```

### 使用 Makefile
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

## 🚀 性能特性

### 处理速度
- **快速解析**: 基于 ANTLR4 的高性能 JSON5 解析器
- **并行处理**: 支持多文件并行处理（规划中）
- **增量更新**: 仅处理修改过的文件（规划中）

### 内存优化
- **流式处理**: 大文件流式解析，内存占用低
- **智能缓存**: 智能缓存机制减少重复计算
- **垃圾回收友好**: 优化的内存分配策略

## 🐛 故障排除

### 常见问题

#### 1. 文件权限错误
```bash
# 确保有读写权限
chmod +r input.json
chmod +w output_directory/
```

#### 2. JSON 格式错误
```bash
# 使用在线工具验证 JSON 格式
# 或使用 jq 验证
cat your_file.json | jq .
```

#### 3. 模板不存在
```bash
# 检查模板名称是否正确
jsond --help  # 查看可用模板列表
```

#### 4. 生成的代码有语法错误
```bash
# 启用代码格式化
jsond -p file.json -f

# 手动检查语法
dart analyze generated_file.dart
```

## 🔮 未来计划

### 即将推出的功能
- **配置文件支持**: 支持 `jsond.yaml` 配置文件
- **插件系统**: 可扩展的插件架构
- **增量处理**: 智能检测文件变化
- **并行处理**: 多文件并行转换
- **IDE 集成**: VS Code 扩展支持

### 长期规划
- **GraphQL Schema 支持**: 从 GraphQL Schema 生成模型
- **TypeScript 支持**: 生成 TypeScript 类型定义
- **多语言支持**: 支持其他编程语言
- **云端服务**: 在线转换服务

## 🤝 贡献指南

我们欢迎各种形式的贡献！

### 如何贡献
1. Fork 这个仓库
2. 创建功能分支: `git checkout -b feature/my-new-feature`
3. 提交更改: `git commit -am 'Add some feature'`
4. 推送到分支: `git push origin feature/my-new-feature`
5. 提交 Pull Request

### 开发环境设置
```bash
# 克隆仓库
git clone https://github.com/iota9star/json_dart.git
cd json_dart/packages/json

# 安装依赖
dart pub get

# 运行测试
dart test

# 构建可执行文件
dart compile exe bin/main.dart -o jsond
```

## 📄 许可证

本项目使用 MIT 许可证 - 查看 [LICENSE](../../LICENSE) 文件了解详情。

## 🔗 相关链接

- [主项目仓库](https://github.com/iota9star/json_dart)
- [Flutter 应用文档](../jsond/README.md)
- [核心库文档](../core/README.md)
- [问题反馈](https://github.com/iota9star/json_dart/issues)
- [讨论区](https://github.com/iota9star/json_dart/discussions)
