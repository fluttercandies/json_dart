import 'dart:io';

import 'package:jsond_core/core.dart';

class JsonOption {
  JsonOption({
    this.templatePath,
    this.useTemplate,
    this.useDartFormat,
  });

  factory JsonOption.fromJson(Map json) {
    return JsonOption(
      templatePath: json['template_path'],
      useTemplate: json['use_template'],
      useDartFormat: json['use_dart_format'],
    );
  }

  final String? templatePath;
  final String? useTemplate;
  final bool? useDartFormat;

  late final useBuiltIn = templatePath != null;

  late final template = () {
    final String template;
    if (templatePath != null) {
      final file = File(templatePath!);
      if (!file.existsSync()) {
        throw ArgumentError('Template file not found: $templatePath');
      }
      template = file.readAsStringSync();
    } else {
      final tpl = useTemplate ?? 'with_final';
      switch (tpl) {
        case 'with_final':
          template = withFinal;
          break;
        case 'no_final':
          template = noFinal;
          break;
        case 'json_serializable':
          template = jsonSerializable;
          break;
        case 'freezed':
          template = freezed;
          break;
        case 'freezed_with_default':
          template = freezedWithDefault; // Default to with_final if empty
          break;
        case 'isar':
          template = isar;
          break;
        case 'isar_with_json_serializable':
          template = isarWithJsonSerializable;
          break;
        case 'isar_with_freezed':
          template = isarWithFreezed;
          break;
        case 'json_serializable_with_hivece':
          template = jsonSerializableWithHiveCE;
          break;
        case 'freezed_with_hivece':
          template = freezedWithHiveCE;
          break;
        case 'freezed_with_default_hivece':
          template = freezedWithDefaultAndHiveCE;
          break;
        case 'unfreezed_with_default_hivece':
          template = unfreezedWithDefaultAndHiveCE;
          break;
        default:
          throw StateError('Unreachable...');
      }
    }
    return template;
  }();
}
