import 'package:collection/collection.dart';

import '../core.dart';
import 'antlr/JSON5BaseVisitor.dart';
import 'antlr/JSON5Parser.dart';
import 'type.dart';

class JVisitor extends JSON5BaseVisitor<JType> {
  JVisitor() {
    RuleContextExtension.caches.clear();
  }

  final _objs = <ObjKey, Obj>{};
  final _samePathObjs = <ObjKey, List<ObjectType>>{};

  List<Obj> get objs {
    final sames = _getDefSameFields();
    for (final value in _objs.values) {
      final key = value.key;
      final sfs = sames[key]!;
      for (final field in value._fields) {
        if (!sfs.contains(field.key)) {
          field.update(nullable: true);
        }
      }
    }
    return _objs.values.toList(growable: false);
  }

  @override
  JType visitJson5(Json5Context ctx) {
    return visit(ctx.value()!)!;
  }

  Map<ObjKey, Set<String>> _getDefSameFields() {
    final sames = <ObjKey, Set<String>>{};
    for (final entry in _samePathObjs.entries) {
      final objs = entry.value;
      final length = objs.length;
      final keys = objs.first.pairs.map((e) => e.key).toSet();
      if (length > 1) {
        for (int i = 1; i < length; ++i) {
          final nextKeys = objs[i].pairs.map((e) => e.key).toSet();
          if (nextKeys.isEmpty) {
            keys.clear();
            break;
          }
          keys.retainAll(nextKeys);
          if (keys.isEmpty) {
            break;
          }
        }
      }
      sames[entry.key] = keys;
    }
    return sames;
  }

  @override
  JType visitString(StringContext ctx) {
    return StringType(ctx, ctx.text.noQuot);
  }

  @override
  JType visitNull(NullContext ctx) {
    return NullableType(ctx);
  }

  @override
  JType visitNumber(NumberContext ctx) {
    return NumberType(ctx, num.parse(ctx.text));
  }

  @override
  JType visitArray(ArrayContext ctx) {
    return ArrayType(
      ctx,
      ctx.values().map((e) => visit(e)!).toList(growable: false),
    );
  }

  @override
  JType visitBool(BoolContext ctx) {
    return BooleanType(ctx, ctx.text == 'true');
  }

  @override
  JType visitObject(ObjectContext ctx) {
    final objectType = ObjectType(
      ctx,
      ctx.pairs().map((e) => visit(e)! as PairType).toList(growable: false),
    );
    if (ctx.pairs().isEmpty) {
      _objs.putIfAbsent(objectType.key, () => Obj(objectType.key));
    }
    _samePathObjs.putIfAbsent(objectType.key, () => []).add(objectType);
    return objectType;
  }

  @override
  JType visitPair(PairContext ctx) {
    final value = visit(ctx.value()!)!;
    final key = ctx.key()!.text.noQuot;
    final type = PairType(ctx, key, value);
    final path = ctx.parent!.getPath();
    final objKey = ObjKey(path);
    final obj = _objs.putIfAbsent(objKey, () => Obj(objKey));
    final nullable = type.nullable;
    final def = value.typing();
    final field = Field(
      key: key,
      rawDef: nullable ? null : def,
      nullable: nullable,
      types: {type.value},
    );
    if (obj._fields.contains(field)) {
      final exist = obj._fields.firstWhere((e) => e.key == key);
      exist.update(
        newDef: nullable ? null : def,
        nullable: nullable,
        type: type.value,
      );
    } else {
      obj._fields.add(field);
    }
    return type;
  }
}

class ObjKey {
  ObjKey(this.path);

  final List<String> path;
  late final key = path.join();

  String? customName;

  String naming({Map<String, String>? symbols}) {
    if (customName != null && customName!.isNotEmpty) {
      return customName!;
    }
    return name(symbols: symbols);
  }

  String name({Map<String, String>? symbols}) {
    return path.toPascalCase(symbols: symbols);
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ObjKey &&
          runtimeType == other.runtimeType &&
          const ListEquality().equals(path, other.path);

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => const ListEquality().hash(path);
}

class Obj {
  Obj(this.key);

  final ObjKey key;
  final Set<Field> _fields = {};

  Set<Field> get fields => Set.unmodifiable(_fields);

  Map<String, dynamic> toJson({
    Map<String, String>? symbols,
    required Map<ObjKey, Obj> context,
  }) {
    return {
      'obj_path': key.path,
      'obj_name': key.name(symbols: symbols),
      'obj_naming': key.naming(symbols: symbols),
      'obj_custom_name': key.customName,
      'obj_has_custom_name':
          key.customName != null && key.customName!.isNotEmpty,
      'obj_fields_length': _fields.length,
      'obj_has_fields': _fields.isNotEmpty,
      'obj_fields': _fields.mapIndexed(
        (index, e) {
          final value = e.toJson(symbols: symbols, context: context)
            ..['field_index'] = index
            ..['field_is_first'] = index == 0
            ..['field_is_last'] = index == _fields.length - 1;
          final type = value['field_type_naming'] as String;
          if (type == 'int') {
            value['field_default_value'] = '0';
          } else if (type == 'double') {
            value['field_default_value'] = '0.0';
          } else if (type == 'bool') {
            value['field_default_value'] = 'false';
          } else if (type == 'String') {
            value['field_default_value'] = "''";
          } else if (type.startsWith('List<')) {
            value['field_default_value'] = '${type.substring(4)}[]';
          } else if (type.startsWith('Map<')) {
            value['field_default_value'] = '${type.substring(3)}{}';
          } else if (type == 'dynamic') {
            value['field_default_value'] = 'null';
          } else {
            value['field_default_value'] = '$type()';
          }
          return value;
        },
      ).toList(growable: false),
    };
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Obj && runtimeType == other.runtimeType && key == other.key;

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => key.hashCode;
}

class Field {
  Field({
    required this.key,
    required this.types,
    this.rawDef,
    this.nullable = false,
  });

  final String key;
  final Set<JType> types;
  FieldTypeDef? rawDef;
  bool nullable;

  FieldTypeDef get def =>
      rawDef ??
      FieldTypeDef(
        def: 'dynamic',
        type: FieldType.dynamic,
      );

  void update({
    FieldTypeDef? newDef,
    bool? nullable,
    JType? type,
  }) {
    final curr = rawDef;
    if (newDef != null &&
        newDef.type != FieldType.dynamic &&
        curr?.type != FieldType.dynamic) {
      if (curr != null) {
        rawDef = curr.def != newDef.def && curr.type != FieldType.dynamic
            ? FieldTypeDef(def: 'dynamic', type: FieldType.dynamic)
            : newDef;
      } else {
        rawDef = newDef;
      }
    }
    if (nullable != null) {
      this.nullable = this.nullable || nullable;
    }
    if (type != null) {
      types.add(type);
    }
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Field && runtimeType == other.runtimeType && key == other.key;

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode => key.hashCode;

  Map<String, dynamic> toJson({
    Map<String, String>? symbols,
    required Map<ObjKey, Obj> context,
  }) {
    final array = types.firstWhereOrNull(
      (e) {
        if (e is! ArrayType) {
          return false;
        }
        return !e.isPrimitive(symbols);
      },
    );
    final obj = types.firstWhereOrNull((e) => e is ObjectType) as ObjectType?;
    String? deser;
    final hasArray = array != null;
    final hasObj = obj != null;
    if (hasArray || hasObj) {
      if (hasArray && hasObj) {
        deser =
            '${JType.ph} is Map ? ${obj.deser(symbols: symbols, context: context)} : ${JType.ph} is List ? ${array.deser(symbols: symbols, context: context)} : ${JType.ph}';
      } else if (hasArray) {
        deser = nullable
            ? '${JType.ph} is List ? ${array.deser(symbols: symbols, context: context)} : null'
            : array.deser(symbols: symbols, context: context);
      } else if (hasObj) {
        deser = nullable
            ? '${JType.ph} is Map ? ${obj.deser(symbols: symbols, context: context)} : null'
            : obj.deser(symbols: symbols, context: context);
      }
    }
    deser ??= JType.ph;
    String withoutSymbolKey;
    if (symbols != null) {
      withoutSymbolKey = key.replaceAllMapped(RegExp(r'^[^a-zA-Z\d]'), (match) {
        final group = match.group(0)!;
        if (symbols.containsKey(group)) {
          return '_${symbols[group]!}_';
        }
        return group;
      });
    } else {
      withoutSymbolKey = key;
    }
    return {
      'field_key': key,
      'field_without_symbol_key': withoutSymbolKey,
      'field_type': def.type.name,
      'field_type_name': def.name(symbols: symbols),
      'field_type_naming': def.naming(symbols: symbols),
      'field_type_custom_name': def.customName,
      'field_type_has_custom_name':
          def.customName != null && def.customName!.isNotEmpty,
      'field_is_dynamic': def.type == FieldType.dynamic,
      'field_is_object': def.type == FieldType.object,
      'field_is_array': def.type == FieldType.array,
      'field_is_primitive': def.type == FieldType.primitive,
      'field_is_complex': deser != JType.ph,
      'field_nullable': nullable,
      'field_deser': deser,
    };
  }
}
