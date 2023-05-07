import 'package:collection/collection.dart';

import 'antlr/JSON5BaseVisitor.dart';
import 'antlr/JSON5Parser.dart';
import 'extension.dart';
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
      if (length == 1) {
        sames[entry.key] = objs.first.fields.map((e) => e.key).toSet();
      } else {
        final keys = <String>{};
        final noc = <String>{};
        outer:
        for (int index = 0; index < length; index++) {
          if (index < length - 1) {
            final curr = objs[index];
            final next = objs[index + 1];
            int sc = 0;
            for (final field in curr.fields) {
              final key = field.key;
              final exist = next.fields.any((e) => e.key == key);
              if (exist) {
                if (sc > 0 && !keys.contains(key)) {
                  noc.add(key);
                  keys.remove(key);
                } else {
                  keys.add(key);
                  sc++;
                }
              } else {
                noc.add(key);
                keys.remove(key);
              }
            }
            if (sc == 0) {
              keys.clear();
              break outer;
            }
          }
        }
        keys.removeAll(noc);
        sames[entry.key] = keys;
      }
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
    final objKey = ObjKey(ctx.getPath());
    _samePathObjs.putIfAbsent(objKey, () => []).add(objectType);
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
    final field = Field(
      key: key,
      rawDef: nullable ? null : value.type,
      nullable: nullable,
      types: {type},
    );
    if (obj._fields.contains(field)) {
      final exist = obj._fields.firstWhere((e) => e.key == key);
      exist.update(
        rawDef: nullable ? null : value.type,
        nullable: nullable,
        type: type,
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
  late final name = path.toPascalCase();

  String? customName;

  String get display => customName ?? name;

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

  Map<String, dynamic> toJson() {
    return {
      'obj_path': key.path,
      'obj_name': key.display,
      'obj_fields_length': _fields.length,
      'obj_fields': _fields
          .mapIndexed(
            (index, e) => e.toJson()
              ..['field_index'] = index
              ..['field_is_last'] = index == _fields.length - 1,
          )
          .toList(growable: false),
    };
  }
}

class Field {
  Field({
    required this.key,
    required this.types,
    this.rawDef,
    this.nullable = false,
  });

  final String key;
  final Set<PairType> types;
  FieldTypeDef? rawDef;
  bool nullable;

  late final def = rawDef ??
      FieldTypeDef(
        name: 'dynamic',
        type: FieldDefType.dynamic,
      );

  void update({
    FieldTypeDef? rawDef,
    bool? nullable,
    PairType? type,
  }) {
    if (rawDef != null &&
        rawDef.type != FieldDefType.dynamic &&
        this.rawDef?.type != FieldDefType.dynamic) {
      if (this.rawDef?.name != rawDef.name &&
          this.rawDef?.type != FieldDefType.dynamic) {
        this.rawDef = FieldTypeDef(name: 'dynamic', type: FieldDefType.dynamic);
      } else {
        this.rawDef = rawDef;
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

  Map<String, dynamic> toJson() {
    final array = types.firstWhereOrNull(
      (e) {
        final value = e.value;
        if (value is! ArrayType) {
          return false;
        }
        return !value.isPrimitive;
      },
    );
    final obj = types.firstWhereOrNull((e) => e.value is ObjectType);
    String? deser;
    if (array != null || obj != null) {
      if (array != null && obj != null) {
        deser =
            '${JType.ph} is Map ? ${obj.deser()} : ${JType.ph} is List ? ${array.deser()} : ${JType.ph}';
      } else if (array != null) {
        deser = nullable
            ? '${JType.ph} is List ? ${array.deser()} : null'
            : array.deser();
      } else if (obj != null) {
        deser = nullable
            ? '${JType.ph} is Map ? ${obj.deser()} : null'
            : obj.deser();
      }
    }
    deser ??= JType.ph;
    return {
      'field_key': key,
      'field_type': def.type.name,
      'field_type_name': def.display,
      'field_is_dynamic': def.type == FieldDefType.dynamic,
      'field_is_object': def.type == FieldDefType.object,
      'field_is_array': def.type == FieldDefType.array,
      'field_is_primitive': def.type == FieldDefType.primitive,
      'field_is_complex': deser != JType.ph,
      'field_nullable': nullable,
      'field_deser': deser,
    };
  }
}
