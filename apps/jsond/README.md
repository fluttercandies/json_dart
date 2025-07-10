# JSON Dart App - Flutter 图形界面应用 (`jsond_app`)

> 🌐 **语言版本**: [中文](README.md) | [English](README_EN.md)

一个功能强大的 JSON 到 Dart 代码生成工具的 Flutter 图形界面应用。该应用提供了直观的用户界面，让开发者能够快速将 JSON 数据转换为 Dart 模型类。

## 🌟 主要功能

### 📝 JSON 输入支持
- **实时解析**: 支持标准 JSON 和 JSON5 格式
- **格式化功能**: 自动格式化和美化 JSON 内容
- **Unicode 转义**: 支持 Unicode 字符串转换
- **错误提示**: 详细的 JSON 语法错误提示

### 🎨 多种内置模板
- **With Final**: 生成带 final 修饰符的基础模型
- **No Final**: 生成不带 final 修饰符的模型
- **JsonSerializable**: 集成 json_annotation 包
- **JsonSerializable With HiveCE**: 结合 Hive 数据库注解
- **Freezed**: 使用 Freezed 包生成不可变模型
- **Freezed With Default**: 带默认值的 Freezed 模型
- **Freezed With HiveCE**: 结合 Hive 的 Freezed 模型
- **Isar**: 支持 Isar 数据库的模型
- **Isar + JsonSerializable**: Isar 与 json_annotation 结合
- **Isar + Freezed**: Isar 与 Freezed 结合

### ⚙️ 自定义配置
- **自定义模板**: 支持 Handlebars 语法的自定义模板编写
- **对象命名**: 可自定义生成的类名
- **主题系统**: 支持明亮/暗黑主题切换
- **颜色主题**: 可自定义应用主题颜色
- **代码格式化**: 集成 Dart 代码格式化工具

### 💻 跨平台支持
- **桌面应用**: 支持 Windows、macOS、Linux
- **移动应用**: 支持 Android、iOS
- **Web 应用**: 支持浏览器运行

## 🚀 快速开始

### 安装依赖
```bash
# 克隆项目
git clone https://github.com/iota9star/json_dart.git
cd json_dart

# 安装依赖
flutter pub get
```

### 运行应用
```bash
# 运行 Flutter 应用
flutter run
```

### 使用步骤
1. **输入 JSON**: 在左侧面板输入或粘贴 JSON 数据
2. **选择模板**: 从内置模板中选择合适的代码风格
3. **自定义名称**: 可选择性地为生成的类自定义名称
4. **生成代码**: 右侧面板实时显示生成的 Dart 代码
5. **复制代码**: 点击复制按钮将代码复制到剪贴板

## 🛠️ 模板语法

应用使用 Handlebars 模板语法，支持以下变量和助手函数：

### 对象级变量
- `{{ obj_name }}`: 对象名称
- `{{ obj_naming }}`: 对象命名
- `{{ obj_custom_name }}`: 自定义对象名称
- `{{ obj_fields_length }}`: 字段数量
- `{{ obj_index }}`: 对象索引

### 字段级变量
- `{{ field_key }}`: 字段键名
- `{{ field_type }}`: 字段类型
- `{{ field_type_name }}`: 字段类型名称
- `{{ field_deser }}`: 反序列化代码
- `{{ field_index }}`: 字段索引

### 助手函数
- `{{# @pascal_case }}{{/ @pascal_case }}`: 帕斯卡命名
- `{{# @camel_case }}{{/ @camel_case }}`: 驼峰命名
- `{{# @constant_case }}{{/ @constant_case }}`: 常量命名
- `{{# @snake_case }}{{/ @snake_case }}`: 下划线命名

### 条件判断
- `{{# field_nullable }}{{/ field_nullable }}`: 字段可空
- `{{# field_is_object }}{{/ field_is_object }}`: 字段是对象
- `{{# field_is_array }}{{/ field_is_array }}`: 字段是数组
- `{{# field_is_primitive }}{{/ field_is_primitive }}`: 字段是基础类型

## 📱 界面介绍

### 左侧模板面板
- **内置模板列表**: 显示所有可用的内置模板
- **自定义模板**: 管理用户创建的自定义模板
- **模板操作**: 查看、编辑、删除、复制模板
- **新建模板**: 创建自定义模板

### 中间 JSON 编辑器
- **语法高亮**: JSON 语法高亮显示
- **代码折叠**: 支持大型 JSON 的代码折叠
- **快捷操作**: 格式化、转义、清空等操作按钮
- **可调整宽度**: 拖拽分隔条调整编辑器宽度

### 右侧代码预览
- **实时生成**: JSON 输入变化时实时生成代码
- **语法高亮**: Dart 代码语法高亮
- **自定义命名面板**: 可展开的对象命名自定义面板

### 设置面板
- **主题模式**: 选择明亮、暗黑或跟随系统
- **主题颜色**: 自定义应用主题色彩
- **其他配置**: 各种个性化设置选项

## 🔧 技术特性

### 核心技术栈
- **Flutter**: 跨平台 UI 框架
- **jsond_core**: JSON 解析和代码生成核心库
- **ANTLR4**: JSON5 解析器
- **Hive**: 本地数据存储
- **Mustache**: 模板引擎
- **Code Builder**: Dart 代码生成

### 性能优化
- **增量解析**: 只解析变化的 JSON 部分
- **延迟渲染**: 大型代码块分片渲染
- **内存管理**: 高效的内存使用策略

### 数据持久化
- **模板存储**: 自定义模板持久化保存
- **设置保存**: 用户偏好设置自动保存
- **历史记录**: JSON 输入历史记录（可选）

## 🎯 使用场景

### API 开发
- 快速将 API 响应转换为 Dart 模型
- 支持复杂嵌套结构的解析
- 自动生成序列化/反序列化代码

### 数据库建模
- 为 Hive、Isar 等数据库生成模型
- 支持关系型和文档型数据库注解
- 自动处理类型转换

### 代码生成工具集成
- 与 json_serializable、Freezed 等包集成
- 支持 build_runner 工作流
- 兼容现有代码生成工具链

## 🤝 贡献指南

我们欢迎社区贡献！请查看项目的贡献指南了解如何参与。

### 开发环境设置
```bash
# 安装 Flutter
# 确保 Flutter SDK 版本 >= 3.32.6

# 克隆项目
git clone https://github.com/iota9star/json_dart.git
cd json_dart

# 获取依赖
flutter pub get

# 运行测试
flutter test
```

## 📄 许可证

本项目使用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 🔗 相关链接

- [GitHub 仓库](https://github.com/iota9star/json_dart)
- [问题反馈](https://github.com/iota9star/json_dart/issues)
- [功能请求](https://github.com/iota9star/json_dart/discussions)
