// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $NichesTable extends Niches with TableInfo<$NichesTable, Niche> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NichesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    icon,
    color,
    kind,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'niches';
  @override
  VerificationContext validateIntegrity(
    Insertable<Niche> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Niche map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Niche(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $NichesTable createAlias(String alias) {
    return $NichesTable(attachedDatabase, alias);
  }
}

class Niche extends DataClass implements Insertable<Niche> {
  final String id;
  final String name;

  /// Nome de ícone Material Symbols (`home`, `directions_car`, …), não emoji —
  /// ícone nativo herda a cor do tema e o TalkBack lê o rótulo do nicho
  /// (docs/DECISIONS.md).
  final String icon;

  /// ARGB fixo, escolhido para se distinguir dos demais na distribuição da
  /// Home (docs/DECISIONS.md).
  final int color;

  /// 'expense' | 'investment' | 'debt'.
  final String kind;
  final int sortOrder;
  const Niche({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    required this.kind,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    map['color'] = Variable<int>(color);
    map['kind'] = Variable<String>(kind);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  NichesCompanion toCompanion(bool nullToAbsent) {
    return NichesCompanion(
      id: Value(id),
      name: Value(name),
      icon: Value(icon),
      color: Value(color),
      kind: Value(kind),
      sortOrder: Value(sortOrder),
    );
  }

  factory Niche.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Niche(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
      color: serializer.fromJson<int>(json['color']),
      kind: serializer.fromJson<String>(json['kind']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
      'color': serializer.toJson<int>(color),
      'kind': serializer.toJson<String>(kind),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Niche copyWith({
    String? id,
    String? name,
    String? icon,
    int? color,
    String? kind,
    int? sortOrder,
  }) => Niche(
    id: id ?? this.id,
    name: name ?? this.name,
    icon: icon ?? this.icon,
    color: color ?? this.color,
    kind: kind ?? this.kind,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  Niche copyWithCompanion(NichesCompanion data) {
    return Niche(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      color: data.color.present ? data.color.value : this.color,
      kind: data.kind.present ? data.kind.value : this.kind,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Niche(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('kind: $kind, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, icon, color, kind, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Niche &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.color == this.color &&
          other.kind == this.kind &&
          other.sortOrder == this.sortOrder);
}

class NichesCompanion extends UpdateCompanion<Niche> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> icon;
  final Value<int> color;
  final Value<String> kind;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const NichesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.kind = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NichesCompanion.insert({
    required String id,
    required String name,
    required String icon,
    required int color,
    required String kind,
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       icon = Value(icon),
       color = Value(color),
       kind = Value(kind),
       sortOrder = Value(sortOrder);
  static Insertable<Niche> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<int>? color,
    Expression<String>? kind,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      if (kind != null) 'kind': kind,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NichesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? icon,
    Value<int>? color,
    Value<String>? kind,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return NichesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      kind: kind ?? this.kind,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NichesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('kind: $kind, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $IncomeSourcesTable extends IncomeSources
    with TableInfo<$IncomeSourcesTable, IncomeSource> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IncomeSourcesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expectedCentsMeta = const VerificationMeta(
    'expectedCents',
  );
  @override
  late final GeneratedColumn<int> expectedCents = GeneratedColumn<int>(
    'expected_cents',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isRecurringMeta = const VerificationMeta(
    'isRecurring',
  );
  @override
  late final GeneratedColumn<bool> isRecurring = GeneratedColumn<bool>(
    'is_recurring',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_recurring" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _expectedDayMeta = const VerificationMeta(
    'expectedDay',
  );
  @override
  late final GeneratedColumn<int> expectedDay = GeneratedColumn<int>(
    'expected_day',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<String> archivedAt = GeneratedColumn<String>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    type,
    expectedCents,
    isRecurring,
    expectedDay,
    archivedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'income_sources';
  @override
  VerificationContext validateIntegrity(
    Insertable<IncomeSource> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('expected_cents')) {
      context.handle(
        _expectedCentsMeta,
        expectedCents.isAcceptableOrUnknown(
          data['expected_cents']!,
          _expectedCentsMeta,
        ),
      );
    }
    if (data.containsKey('is_recurring')) {
      context.handle(
        _isRecurringMeta,
        isRecurring.isAcceptableOrUnknown(
          data['is_recurring']!,
          _isRecurringMeta,
        ),
      );
    }
    if (data.containsKey('expected_day')) {
      context.handle(
        _expectedDayMeta,
        expectedDay.isAcceptableOrUnknown(
          data['expected_day']!,
          _expectedDayMeta,
        ),
      );
    }
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IncomeSource map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IncomeSource(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      expectedCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expected_cents'],
      ),
      isRecurring: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_recurring'],
      )!,
      expectedDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expected_day'],
      ),
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}archived_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $IncomeSourcesTable createAlias(String alias) {
    return $IncomeSourcesTable(attachedDatabase, alias);
  }
}

class IncomeSource extends DataClass implements Insertable<IncomeSource> {
  final String id;
  final String name;

  /// 'salary' | 'freelance' | 'rent' | 'other'.
  final String type;
  final int? expectedCents;
  final bool isRecurring;

  /// 1..31, quando recorrente.
  final int? expectedDay;
  final String? archivedAt;
  final String createdAt;
  const IncomeSource({
    required this.id,
    required this.name,
    required this.type,
    this.expectedCents,
    required this.isRecurring,
    this.expectedDay,
    this.archivedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || expectedCents != null) {
      map['expected_cents'] = Variable<int>(expectedCents);
    }
    map['is_recurring'] = Variable<bool>(isRecurring);
    if (!nullToAbsent || expectedDay != null) {
      map['expected_day'] = Variable<int>(expectedDay);
    }
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<String>(archivedAt);
    }
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  IncomeSourcesCompanion toCompanion(bool nullToAbsent) {
    return IncomeSourcesCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      expectedCents: expectedCents == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedCents),
      isRecurring: Value(isRecurring),
      expectedDay: expectedDay == null && nullToAbsent
          ? const Value.absent()
          : Value(expectedDay),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
      createdAt: Value(createdAt),
    );
  }

  factory IncomeSource.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IncomeSource(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      expectedCents: serializer.fromJson<int?>(json['expectedCents']),
      isRecurring: serializer.fromJson<bool>(json['isRecurring']),
      expectedDay: serializer.fromJson<int?>(json['expectedDay']),
      archivedAt: serializer.fromJson<String?>(json['archivedAt']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'expectedCents': serializer.toJson<int?>(expectedCents),
      'isRecurring': serializer.toJson<bool>(isRecurring),
      'expectedDay': serializer.toJson<int?>(expectedDay),
      'archivedAt': serializer.toJson<String?>(archivedAt),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  IncomeSource copyWith({
    String? id,
    String? name,
    String? type,
    Value<int?> expectedCents = const Value.absent(),
    bool? isRecurring,
    Value<int?> expectedDay = const Value.absent(),
    Value<String?> archivedAt = const Value.absent(),
    String? createdAt,
  }) => IncomeSource(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    expectedCents: expectedCents.present
        ? expectedCents.value
        : this.expectedCents,
    isRecurring: isRecurring ?? this.isRecurring,
    expectedDay: expectedDay.present ? expectedDay.value : this.expectedDay,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  IncomeSource copyWithCompanion(IncomeSourcesCompanion data) {
    return IncomeSource(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      expectedCents: data.expectedCents.present
          ? data.expectedCents.value
          : this.expectedCents,
      isRecurring: data.isRecurring.present
          ? data.isRecurring.value
          : this.isRecurring,
      expectedDay: data.expectedDay.present
          ? data.expectedDay.value
          : this.expectedDay,
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IncomeSource(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('expectedCents: $expectedCents, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('expectedDay: $expectedDay, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    type,
    expectedCents,
    isRecurring,
    expectedDay,
    archivedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IncomeSource &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.expectedCents == this.expectedCents &&
          other.isRecurring == this.isRecurring &&
          other.expectedDay == this.expectedDay &&
          other.archivedAt == this.archivedAt &&
          other.createdAt == this.createdAt);
}

class IncomeSourcesCompanion extends UpdateCompanion<IncomeSource> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<int?> expectedCents;
  final Value<bool> isRecurring;
  final Value<int?> expectedDay;
  final Value<String?> archivedAt;
  final Value<String> createdAt;
  final Value<int> rowid;
  const IncomeSourcesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.expectedCents = const Value.absent(),
    this.isRecurring = const Value.absent(),
    this.expectedDay = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IncomeSourcesCompanion.insert({
    required String id,
    required String name,
    required String type,
    this.expectedCents = const Value.absent(),
    this.isRecurring = const Value.absent(),
    this.expectedDay = const Value.absent(),
    this.archivedAt = const Value.absent(),
    required String createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       type = Value(type),
       createdAt = Value(createdAt);
  static Insertable<IncomeSource> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<int>? expectedCents,
    Expression<bool>? isRecurring,
    Expression<int>? expectedDay,
    Expression<String>? archivedAt,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (expectedCents != null) 'expected_cents': expectedCents,
      if (isRecurring != null) 'is_recurring': isRecurring,
      if (expectedDay != null) 'expected_day': expectedDay,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IncomeSourcesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? type,
    Value<int?>? expectedCents,
    Value<bool>? isRecurring,
    Value<int?>? expectedDay,
    Value<String?>? archivedAt,
    Value<String>? createdAt,
    Value<int>? rowid,
  }) {
    return IncomeSourcesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      expectedCents: expectedCents ?? this.expectedCents,
      isRecurring: isRecurring ?? this.isRecurring,
      expectedDay: expectedDay ?? this.expectedDay,
      archivedAt: archivedAt ?? this.archivedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (expectedCents.present) {
      map['expected_cents'] = Variable<int>(expectedCents.value);
    }
    if (isRecurring.present) {
      map['is_recurring'] = Variable<bool>(isRecurring.value);
    }
    if (expectedDay.present) {
      map['expected_day'] = Variable<int>(expectedDay.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<String>(archivedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IncomeSourcesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('expectedCents: $expectedCents, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('expectedDay: $expectedDay, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InvestmentsTable extends Investments
    with TableInfo<$InvestmentsTable, Investment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvestmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _balanceCentsMeta = const VerificationMeta(
    'balanceCents',
  );
  @override
  late final GeneratedColumn<int> balanceCents = GeneratedColumn<int>(
    'balance_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _balanceUpdatedAtMeta = const VerificationMeta(
    'balanceUpdatedAt',
  );
  @override
  late final GeneratedColumn<String> balanceUpdatedAt = GeneratedColumn<String>(
    'balance_updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<String> archivedAt = GeneratedColumn<String>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    type,
    balanceCents,
    balanceUpdatedAt,
    archivedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'investments';
  @override
  VerificationContext validateIntegrity(
    Insertable<Investment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('balance_cents')) {
      context.handle(
        _balanceCentsMeta,
        balanceCents.isAcceptableOrUnknown(
          data['balance_cents']!,
          _balanceCentsMeta,
        ),
      );
    }
    if (data.containsKey('balance_updated_at')) {
      context.handle(
        _balanceUpdatedAtMeta,
        balanceUpdatedAt.isAcceptableOrUnknown(
          data['balance_updated_at']!,
          _balanceUpdatedAtMeta,
        ),
      );
    }
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Investment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Investment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      balanceCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}balance_cents'],
      )!,
      balanceUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}balance_updated_at'],
      ),
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}archived_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $InvestmentsTable createAlias(String alias) {
    return $InvestmentsTable(attachedDatabase, alias);
  }
}

class Investment extends DataClass implements Insertable<Investment> {
  final String id;
  final String name;

  /// 'fixed' | 'variable' | 'fund' | 'crypto' | 'other'.
  final String type;
  final int balanceCents;
  final String? balanceUpdatedAt;
  final String? archivedAt;
  final String createdAt;
  const Investment({
    required this.id,
    required this.name,
    required this.type,
    required this.balanceCents,
    this.balanceUpdatedAt,
    this.archivedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['balance_cents'] = Variable<int>(balanceCents);
    if (!nullToAbsent || balanceUpdatedAt != null) {
      map['balance_updated_at'] = Variable<String>(balanceUpdatedAt);
    }
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<String>(archivedAt);
    }
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  InvestmentsCompanion toCompanion(bool nullToAbsent) {
    return InvestmentsCompanion(
      id: Value(id),
      name: Value(name),
      type: Value(type),
      balanceCents: Value(balanceCents),
      balanceUpdatedAt: balanceUpdatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(balanceUpdatedAt),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
      createdAt: Value(createdAt),
    );
  }

  factory Investment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Investment(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      balanceCents: serializer.fromJson<int>(json['balanceCents']),
      balanceUpdatedAt: serializer.fromJson<String?>(json['balanceUpdatedAt']),
      archivedAt: serializer.fromJson<String?>(json['archivedAt']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'balanceCents': serializer.toJson<int>(balanceCents),
      'balanceUpdatedAt': serializer.toJson<String?>(balanceUpdatedAt),
      'archivedAt': serializer.toJson<String?>(archivedAt),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  Investment copyWith({
    String? id,
    String? name,
    String? type,
    int? balanceCents,
    Value<String?> balanceUpdatedAt = const Value.absent(),
    Value<String?> archivedAt = const Value.absent(),
    String? createdAt,
  }) => Investment(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    balanceCents: balanceCents ?? this.balanceCents,
    balanceUpdatedAt: balanceUpdatedAt.present
        ? balanceUpdatedAt.value
        : this.balanceUpdatedAt,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  Investment copyWithCompanion(InvestmentsCompanion data) {
    return Investment(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      balanceCents: data.balanceCents.present
          ? data.balanceCents.value
          : this.balanceCents,
      balanceUpdatedAt: data.balanceUpdatedAt.present
          ? data.balanceUpdatedAt.value
          : this.balanceUpdatedAt,
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Investment(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('balanceCents: $balanceCents, ')
          ..write('balanceUpdatedAt: $balanceUpdatedAt, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    type,
    balanceCents,
    balanceUpdatedAt,
    archivedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Investment &&
          other.id == this.id &&
          other.name == this.name &&
          other.type == this.type &&
          other.balanceCents == this.balanceCents &&
          other.balanceUpdatedAt == this.balanceUpdatedAt &&
          other.archivedAt == this.archivedAt &&
          other.createdAt == this.createdAt);
}

class InvestmentsCompanion extends UpdateCompanion<Investment> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> type;
  final Value<int> balanceCents;
  final Value<String?> balanceUpdatedAt;
  final Value<String?> archivedAt;
  final Value<String> createdAt;
  final Value<int> rowid;
  const InvestmentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.balanceCents = const Value.absent(),
    this.balanceUpdatedAt = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvestmentsCompanion.insert({
    required String id,
    required String name,
    required String type,
    this.balanceCents = const Value.absent(),
    this.balanceUpdatedAt = const Value.absent(),
    this.archivedAt = const Value.absent(),
    required String createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       type = Value(type),
       createdAt = Value(createdAt);
  static Insertable<Investment> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? type,
    Expression<int>? balanceCents,
    Expression<String>? balanceUpdatedAt,
    Expression<String>? archivedAt,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (balanceCents != null) 'balance_cents': balanceCents,
      if (balanceUpdatedAt != null) 'balance_updated_at': balanceUpdatedAt,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvestmentsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? type,
    Value<int>? balanceCents,
    Value<String?>? balanceUpdatedAt,
    Value<String?>? archivedAt,
    Value<String>? createdAt,
    Value<int>? rowid,
  }) {
    return InvestmentsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      balanceCents: balanceCents ?? this.balanceCents,
      balanceUpdatedAt: balanceUpdatedAt ?? this.balanceUpdatedAt,
      archivedAt: archivedAt ?? this.archivedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (balanceCents.present) {
      map['balance_cents'] = Variable<int>(balanceCents.value);
    }
    if (balanceUpdatedAt.present) {
      map['balance_updated_at'] = Variable<String>(balanceUpdatedAt.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<String>(archivedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvestmentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('balanceCents: $balanceCents, ')
          ..write('balanceUpdatedAt: $balanceUpdatedAt, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DebtsTable extends Debts with TableInfo<$DebtsTable, Debt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DebtsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creditorMeta = const VerificationMeta(
    'creditor',
  );
  @override
  late final GeneratedColumn<String> creditor = GeneratedColumn<String>(
    'creditor',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalCentsMeta = const VerificationMeta(
    'totalCents',
  );
  @override
  late final GeneratedColumn<int> totalCents = GeneratedColumn<int>(
    'total_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _installmentCountMeta = const VerificationMeta(
    'installmentCount',
  );
  @override
  late final GeneratedColumn<int> installmentCount = GeneratedColumn<int>(
    'installment_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _installmentCentsMeta = const VerificationMeta(
    'installmentCents',
  );
  @override
  late final GeneratedColumn<int> installmentCents = GeneratedColumn<int>(
    'installment_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstDueOnMeta = const VerificationMeta(
    'firstDueOn',
  );
  @override
  late final GeneratedColumn<String> firstDueOn = GeneratedColumn<String>(
    'first_due_on',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _settledAtMeta = const VerificationMeta(
    'settledAt',
  );
  @override
  late final GeneratedColumn<String> settledAt = GeneratedColumn<String>(
    'settled_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    creditor,
    totalCents,
    installmentCount,
    installmentCents,
    firstDueOn,
    settledAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'debts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Debt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('creditor')) {
      context.handle(
        _creditorMeta,
        creditor.isAcceptableOrUnknown(data['creditor']!, _creditorMeta),
      );
    }
    if (data.containsKey('total_cents')) {
      context.handle(
        _totalCentsMeta,
        totalCents.isAcceptableOrUnknown(data['total_cents']!, _totalCentsMeta),
      );
    } else if (isInserting) {
      context.missing(_totalCentsMeta);
    }
    if (data.containsKey('installment_count')) {
      context.handle(
        _installmentCountMeta,
        installmentCount.isAcceptableOrUnknown(
          data['installment_count']!,
          _installmentCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_installmentCountMeta);
    }
    if (data.containsKey('installment_cents')) {
      context.handle(
        _installmentCentsMeta,
        installmentCents.isAcceptableOrUnknown(
          data['installment_cents']!,
          _installmentCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_installmentCentsMeta);
    }
    if (data.containsKey('first_due_on')) {
      context.handle(
        _firstDueOnMeta,
        firstDueOn.isAcceptableOrUnknown(
          data['first_due_on']!,
          _firstDueOnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_firstDueOnMeta);
    }
    if (data.containsKey('settled_at')) {
      context.handle(
        _settledAtMeta,
        settledAt.isAcceptableOrUnknown(data['settled_at']!, _settledAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Debt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Debt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      creditor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creditor'],
      ),
      totalCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_cents'],
      )!,
      installmentCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}installment_count'],
      )!,
      installmentCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}installment_cents'],
      )!,
      firstDueOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_due_on'],
      )!,
      settledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}settled_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DebtsTable createAlias(String alias) {
    return $DebtsTable(attachedDatabase, alias);
  }
}

class Debt extends DataClass implements Insertable<Debt> {
  final String id;
  final String name;
  final String? creditor;
  final int totalCents;
  final int installmentCount;
  final int installmentCents;
  final String firstDueOn;
  final String? settledAt;
  final String createdAt;
  const Debt({
    required this.id,
    required this.name,
    this.creditor,
    required this.totalCents,
    required this.installmentCount,
    required this.installmentCents,
    required this.firstDueOn,
    this.settledAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || creditor != null) {
      map['creditor'] = Variable<String>(creditor);
    }
    map['total_cents'] = Variable<int>(totalCents);
    map['installment_count'] = Variable<int>(installmentCount);
    map['installment_cents'] = Variable<int>(installmentCents);
    map['first_due_on'] = Variable<String>(firstDueOn);
    if (!nullToAbsent || settledAt != null) {
      map['settled_at'] = Variable<String>(settledAt);
    }
    map['created_at'] = Variable<String>(createdAt);
    return map;
  }

  DebtsCompanion toCompanion(bool nullToAbsent) {
    return DebtsCompanion(
      id: Value(id),
      name: Value(name),
      creditor: creditor == null && nullToAbsent
          ? const Value.absent()
          : Value(creditor),
      totalCents: Value(totalCents),
      installmentCount: Value(installmentCount),
      installmentCents: Value(installmentCents),
      firstDueOn: Value(firstDueOn),
      settledAt: settledAt == null && nullToAbsent
          ? const Value.absent()
          : Value(settledAt),
      createdAt: Value(createdAt),
    );
  }

  factory Debt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Debt(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      creditor: serializer.fromJson<String?>(json['creditor']),
      totalCents: serializer.fromJson<int>(json['totalCents']),
      installmentCount: serializer.fromJson<int>(json['installmentCount']),
      installmentCents: serializer.fromJson<int>(json['installmentCents']),
      firstDueOn: serializer.fromJson<String>(json['firstDueOn']),
      settledAt: serializer.fromJson<String?>(json['settledAt']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'creditor': serializer.toJson<String?>(creditor),
      'totalCents': serializer.toJson<int>(totalCents),
      'installmentCount': serializer.toJson<int>(installmentCount),
      'installmentCents': serializer.toJson<int>(installmentCents),
      'firstDueOn': serializer.toJson<String>(firstDueOn),
      'settledAt': serializer.toJson<String?>(settledAt),
      'createdAt': serializer.toJson<String>(createdAt),
    };
  }

  Debt copyWith({
    String? id,
    String? name,
    Value<String?> creditor = const Value.absent(),
    int? totalCents,
    int? installmentCount,
    int? installmentCents,
    String? firstDueOn,
    Value<String?> settledAt = const Value.absent(),
    String? createdAt,
  }) => Debt(
    id: id ?? this.id,
    name: name ?? this.name,
    creditor: creditor.present ? creditor.value : this.creditor,
    totalCents: totalCents ?? this.totalCents,
    installmentCount: installmentCount ?? this.installmentCount,
    installmentCents: installmentCents ?? this.installmentCents,
    firstDueOn: firstDueOn ?? this.firstDueOn,
    settledAt: settledAt.present ? settledAt.value : this.settledAt,
    createdAt: createdAt ?? this.createdAt,
  );
  Debt copyWithCompanion(DebtsCompanion data) {
    return Debt(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      creditor: data.creditor.present ? data.creditor.value : this.creditor,
      totalCents: data.totalCents.present
          ? data.totalCents.value
          : this.totalCents,
      installmentCount: data.installmentCount.present
          ? data.installmentCount.value
          : this.installmentCount,
      installmentCents: data.installmentCents.present
          ? data.installmentCents.value
          : this.installmentCents,
      firstDueOn: data.firstDueOn.present
          ? data.firstDueOn.value
          : this.firstDueOn,
      settledAt: data.settledAt.present ? data.settledAt.value : this.settledAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Debt(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('creditor: $creditor, ')
          ..write('totalCents: $totalCents, ')
          ..write('installmentCount: $installmentCount, ')
          ..write('installmentCents: $installmentCents, ')
          ..write('firstDueOn: $firstDueOn, ')
          ..write('settledAt: $settledAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    creditor,
    totalCents,
    installmentCount,
    installmentCents,
    firstDueOn,
    settledAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Debt &&
          other.id == this.id &&
          other.name == this.name &&
          other.creditor == this.creditor &&
          other.totalCents == this.totalCents &&
          other.installmentCount == this.installmentCount &&
          other.installmentCents == this.installmentCents &&
          other.firstDueOn == this.firstDueOn &&
          other.settledAt == this.settledAt &&
          other.createdAt == this.createdAt);
}

class DebtsCompanion extends UpdateCompanion<Debt> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> creditor;
  final Value<int> totalCents;
  final Value<int> installmentCount;
  final Value<int> installmentCents;
  final Value<String> firstDueOn;
  final Value<String?> settledAt;
  final Value<String> createdAt;
  final Value<int> rowid;
  const DebtsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.creditor = const Value.absent(),
    this.totalCents = const Value.absent(),
    this.installmentCount = const Value.absent(),
    this.installmentCents = const Value.absent(),
    this.firstDueOn = const Value.absent(),
    this.settledAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DebtsCompanion.insert({
    required String id,
    required String name,
    this.creditor = const Value.absent(),
    required int totalCents,
    required int installmentCount,
    required int installmentCents,
    required String firstDueOn,
    this.settledAt = const Value.absent(),
    required String createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       totalCents = Value(totalCents),
       installmentCount = Value(installmentCount),
       installmentCents = Value(installmentCents),
       firstDueOn = Value(firstDueOn),
       createdAt = Value(createdAt);
  static Insertable<Debt> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? creditor,
    Expression<int>? totalCents,
    Expression<int>? installmentCount,
    Expression<int>? installmentCents,
    Expression<String>? firstDueOn,
    Expression<String>? settledAt,
    Expression<String>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (creditor != null) 'creditor': creditor,
      if (totalCents != null) 'total_cents': totalCents,
      if (installmentCount != null) 'installment_count': installmentCount,
      if (installmentCents != null) 'installment_cents': installmentCents,
      if (firstDueOn != null) 'first_due_on': firstDueOn,
      if (settledAt != null) 'settled_at': settledAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DebtsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? creditor,
    Value<int>? totalCents,
    Value<int>? installmentCount,
    Value<int>? installmentCents,
    Value<String>? firstDueOn,
    Value<String?>? settledAt,
    Value<String>? createdAt,
    Value<int>? rowid,
  }) {
    return DebtsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      creditor: creditor ?? this.creditor,
      totalCents: totalCents ?? this.totalCents,
      installmentCount: installmentCount ?? this.installmentCount,
      installmentCents: installmentCents ?? this.installmentCents,
      firstDueOn: firstDueOn ?? this.firstDueOn,
      settledAt: settledAt ?? this.settledAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (creditor.present) {
      map['creditor'] = Variable<String>(creditor.value);
    }
    if (totalCents.present) {
      map['total_cents'] = Variable<int>(totalCents.value);
    }
    if (installmentCount.present) {
      map['installment_count'] = Variable<int>(installmentCount.value);
    }
    if (installmentCents.present) {
      map['installment_cents'] = Variable<int>(installmentCents.value);
    }
    if (firstDueOn.present) {
      map['first_due_on'] = Variable<String>(firstDueOn.value);
    }
    if (settledAt.present) {
      map['settled_at'] = Variable<String>(settledAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DebtsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('creditor: $creditor, ')
          ..write('totalCents: $totalCents, ')
          ..write('installmentCount: $installmentCount, ')
          ..write('installmentCents: $installmentCents, ')
          ..write('firstDueOn: $firstDueOn, ')
          ..write('settledAt: $settledAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DebtInstallmentsTable extends DebtInstallments
    with TableInfo<$DebtInstallmentsTable, DebtInstallment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DebtInstallmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _debtIdMeta = const VerificationMeta('debtId');
  @override
  late final GeneratedColumn<String> debtId = GeneratedColumn<String>(
    'debt_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES debts (id)',
    ),
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<int> number = GeneratedColumn<int>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueOnMeta = const VerificationMeta('dueOn');
  @override
  late final GeneratedColumn<String> dueOn = GeneratedColumn<String>(
    'due_on',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paidOnMeta = const VerificationMeta('paidOn');
  @override
  late final GeneratedColumn<String> paidOn = GeneratedColumn<String>(
    'paid_on',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    debtId,
    number,
    dueOn,
    amountCents,
    paidOn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'debt_installments';
  @override
  VerificationContext validateIntegrity(
    Insertable<DebtInstallment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('debt_id')) {
      context.handle(
        _debtIdMeta,
        debtId.isAcceptableOrUnknown(data['debt_id']!, _debtIdMeta),
      );
    } else if (isInserting) {
      context.missing(_debtIdMeta);
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('due_on')) {
      context.handle(
        _dueOnMeta,
        dueOn.isAcceptableOrUnknown(data['due_on']!, _dueOnMeta),
      );
    } else if (isInserting) {
      context.missing(_dueOnMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('paid_on')) {
      context.handle(
        _paidOnMeta,
        paidOn.isAcceptableOrUnknown(data['paid_on']!, _paidOnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {debtId, number},
  ];
  @override
  DebtInstallment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DebtInstallment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      debtId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}debt_id'],
      )!,
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number'],
      )!,
      dueOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}due_on'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
      paidOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}paid_on'],
      ),
    );
  }

  @override
  $DebtInstallmentsTable createAlias(String alias) {
    return $DebtInstallmentsTable(attachedDatabase, alias);
  }
}

class DebtInstallment extends DataClass implements Insertable<DebtInstallment> {
  final String id;
  final String debtId;

  /// 1..N.
  final int number;
  final String dueOn;
  final int amountCents;

  /// Nulo = em aberto.
  final String? paidOn;
  const DebtInstallment({
    required this.id,
    required this.debtId,
    required this.number,
    required this.dueOn,
    required this.amountCents,
    this.paidOn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['debt_id'] = Variable<String>(debtId);
    map['number'] = Variable<int>(number);
    map['due_on'] = Variable<String>(dueOn);
    map['amount_cents'] = Variable<int>(amountCents);
    if (!nullToAbsent || paidOn != null) {
      map['paid_on'] = Variable<String>(paidOn);
    }
    return map;
  }

  DebtInstallmentsCompanion toCompanion(bool nullToAbsent) {
    return DebtInstallmentsCompanion(
      id: Value(id),
      debtId: Value(debtId),
      number: Value(number),
      dueOn: Value(dueOn),
      amountCents: Value(amountCents),
      paidOn: paidOn == null && nullToAbsent
          ? const Value.absent()
          : Value(paidOn),
    );
  }

  factory DebtInstallment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DebtInstallment(
      id: serializer.fromJson<String>(json['id']),
      debtId: serializer.fromJson<String>(json['debtId']),
      number: serializer.fromJson<int>(json['number']),
      dueOn: serializer.fromJson<String>(json['dueOn']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      paidOn: serializer.fromJson<String?>(json['paidOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'debtId': serializer.toJson<String>(debtId),
      'number': serializer.toJson<int>(number),
      'dueOn': serializer.toJson<String>(dueOn),
      'amountCents': serializer.toJson<int>(amountCents),
      'paidOn': serializer.toJson<String?>(paidOn),
    };
  }

  DebtInstallment copyWith({
    String? id,
    String? debtId,
    int? number,
    String? dueOn,
    int? amountCents,
    Value<String?> paidOn = const Value.absent(),
  }) => DebtInstallment(
    id: id ?? this.id,
    debtId: debtId ?? this.debtId,
    number: number ?? this.number,
    dueOn: dueOn ?? this.dueOn,
    amountCents: amountCents ?? this.amountCents,
    paidOn: paidOn.present ? paidOn.value : this.paidOn,
  );
  DebtInstallment copyWithCompanion(DebtInstallmentsCompanion data) {
    return DebtInstallment(
      id: data.id.present ? data.id.value : this.id,
      debtId: data.debtId.present ? data.debtId.value : this.debtId,
      number: data.number.present ? data.number.value : this.number,
      dueOn: data.dueOn.present ? data.dueOn.value : this.dueOn,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      paidOn: data.paidOn.present ? data.paidOn.value : this.paidOn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DebtInstallment(')
          ..write('id: $id, ')
          ..write('debtId: $debtId, ')
          ..write('number: $number, ')
          ..write('dueOn: $dueOn, ')
          ..write('amountCents: $amountCents, ')
          ..write('paidOn: $paidOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, debtId, number, dueOn, amountCents, paidOn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DebtInstallment &&
          other.id == this.id &&
          other.debtId == this.debtId &&
          other.number == this.number &&
          other.dueOn == this.dueOn &&
          other.amountCents == this.amountCents &&
          other.paidOn == this.paidOn);
}

class DebtInstallmentsCompanion extends UpdateCompanion<DebtInstallment> {
  final Value<String> id;
  final Value<String> debtId;
  final Value<int> number;
  final Value<String> dueOn;
  final Value<int> amountCents;
  final Value<String?> paidOn;
  final Value<int> rowid;
  const DebtInstallmentsCompanion({
    this.id = const Value.absent(),
    this.debtId = const Value.absent(),
    this.number = const Value.absent(),
    this.dueOn = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.paidOn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DebtInstallmentsCompanion.insert({
    required String id,
    required String debtId,
    required int number,
    required String dueOn,
    required int amountCents,
    this.paidOn = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       debtId = Value(debtId),
       number = Value(number),
       dueOn = Value(dueOn),
       amountCents = Value(amountCents);
  static Insertable<DebtInstallment> custom({
    Expression<String>? id,
    Expression<String>? debtId,
    Expression<int>? number,
    Expression<String>? dueOn,
    Expression<int>? amountCents,
    Expression<String>? paidOn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (debtId != null) 'debt_id': debtId,
      if (number != null) 'number': number,
      if (dueOn != null) 'due_on': dueOn,
      if (amountCents != null) 'amount_cents': amountCents,
      if (paidOn != null) 'paid_on': paidOn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DebtInstallmentsCompanion copyWith({
    Value<String>? id,
    Value<String>? debtId,
    Value<int>? number,
    Value<String>? dueOn,
    Value<int>? amountCents,
    Value<String?>? paidOn,
    Value<int>? rowid,
  }) {
    return DebtInstallmentsCompanion(
      id: id ?? this.id,
      debtId: debtId ?? this.debtId,
      number: number ?? this.number,
      dueOn: dueOn ?? this.dueOn,
      amountCents: amountCents ?? this.amountCents,
      paidOn: paidOn ?? this.paidOn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (debtId.present) {
      map['debt_id'] = Variable<String>(debtId.value);
    }
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (dueOn.present) {
      map['due_on'] = Variable<String>(dueOn.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (paidOn.present) {
      map['paid_on'] = Variable<String>(paidOn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DebtInstallmentsCompanion(')
          ..write('id: $id, ')
          ..write('debtId: $debtId, ')
          ..write('number: $number, ')
          ..write('dueOn: $dueOn, ')
          ..write('amountCents: $amountCents, ')
          ..write('paidOn: $paidOn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _occurredOnMeta = const VerificationMeta(
    'occurredOn',
  );
  @override
  late final GeneratedColumn<String> occurredOn = GeneratedColumn<String>(
    'occurred_on',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionNormMeta = const VerificationMeta(
    'descriptionNorm',
  );
  @override
  late final GeneratedColumn<String> descriptionNorm = GeneratedColumn<String>(
    'description_norm',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nicheIdMeta = const VerificationMeta(
    'nicheId',
  );
  @override
  late final GeneratedColumn<String> nicheId = GeneratedColumn<String>(
    'niche_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _incomeSourceIdMeta = const VerificationMeta(
    'incomeSourceId',
  );
  @override
  late final GeneratedColumn<String> incomeSourceId = GeneratedColumn<String>(
    'income_source_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES income_sources (id)',
    ),
  );
  static const VerificationMeta _investmentIdMeta = const VerificationMeta(
    'investmentId',
  );
  @override
  late final GeneratedColumn<String> investmentId = GeneratedColumn<String>(
    'investment_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES investments (id)',
    ),
  );
  static const VerificationMeta _debtInstallmentIdMeta = const VerificationMeta(
    'debtInstallmentId',
  );
  @override
  late final GeneratedColumn<String> debtInstallmentId =
      GeneratedColumn<String>(
        'debt_installment_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES debt_installments (id)',
        ),
      );
  static const VerificationMeta _recurrenceMeta = const VerificationMeta(
    'recurrence',
  );
  @override
  late final GeneratedColumn<String> recurrence = GeneratedColumn<String>(
    'recurrence',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recurrenceGroupIdMeta = const VerificationMeta(
    'recurrenceGroupId',
  );
  @override
  late final GeneratedColumn<String> recurrenceGroupId =
      GeneratedColumn<String>(
        'recurrence_group_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<String> deletedAt = GeneratedColumn<String>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    kind,
    amountCents,
    occurredOn,
    description,
    descriptionNorm,
    paymentMethod,
    nicheId,
    incomeSourceId,
    investmentId,
    debtInstallmentId,
    recurrence,
    recurrenceGroupId,
    createdAt,
    updatedAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Transaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('occurred_on')) {
      context.handle(
        _occurredOnMeta,
        occurredOn.isAcceptableOrUnknown(data['occurred_on']!, _occurredOnMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredOnMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('description_norm')) {
      context.handle(
        _descriptionNormMeta,
        descriptionNorm.isAcceptableOrUnknown(
          data['description_norm']!,
          _descriptionNormMeta,
        ),
      );
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('niche_id')) {
      context.handle(
        _nicheIdMeta,
        nicheId.isAcceptableOrUnknown(data['niche_id']!, _nicheIdMeta),
      );
    }
    if (data.containsKey('income_source_id')) {
      context.handle(
        _incomeSourceIdMeta,
        incomeSourceId.isAcceptableOrUnknown(
          data['income_source_id']!,
          _incomeSourceIdMeta,
        ),
      );
    }
    if (data.containsKey('investment_id')) {
      context.handle(
        _investmentIdMeta,
        investmentId.isAcceptableOrUnknown(
          data['investment_id']!,
          _investmentIdMeta,
        ),
      );
    }
    if (data.containsKey('debt_installment_id')) {
      context.handle(
        _debtInstallmentIdMeta,
        debtInstallmentId.isAcceptableOrUnknown(
          data['debt_installment_id']!,
          _debtInstallmentIdMeta,
        ),
      );
    }
    if (data.containsKey('recurrence')) {
      context.handle(
        _recurrenceMeta,
        recurrence.isAcceptableOrUnknown(data['recurrence']!, _recurrenceMeta),
      );
    }
    if (data.containsKey('recurrence_group_id')) {
      context.handle(
        _recurrenceGroupIdMeta,
        recurrenceGroupId.isAcceptableOrUnknown(
          data['recurrence_group_id']!,
          _recurrenceGroupIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
      occurredOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}occurred_on'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      descriptionNorm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_norm'],
      ),
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      ),
      nicheId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}niche_id'],
      ),
      incomeSourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}income_source_id'],
      ),
      investmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}investment_id'],
      ),
      debtInstallmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}debt_installment_id'],
      ),
      recurrence: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurrence'],
      ),
      recurrenceGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurrence_group_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final String id;

  /// 'expense' | 'income' | 'investment_in' | 'investment_out' | 'debt_payment'.
  final String kind;
  final int amountCents;
  final String occurredOn;
  final String? description;

  /// `description` em minúscula e sem acento (RF-14) — gravada, não
  /// calculada em tempo de consulta: o `LIKE` do SQLite não faz *accent
  /// folding*.
  final String? descriptionNorm;

  /// 'debit' | 'credit' | 'pix' | 'cash' | null.
  final String? paymentMethod;
  final String? nicheId;
  final String? incomeSourceId;
  final String? investmentId;
  final String? debtInstallmentId;

  /// null | 'monthly'.
  final String? recurrence;
  final String? recurrenceGroupId;
  final String createdAt;
  final String updatedAt;

  /// Soft delete. Nulo significa vivo.
  final String? deletedAt;
  const Transaction({
    required this.id,
    required this.kind,
    required this.amountCents,
    required this.occurredOn,
    this.description,
    this.descriptionNorm,
    this.paymentMethod,
    this.nicheId,
    this.incomeSourceId,
    this.investmentId,
    this.debtInstallmentId,
    this.recurrence,
    this.recurrenceGroupId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['kind'] = Variable<String>(kind);
    map['amount_cents'] = Variable<int>(amountCents);
    map['occurred_on'] = Variable<String>(occurredOn);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || descriptionNorm != null) {
      map['description_norm'] = Variable<String>(descriptionNorm);
    }
    if (!nullToAbsent || paymentMethod != null) {
      map['payment_method'] = Variable<String>(paymentMethod);
    }
    if (!nullToAbsent || nicheId != null) {
      map['niche_id'] = Variable<String>(nicheId);
    }
    if (!nullToAbsent || incomeSourceId != null) {
      map['income_source_id'] = Variable<String>(incomeSourceId);
    }
    if (!nullToAbsent || investmentId != null) {
      map['investment_id'] = Variable<String>(investmentId);
    }
    if (!nullToAbsent || debtInstallmentId != null) {
      map['debt_installment_id'] = Variable<String>(debtInstallmentId);
    }
    if (!nullToAbsent || recurrence != null) {
      map['recurrence'] = Variable<String>(recurrence);
    }
    if (!nullToAbsent || recurrenceGroupId != null) {
      map['recurrence_group_id'] = Variable<String>(recurrenceGroupId);
    }
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<String>(deletedAt);
    }
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      kind: Value(kind),
      amountCents: Value(amountCents),
      occurredOn: Value(occurredOn),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      descriptionNorm: descriptionNorm == null && nullToAbsent
          ? const Value.absent()
          : Value(descriptionNorm),
      paymentMethod: paymentMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentMethod),
      nicheId: nicheId == null && nullToAbsent
          ? const Value.absent()
          : Value(nicheId),
      incomeSourceId: incomeSourceId == null && nullToAbsent
          ? const Value.absent()
          : Value(incomeSourceId),
      investmentId: investmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(investmentId),
      debtInstallmentId: debtInstallmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(debtInstallmentId),
      recurrence: recurrence == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrence),
      recurrenceGroupId: recurrenceGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceGroupId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Transaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<String>(json['id']),
      kind: serializer.fromJson<String>(json['kind']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      occurredOn: serializer.fromJson<String>(json['occurredOn']),
      description: serializer.fromJson<String?>(json['description']),
      descriptionNorm: serializer.fromJson<String?>(json['descriptionNorm']),
      paymentMethod: serializer.fromJson<String?>(json['paymentMethod']),
      nicheId: serializer.fromJson<String?>(json['nicheId']),
      incomeSourceId: serializer.fromJson<String?>(json['incomeSourceId']),
      investmentId: serializer.fromJson<String?>(json['investmentId']),
      debtInstallmentId: serializer.fromJson<String?>(
        json['debtInstallmentId'],
      ),
      recurrence: serializer.fromJson<String?>(json['recurrence']),
      recurrenceGroupId: serializer.fromJson<String?>(
        json['recurrenceGroupId'],
      ),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
      deletedAt: serializer.fromJson<String?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'kind': serializer.toJson<String>(kind),
      'amountCents': serializer.toJson<int>(amountCents),
      'occurredOn': serializer.toJson<String>(occurredOn),
      'description': serializer.toJson<String?>(description),
      'descriptionNorm': serializer.toJson<String?>(descriptionNorm),
      'paymentMethod': serializer.toJson<String?>(paymentMethod),
      'nicheId': serializer.toJson<String?>(nicheId),
      'incomeSourceId': serializer.toJson<String?>(incomeSourceId),
      'investmentId': serializer.toJson<String?>(investmentId),
      'debtInstallmentId': serializer.toJson<String?>(debtInstallmentId),
      'recurrence': serializer.toJson<String?>(recurrence),
      'recurrenceGroupId': serializer.toJson<String?>(recurrenceGroupId),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
      'deletedAt': serializer.toJson<String?>(deletedAt),
    };
  }

  Transaction copyWith({
    String? id,
    String? kind,
    int? amountCents,
    String? occurredOn,
    Value<String?> description = const Value.absent(),
    Value<String?> descriptionNorm = const Value.absent(),
    Value<String?> paymentMethod = const Value.absent(),
    Value<String?> nicheId = const Value.absent(),
    Value<String?> incomeSourceId = const Value.absent(),
    Value<String?> investmentId = const Value.absent(),
    Value<String?> debtInstallmentId = const Value.absent(),
    Value<String?> recurrence = const Value.absent(),
    Value<String?> recurrenceGroupId = const Value.absent(),
    String? createdAt,
    String? updatedAt,
    Value<String?> deletedAt = const Value.absent(),
  }) => Transaction(
    id: id ?? this.id,
    kind: kind ?? this.kind,
    amountCents: amountCents ?? this.amountCents,
    occurredOn: occurredOn ?? this.occurredOn,
    description: description.present ? description.value : this.description,
    descriptionNorm: descriptionNorm.present
        ? descriptionNorm.value
        : this.descriptionNorm,
    paymentMethod: paymentMethod.present
        ? paymentMethod.value
        : this.paymentMethod,
    nicheId: nicheId.present ? nicheId.value : this.nicheId,
    incomeSourceId: incomeSourceId.present
        ? incomeSourceId.value
        : this.incomeSourceId,
    investmentId: investmentId.present ? investmentId.value : this.investmentId,
    debtInstallmentId: debtInstallmentId.present
        ? debtInstallmentId.value
        : this.debtInstallmentId,
    recurrence: recurrence.present ? recurrence.value : this.recurrence,
    recurrenceGroupId: recurrenceGroupId.present
        ? recurrenceGroupId.value
        : this.recurrenceGroupId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Transaction copyWithCompanion(TransactionsCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      kind: data.kind.present ? data.kind.value : this.kind,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      occurredOn: data.occurredOn.present
          ? data.occurredOn.value
          : this.occurredOn,
      description: data.description.present
          ? data.description.value
          : this.description,
      descriptionNorm: data.descriptionNorm.present
          ? data.descriptionNorm.value
          : this.descriptionNorm,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      nicheId: data.nicheId.present ? data.nicheId.value : this.nicheId,
      incomeSourceId: data.incomeSourceId.present
          ? data.incomeSourceId.value
          : this.incomeSourceId,
      investmentId: data.investmentId.present
          ? data.investmentId.value
          : this.investmentId,
      debtInstallmentId: data.debtInstallmentId.present
          ? data.debtInstallmentId.value
          : this.debtInstallmentId,
      recurrence: data.recurrence.present
          ? data.recurrence.value
          : this.recurrence,
      recurrenceGroupId: data.recurrenceGroupId.present
          ? data.recurrenceGroupId.value
          : this.recurrenceGroupId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('amountCents: $amountCents, ')
          ..write('occurredOn: $occurredOn, ')
          ..write('description: $description, ')
          ..write('descriptionNorm: $descriptionNorm, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('nicheId: $nicheId, ')
          ..write('incomeSourceId: $incomeSourceId, ')
          ..write('investmentId: $investmentId, ')
          ..write('debtInstallmentId: $debtInstallmentId, ')
          ..write('recurrence: $recurrence, ')
          ..write('recurrenceGroupId: $recurrenceGroupId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    kind,
    amountCents,
    occurredOn,
    description,
    descriptionNorm,
    paymentMethod,
    nicheId,
    incomeSourceId,
    investmentId,
    debtInstallmentId,
    recurrence,
    recurrenceGroupId,
    createdAt,
    updatedAt,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.kind == this.kind &&
          other.amountCents == this.amountCents &&
          other.occurredOn == this.occurredOn &&
          other.description == this.description &&
          other.descriptionNorm == this.descriptionNorm &&
          other.paymentMethod == this.paymentMethod &&
          other.nicheId == this.nicheId &&
          other.incomeSourceId == this.incomeSourceId &&
          other.investmentId == this.investmentId &&
          other.debtInstallmentId == this.debtInstallmentId &&
          other.recurrence == this.recurrence &&
          other.recurrenceGroupId == this.recurrenceGroupId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<String> id;
  final Value<String> kind;
  final Value<int> amountCents;
  final Value<String> occurredOn;
  final Value<String?> description;
  final Value<String?> descriptionNorm;
  final Value<String?> paymentMethod;
  final Value<String?> nicheId;
  final Value<String?> incomeSourceId;
  final Value<String?> investmentId;
  final Value<String?> debtInstallmentId;
  final Value<String?> recurrence;
  final Value<String?> recurrenceGroupId;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<String?> deletedAt;
  final Value<int> rowid;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.kind = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.occurredOn = const Value.absent(),
    this.description = const Value.absent(),
    this.descriptionNorm = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.nicheId = const Value.absent(),
    this.incomeSourceId = const Value.absent(),
    this.investmentId = const Value.absent(),
    this.debtInstallmentId = const Value.absent(),
    this.recurrence = const Value.absent(),
    this.recurrenceGroupId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsCompanion.insert({
    required String id,
    required String kind,
    required int amountCents,
    required String occurredOn,
    this.description = const Value.absent(),
    this.descriptionNorm = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.nicheId = const Value.absent(),
    this.incomeSourceId = const Value.absent(),
    this.investmentId = const Value.absent(),
    this.debtInstallmentId = const Value.absent(),
    this.recurrence = const Value.absent(),
    this.recurrenceGroupId = const Value.absent(),
    required String createdAt,
    required String updatedAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       kind = Value(kind),
       amountCents = Value(amountCents),
       occurredOn = Value(occurredOn),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Transaction> custom({
    Expression<String>? id,
    Expression<String>? kind,
    Expression<int>? amountCents,
    Expression<String>? occurredOn,
    Expression<String>? description,
    Expression<String>? descriptionNorm,
    Expression<String>? paymentMethod,
    Expression<String>? nicheId,
    Expression<String>? incomeSourceId,
    Expression<String>? investmentId,
    Expression<String>? debtInstallmentId,
    Expression<String>? recurrence,
    Expression<String>? recurrenceGroupId,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<String>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kind != null) 'kind': kind,
      if (amountCents != null) 'amount_cents': amountCents,
      if (occurredOn != null) 'occurred_on': occurredOn,
      if (description != null) 'description': description,
      if (descriptionNorm != null) 'description_norm': descriptionNorm,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (nicheId != null) 'niche_id': nicheId,
      if (incomeSourceId != null) 'income_source_id': incomeSourceId,
      if (investmentId != null) 'investment_id': investmentId,
      if (debtInstallmentId != null) 'debt_installment_id': debtInstallmentId,
      if (recurrence != null) 'recurrence': recurrence,
      if (recurrenceGroupId != null) 'recurrence_group_id': recurrenceGroupId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsCompanion copyWith({
    Value<String>? id,
    Value<String>? kind,
    Value<int>? amountCents,
    Value<String>? occurredOn,
    Value<String?>? description,
    Value<String?>? descriptionNorm,
    Value<String?>? paymentMethod,
    Value<String?>? nicheId,
    Value<String?>? incomeSourceId,
    Value<String?>? investmentId,
    Value<String?>? debtInstallmentId,
    Value<String?>? recurrence,
    Value<String?>? recurrenceGroupId,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<String?>? deletedAt,
    Value<int>? rowid,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      amountCents: amountCents ?? this.amountCents,
      occurredOn: occurredOn ?? this.occurredOn,
      description: description ?? this.description,
      descriptionNorm: descriptionNorm ?? this.descriptionNorm,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      nicheId: nicheId ?? this.nicheId,
      incomeSourceId: incomeSourceId ?? this.incomeSourceId,
      investmentId: investmentId ?? this.investmentId,
      debtInstallmentId: debtInstallmentId ?? this.debtInstallmentId,
      recurrence: recurrence ?? this.recurrence,
      recurrenceGroupId: recurrenceGroupId ?? this.recurrenceGroupId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (occurredOn.present) {
      map['occurred_on'] = Variable<String>(occurredOn.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (descriptionNorm.present) {
      map['description_norm'] = Variable<String>(descriptionNorm.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (nicheId.present) {
      map['niche_id'] = Variable<String>(nicheId.value);
    }
    if (incomeSourceId.present) {
      map['income_source_id'] = Variable<String>(incomeSourceId.value);
    }
    if (investmentId.present) {
      map['investment_id'] = Variable<String>(investmentId.value);
    }
    if (debtInstallmentId.present) {
      map['debt_installment_id'] = Variable<String>(debtInstallmentId.value);
    }
    if (recurrence.present) {
      map['recurrence'] = Variable<String>(recurrence.value);
    }
    if (recurrenceGroupId.present) {
      map['recurrence_group_id'] = Variable<String>(recurrenceGroupId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<String>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('amountCents: $amountCents, ')
          ..write('occurredOn: $occurredOn, ')
          ..write('description: $description, ')
          ..write('descriptionNorm: $descriptionNorm, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('nicheId: $nicheId, ')
          ..write('incomeSourceId: $incomeSourceId, ')
          ..write('investmentId: $investmentId, ')
          ..write('debtInstallmentId: $debtInstallmentId, ')
          ..write('recurrence: $recurrence, ')
          ..write('recurrenceGroupId: $recurrenceGroupId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppUsageDaysTable extends AppUsageDays
    with TableInfo<$AppUsageDaysTable, AppUsageDay> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppUsageDaysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<String> day = GeneratedColumn<String>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [day];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_usage_days';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppUsageDay> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {day};
  @override
  AppUsageDay map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppUsageDay(
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day'],
      )!,
    );
  }

  @override
  $AppUsageDaysTable createAlias(String alias) {
    return $AppUsageDaysTable(attachedDatabase, alias);
  }
}

class AppUsageDay extends DataClass implements Insertable<AppUsageDay> {
  /// 'YYYY-MM-DD', hora local.
  final String day;
  const AppUsageDay({required this.day});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['day'] = Variable<String>(day);
    return map;
  }

  AppUsageDaysCompanion toCompanion(bool nullToAbsent) {
    return AppUsageDaysCompanion(day: Value(day));
  }

  factory AppUsageDay.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppUsageDay(day: serializer.fromJson<String>(json['day']));
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'day': serializer.toJson<String>(day)};
  }

  AppUsageDay copyWith({String? day}) => AppUsageDay(day: day ?? this.day);
  AppUsageDay copyWithCompanion(AppUsageDaysCompanion data) {
    return AppUsageDay(day: data.day.present ? data.day.value : this.day);
  }

  @override
  String toString() {
    return (StringBuffer('AppUsageDay(')
          ..write('day: $day')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => day.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is AppUsageDay && other.day == this.day);
}

class AppUsageDaysCompanion extends UpdateCompanion<AppUsageDay> {
  final Value<String> day;
  final Value<int> rowid;
  const AppUsageDaysCompanion({
    this.day = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppUsageDaysCompanion.insert({
    required String day,
    this.rowid = const Value.absent(),
  }) : day = Value(day);
  static Insertable<AppUsageDay> custom({
    Expression<String>? day,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (day != null) 'day': day,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppUsageDaysCompanion copyWith({Value<String>? day, Value<int>? rowid}) {
    return AppUsageDaysCompanion(
      day: day ?? this.day,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (day.present) {
      map['day'] = Variable<String>(day.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppUsageDaysCompanion(')
          ..write('day: $day, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ErrorLogTable extends ErrorLog
    with TableInfo<$ErrorLogTable, ErrorLogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ErrorLogTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<String> occurredAt = GeneratedColumn<String>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _screenMeta = const VerificationMeta('screen');
  @override
  late final GeneratedColumn<String> screen = GeneratedColumn<String>(
    'screen',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stackMeta = const VerificationMeta('stack');
  @override
  late final GeneratedColumn<String> stack = GeneratedColumn<String>(
    'stack',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, occurredAt, type, screen, stack];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'error_log';
  @override
  VerificationContext validateIntegrity(
    Insertable<ErrorLogData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('screen')) {
      context.handle(
        _screenMeta,
        screen.isAcceptableOrUnknown(data['screen']!, _screenMeta),
      );
    }
    if (data.containsKey('stack')) {
      context.handle(
        _stackMeta,
        stack.isAcceptableOrUnknown(data['stack']!, _stackMeta),
      );
    } else if (isInserting) {
      context.missing(_stackMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ErrorLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ErrorLogData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}occurred_at'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      screen: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}screen'],
      ),
      stack: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stack'],
      )!,
    );
  }

  @override
  $ErrorLogTable createAlias(String alias) {
    return $ErrorLogTable(attachedDatabase, alias);
  }
}

class ErrorLogData extends DataClass implements Insertable<ErrorLogData> {
  final String id;

  /// ISO 8601 local.
  final String occurredAt;

  /// Nome da exceção.
  final String type;

  /// Rota onde ocorreu.
  final String? screen;
  final String stack;
  const ErrorLogData({
    required this.id,
    required this.occurredAt,
    required this.type,
    this.screen,
    required this.stack,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['occurred_at'] = Variable<String>(occurredAt);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || screen != null) {
      map['screen'] = Variable<String>(screen);
    }
    map['stack'] = Variable<String>(stack);
    return map;
  }

  ErrorLogCompanion toCompanion(bool nullToAbsent) {
    return ErrorLogCompanion(
      id: Value(id),
      occurredAt: Value(occurredAt),
      type: Value(type),
      screen: screen == null && nullToAbsent
          ? const Value.absent()
          : Value(screen),
      stack: Value(stack),
    );
  }

  factory ErrorLogData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ErrorLogData(
      id: serializer.fromJson<String>(json['id']),
      occurredAt: serializer.fromJson<String>(json['occurredAt']),
      type: serializer.fromJson<String>(json['type']),
      screen: serializer.fromJson<String?>(json['screen']),
      stack: serializer.fromJson<String>(json['stack']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'occurredAt': serializer.toJson<String>(occurredAt),
      'type': serializer.toJson<String>(type),
      'screen': serializer.toJson<String?>(screen),
      'stack': serializer.toJson<String>(stack),
    };
  }

  ErrorLogData copyWith({
    String? id,
    String? occurredAt,
    String? type,
    Value<String?> screen = const Value.absent(),
    String? stack,
  }) => ErrorLogData(
    id: id ?? this.id,
    occurredAt: occurredAt ?? this.occurredAt,
    type: type ?? this.type,
    screen: screen.present ? screen.value : this.screen,
    stack: stack ?? this.stack,
  );
  ErrorLogData copyWithCompanion(ErrorLogCompanion data) {
    return ErrorLogData(
      id: data.id.present ? data.id.value : this.id,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
      type: data.type.present ? data.type.value : this.type,
      screen: data.screen.present ? data.screen.value : this.screen,
      stack: data.stack.present ? data.stack.value : this.stack,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ErrorLogData(')
          ..write('id: $id, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('type: $type, ')
          ..write('screen: $screen, ')
          ..write('stack: $stack')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, occurredAt, type, screen, stack);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ErrorLogData &&
          other.id == this.id &&
          other.occurredAt == this.occurredAt &&
          other.type == this.type &&
          other.screen == this.screen &&
          other.stack == this.stack);
}

class ErrorLogCompanion extends UpdateCompanion<ErrorLogData> {
  final Value<String> id;
  final Value<String> occurredAt;
  final Value<String> type;
  final Value<String?> screen;
  final Value<String> stack;
  final Value<int> rowid;
  const ErrorLogCompanion({
    this.id = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.type = const Value.absent(),
    this.screen = const Value.absent(),
    this.stack = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ErrorLogCompanion.insert({
    required String id,
    required String occurredAt,
    required String type,
    this.screen = const Value.absent(),
    required String stack,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       occurredAt = Value(occurredAt),
       type = Value(type),
       stack = Value(stack);
  static Insertable<ErrorLogData> custom({
    Expression<String>? id,
    Expression<String>? occurredAt,
    Expression<String>? type,
    Expression<String>? screen,
    Expression<String>? stack,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (type != null) 'type': type,
      if (screen != null) 'screen': screen,
      if (stack != null) 'stack': stack,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ErrorLogCompanion copyWith({
    Value<String>? id,
    Value<String>? occurredAt,
    Value<String>? type,
    Value<String?>? screen,
    Value<String>? stack,
    Value<int>? rowid,
  }) {
    return ErrorLogCompanion(
      id: id ?? this.id,
      occurredAt: occurredAt ?? this.occurredAt,
      type: type ?? this.type,
      screen: screen ?? this.screen,
      stack: stack ?? this.stack,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<String>(occurredAt.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (screen.present) {
      map['screen'] = Variable<String>(screen.value);
    }
    if (stack.present) {
      map['stack'] = Variable<String>(stack.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ErrorLogCompanion(')
          ..write('id: $id, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('type: $type, ')
          ..write('screen: $screen, ')
          ..write('stack: $stack, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InvestmentBalancesTable extends InvestmentBalances
    with TableInfo<$InvestmentBalancesTable, InvestmentBalance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvestmentBalancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _investmentIdMeta = const VerificationMeta(
    'investmentId',
  );
  @override
  late final GeneratedColumn<String> investmentId = GeneratedColumn<String>(
    'investment_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES investments (id)',
    ),
  );
  static const VerificationMeta _balanceCentsMeta = const VerificationMeta(
    'balanceCents',
  );
  @override
  late final GeneratedColumn<int> balanceCents = GeneratedColumn<int>(
    'balance_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordedOnMeta = const VerificationMeta(
    'recordedOn',
  );
  @override
  late final GeneratedColumn<String> recordedOn = GeneratedColumn<String>(
    'recorded_on',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    investmentId,
    balanceCents,
    recordedOn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'investment_balances';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvestmentBalance> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('investment_id')) {
      context.handle(
        _investmentIdMeta,
        investmentId.isAcceptableOrUnknown(
          data['investment_id']!,
          _investmentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_investmentIdMeta);
    }
    if (data.containsKey('balance_cents')) {
      context.handle(
        _balanceCentsMeta,
        balanceCents.isAcceptableOrUnknown(
          data['balance_cents']!,
          _balanceCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_balanceCentsMeta);
    }
    if (data.containsKey('recorded_on')) {
      context.handle(
        _recordedOnMeta,
        recordedOn.isAcceptableOrUnknown(data['recorded_on']!, _recordedOnMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedOnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvestmentBalance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvestmentBalance(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      investmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}investment_id'],
      )!,
      balanceCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}balance_cents'],
      )!,
      recordedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recorded_on'],
      )!,
    );
  }

  @override
  $InvestmentBalancesTable createAlias(String alias) {
    return $InvestmentBalancesTable(attachedDatabase, alias);
  }
}

class InvestmentBalance extends DataClass
    implements Insertable<InvestmentBalance> {
  final String id;
  final String investmentId;
  final int balanceCents;
  final String recordedOn;
  const InvestmentBalance({
    required this.id,
    required this.investmentId,
    required this.balanceCents,
    required this.recordedOn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['investment_id'] = Variable<String>(investmentId);
    map['balance_cents'] = Variable<int>(balanceCents);
    map['recorded_on'] = Variable<String>(recordedOn);
    return map;
  }

  InvestmentBalancesCompanion toCompanion(bool nullToAbsent) {
    return InvestmentBalancesCompanion(
      id: Value(id),
      investmentId: Value(investmentId),
      balanceCents: Value(balanceCents),
      recordedOn: Value(recordedOn),
    );
  }

  factory InvestmentBalance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvestmentBalance(
      id: serializer.fromJson<String>(json['id']),
      investmentId: serializer.fromJson<String>(json['investmentId']),
      balanceCents: serializer.fromJson<int>(json['balanceCents']),
      recordedOn: serializer.fromJson<String>(json['recordedOn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'investmentId': serializer.toJson<String>(investmentId),
      'balanceCents': serializer.toJson<int>(balanceCents),
      'recordedOn': serializer.toJson<String>(recordedOn),
    };
  }

  InvestmentBalance copyWith({
    String? id,
    String? investmentId,
    int? balanceCents,
    String? recordedOn,
  }) => InvestmentBalance(
    id: id ?? this.id,
    investmentId: investmentId ?? this.investmentId,
    balanceCents: balanceCents ?? this.balanceCents,
    recordedOn: recordedOn ?? this.recordedOn,
  );
  InvestmentBalance copyWithCompanion(InvestmentBalancesCompanion data) {
    return InvestmentBalance(
      id: data.id.present ? data.id.value : this.id,
      investmentId: data.investmentId.present
          ? data.investmentId.value
          : this.investmentId,
      balanceCents: data.balanceCents.present
          ? data.balanceCents.value
          : this.balanceCents,
      recordedOn: data.recordedOn.present
          ? data.recordedOn.value
          : this.recordedOn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvestmentBalance(')
          ..write('id: $id, ')
          ..write('investmentId: $investmentId, ')
          ..write('balanceCents: $balanceCents, ')
          ..write('recordedOn: $recordedOn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, investmentId, balanceCents, recordedOn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvestmentBalance &&
          other.id == this.id &&
          other.investmentId == this.investmentId &&
          other.balanceCents == this.balanceCents &&
          other.recordedOn == this.recordedOn);
}

class InvestmentBalancesCompanion extends UpdateCompanion<InvestmentBalance> {
  final Value<String> id;
  final Value<String> investmentId;
  final Value<int> balanceCents;
  final Value<String> recordedOn;
  final Value<int> rowid;
  const InvestmentBalancesCompanion({
    this.id = const Value.absent(),
    this.investmentId = const Value.absent(),
    this.balanceCents = const Value.absent(),
    this.recordedOn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvestmentBalancesCompanion.insert({
    required String id,
    required String investmentId,
    required int balanceCents,
    required String recordedOn,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       investmentId = Value(investmentId),
       balanceCents = Value(balanceCents),
       recordedOn = Value(recordedOn);
  static Insertable<InvestmentBalance> custom({
    Expression<String>? id,
    Expression<String>? investmentId,
    Expression<int>? balanceCents,
    Expression<String>? recordedOn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (investmentId != null) 'investment_id': investmentId,
      if (balanceCents != null) 'balance_cents': balanceCents,
      if (recordedOn != null) 'recorded_on': recordedOn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvestmentBalancesCompanion copyWith({
    Value<String>? id,
    Value<String>? investmentId,
    Value<int>? balanceCents,
    Value<String>? recordedOn,
    Value<int>? rowid,
  }) {
    return InvestmentBalancesCompanion(
      id: id ?? this.id,
      investmentId: investmentId ?? this.investmentId,
      balanceCents: balanceCents ?? this.balanceCents,
      recordedOn: recordedOn ?? this.recordedOn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (investmentId.present) {
      map['investment_id'] = Variable<String>(investmentId.value);
    }
    if (balanceCents.present) {
      map['balance_cents'] = Variable<int>(balanceCents.value);
    }
    if (recordedOn.present) {
      map['recorded_on'] = Variable<String>(recordedOn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvestmentBalancesCompanion(')
          ..write('id: $id, ')
          ..write('investmentId: $investmentId, ')
          ..write('balanceCents: $balanceCents, ')
          ..write('recordedOn: $recordedOn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $NichesTable niches = $NichesTable(this);
  late final $IncomeSourcesTable incomeSources = $IncomeSourcesTable(this);
  late final $InvestmentsTable investments = $InvestmentsTable(this);
  late final $DebtsTable debts = $DebtsTable(this);
  late final $DebtInstallmentsTable debtInstallments = $DebtInstallmentsTable(
    this,
  );
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $AppUsageDaysTable appUsageDays = $AppUsageDaysTable(this);
  late final $ErrorLogTable errorLog = $ErrorLogTable(this);
  late final $InvestmentBalancesTable investmentBalances =
      $InvestmentBalancesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    niches,
    incomeSources,
    investments,
    debts,
    debtInstallments,
    transactions,
    appUsageDays,
    errorLog,
    investmentBalances,
  ];
}

typedef $$NichesTableCreateCompanionBuilder = NichesCompanion Function({
  required String id,
  required String name,
  required String icon,
  required int color,
  required String kind,
  required int sortOrder,
  Value<int> rowid,
});
typedef $$NichesTableUpdateCompanionBuilder = NichesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> icon,
  Value<int> color,
  Value<String> kind,
  Value<int> sortOrder,
  Value<int> rowid,
});

class $$NichesTableFilterComposer
    extends Composer<_$AppDatabase, $NichesTable> {
  $$NichesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NichesTableOrderingComposer
    extends Composer<_$AppDatabase, $NichesTable> {
  $$NichesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NichesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NichesTable> {
  $$NichesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);
}

class $$NichesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NichesTable,
          Niche,
          $$NichesTableFilterComposer,
          $$NichesTableOrderingComposer,
          $$NichesTableAnnotationComposer,
          $$NichesTableCreateCompanionBuilder,
          $$NichesTableUpdateCompanionBuilder,
          (Niche, BaseReferences<_$AppDatabase, $NichesTable, Niche>),
          Niche,
          PrefetchHooks Function()
        > {
  $$NichesTableTableManager(_$AppDatabase db, $NichesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NichesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NichesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NichesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NichesCompanion(
                id: id,
                name: name,
                icon: icon,
                color: color,
                kind: kind,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String icon,
                required int color,
                required String kind,
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => NichesCompanion.insert(
                id: id,
                name: name,
                icon: icon,
                color: color,
                kind: kind,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NichesTable, Niche>(table),
                  BaseReferences<_$AppDatabase, $NichesTable, Niche>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NichesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NichesTable,
      Niche,
      $$NichesTableFilterComposer,
      $$NichesTableOrderingComposer,
      $$NichesTableAnnotationComposer,
      $$NichesTableCreateCompanionBuilder,
      $$NichesTableUpdateCompanionBuilder,
      (Niche, BaseReferences<_$AppDatabase, $NichesTable, Niche>),
      Niche,
      PrefetchHooks Function()
    >;
typedef $$IncomeSourcesTableCreateCompanionBuilder =
    IncomeSourcesCompanion Function({
      required String id,
      required String name,
      required String type,
      Value<int?> expectedCents,
      Value<bool> isRecurring,
      Value<int?> expectedDay,
      Value<String?> archivedAt,
      required String createdAt,
      Value<int> rowid,
    });
typedef $$IncomeSourcesTableUpdateCompanionBuilder =
    IncomeSourcesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> type,
      Value<int?> expectedCents,
      Value<bool> isRecurring,
      Value<int?> expectedDay,
      Value<String?> archivedAt,
      Value<String> createdAt,
      Value<int> rowid,
    });

final class $$IncomeSourcesTableReferences
    extends BaseReferences<_$AppDatabase, $IncomeSourcesTable, IncomeSource> {
  $$IncomeSourcesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: 'income_sources__id__transactions__income_source_id',
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.incomeSourceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$IncomeSourcesTableFilterComposer
    extends Composer<_$AppDatabase, $IncomeSourcesTable> {
  $$IncomeSourcesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expectedCents => $composableBuilder(
    column: $table.expectedCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expectedDay => $composableBuilder(
    column: $table.expectedDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.incomeSourceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$IncomeSourcesTableOrderingComposer
    extends Composer<_$AppDatabase, $IncomeSourcesTable> {
  $$IncomeSourcesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expectedCents => $composableBuilder(
    column: $table.expectedCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expectedDay => $composableBuilder(
    column: $table.expectedDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IncomeSourcesTableAnnotationComposer
    extends Composer<_$AppDatabase, $IncomeSourcesTable> {
  $$IncomeSourcesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get expectedCents => $composableBuilder(
    column: $table.expectedCents,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => column,
  );

  GeneratedColumn<int> get expectedDay => $composableBuilder(
    column: $table.expectedDay,
    builder: (column) => column,
  );

  GeneratedColumn<String> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.incomeSourceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$IncomeSourcesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IncomeSourcesTable,
          IncomeSource,
          $$IncomeSourcesTableFilterComposer,
          $$IncomeSourcesTableOrderingComposer,
          $$IncomeSourcesTableAnnotationComposer,
          $$IncomeSourcesTableCreateCompanionBuilder,
          $$IncomeSourcesTableUpdateCompanionBuilder,
          (IncomeSource, $$IncomeSourcesTableReferences),
          IncomeSource,
          PrefetchHooks Function({bool transactionsRefs})
        > {
  $$IncomeSourcesTableTableManager(_$AppDatabase db, $IncomeSourcesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IncomeSourcesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IncomeSourcesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IncomeSourcesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int?> expectedCents = const Value.absent(),
                Value<bool> isRecurring = const Value.absent(),
                Value<int?> expectedDay = const Value.absent(),
                Value<String?> archivedAt = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IncomeSourcesCompanion(
                id: id,
                name: name,
                type: type,
                expectedCents: expectedCents,
                isRecurring: isRecurring,
                expectedDay: expectedDay,
                archivedAt: archivedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String type,
                Value<int?> expectedCents = const Value.absent(),
                Value<bool> isRecurring = const Value.absent(),
                Value<int?> expectedDay = const Value.absent(),
                Value<String?> archivedAt = const Value.absent(),
                required String createdAt,
                Value<int> rowid = const Value.absent(),
              }) => IncomeSourcesCompanion.insert(
                id: id,
                name: name,
                type: type,
                expectedCents: expectedCents,
                isRecurring: isRecurring,
                expectedDay: expectedDay,
                archivedAt: archivedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$IncomeSourcesTable, IncomeSource>(table),
                  $$IncomeSourcesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({transactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (transactionsRefs) db.transactions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionsRefs)
                    await $_getPrefetchedData<
                      IncomeSource,
                      $IncomeSourcesTable,
                      Transaction
                    >(
                      currentTable: table,
                      referencedTable: $$IncomeSourcesTableReferences
                          ._transactionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$IncomeSourcesTableReferences(
                            db,
                            table,
                            p0,
                          ).transactionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.incomeSourceId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$IncomeSourcesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IncomeSourcesTable,
      IncomeSource,
      $$IncomeSourcesTableFilterComposer,
      $$IncomeSourcesTableOrderingComposer,
      $$IncomeSourcesTableAnnotationComposer,
      $$IncomeSourcesTableCreateCompanionBuilder,
      $$IncomeSourcesTableUpdateCompanionBuilder,
      (IncomeSource, $$IncomeSourcesTableReferences),
      IncomeSource,
      PrefetchHooks Function({bool transactionsRefs})
    >;
typedef $$InvestmentsTableCreateCompanionBuilder =
    InvestmentsCompanion Function({
      required String id,
      required String name,
      required String type,
      Value<int> balanceCents,
      Value<String?> balanceUpdatedAt,
      Value<String?> archivedAt,
      required String createdAt,
      Value<int> rowid,
    });
typedef $$InvestmentsTableUpdateCompanionBuilder =
    InvestmentsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> type,
      Value<int> balanceCents,
      Value<String?> balanceUpdatedAt,
      Value<String?> archivedAt,
      Value<String> createdAt,
      Value<int> rowid,
    });

final class $$InvestmentsTableReferences
    extends BaseReferences<_$AppDatabase, $InvestmentsTable, Investment> {
  $$InvestmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: 'investments__id__transactions__investment_id',
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.investmentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InvestmentBalancesTable, List<InvestmentBalance>>
  _investmentBalancesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.investmentBalances,
        aliasName: 'investments__id__investment_balances__investment_id',
      );

  $$InvestmentBalancesTableProcessedTableManager get investmentBalancesRefs {
    final manager = $$InvestmentBalancesTableTableManager(
      $_db,
      $_db.investmentBalances,
    ).filter((f) => f.investmentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _investmentBalancesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InvestmentsTableFilterComposer
    extends Composer<_$AppDatabase, $InvestmentsTable> {
  $$InvestmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get balanceCents => $composableBuilder(
    column: $table.balanceCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get balanceUpdatedAt => $composableBuilder(
    column: $table.balanceUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.investmentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> investmentBalancesRefs(
    Expression<bool> Function($$InvestmentBalancesTableFilterComposer f) f,
  ) {
    final $$InvestmentBalancesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.investmentBalances,
      getReferencedColumn: (t) => t.investmentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvestmentBalancesTableFilterComposer(
            $db: $db,
            $table: $db.investmentBalances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvestmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $InvestmentsTable> {
  $$InvestmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get balanceCents => $composableBuilder(
    column: $table.balanceCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get balanceUpdatedAt => $composableBuilder(
    column: $table.balanceUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InvestmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvestmentsTable> {
  $$InvestmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get balanceCents => $composableBuilder(
    column: $table.balanceCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get balanceUpdatedAt => $composableBuilder(
    column: $table.balanceUpdatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.investmentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> investmentBalancesRefs<T extends Object>(
    Expression<T> Function($$InvestmentBalancesTableAnnotationComposer a) f,
  ) {
    final $$InvestmentBalancesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.investmentBalances,
          getReferencedColumn: (t) => t.investmentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InvestmentBalancesTableAnnotationComposer(
                $db: $db,
                $table: $db.investmentBalances,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$InvestmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvestmentsTable,
          Investment,
          $$InvestmentsTableFilterComposer,
          $$InvestmentsTableOrderingComposer,
          $$InvestmentsTableAnnotationComposer,
          $$InvestmentsTableCreateCompanionBuilder,
          $$InvestmentsTableUpdateCompanionBuilder,
          (Investment, $$InvestmentsTableReferences),
          Investment,
          PrefetchHooks Function({
            bool transactionsRefs,
            bool investmentBalancesRefs,
          })
        > {
  $$InvestmentsTableTableManager(_$AppDatabase db, $InvestmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvestmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvestmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvestmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> balanceCents = const Value.absent(),
                Value<String?> balanceUpdatedAt = const Value.absent(),
                Value<String?> archivedAt = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvestmentsCompanion(
                id: id,
                name: name,
                type: type,
                balanceCents: balanceCents,
                balanceUpdatedAt: balanceUpdatedAt,
                archivedAt: archivedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String type,
                Value<int> balanceCents = const Value.absent(),
                Value<String?> balanceUpdatedAt = const Value.absent(),
                Value<String?> archivedAt = const Value.absent(),
                required String createdAt,
                Value<int> rowid = const Value.absent(),
              }) => InvestmentsCompanion.insert(
                id: id,
                name: name,
                type: type,
                balanceCents: balanceCents,
                balanceUpdatedAt: balanceUpdatedAt,
                archivedAt: archivedAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InvestmentsTable, Investment>(table),
                  $$InvestmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({transactionsRefs = false, investmentBalancesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (transactionsRefs) db.transactions,
                    if (investmentBalancesRefs) db.investmentBalances,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (transactionsRefs)
                        await $_getPrefetchedData<
                          Investment,
                          $InvestmentsTable,
                          Transaction
                        >(
                          currentTable: table,
                          referencedTable: $$InvestmentsTableReferences
                              ._transactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvestmentsTableReferences(
                                db,
                                table,
                                p0,
                              ).transactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.investmentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (investmentBalancesRefs)
                        await $_getPrefetchedData<
                          Investment,
                          $InvestmentsTable,
                          InvestmentBalance
                        >(
                          currentTable: table,
                          referencedTable: $$InvestmentsTableReferences
                              ._investmentBalancesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvestmentsTableReferences(
                                db,
                                table,
                                p0,
                              ).investmentBalancesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.investmentId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$InvestmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvestmentsTable,
      Investment,
      $$InvestmentsTableFilterComposer,
      $$InvestmentsTableOrderingComposer,
      $$InvestmentsTableAnnotationComposer,
      $$InvestmentsTableCreateCompanionBuilder,
      $$InvestmentsTableUpdateCompanionBuilder,
      (Investment, $$InvestmentsTableReferences),
      Investment,
      PrefetchHooks Function({
        bool transactionsRefs,
        bool investmentBalancesRefs,
      })
    >;
typedef $$DebtsTableCreateCompanionBuilder = DebtsCompanion Function({
  required String id,
  required String name,
  Value<String?> creditor,
  required int totalCents,
  required int installmentCount,
  required int installmentCents,
  required String firstDueOn,
  Value<String?> settledAt,
  required String createdAt,
  Value<int> rowid,
});
typedef $$DebtsTableUpdateCompanionBuilder = DebtsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> creditor,
  Value<int> totalCents,
  Value<int> installmentCount,
  Value<int> installmentCents,
  Value<String> firstDueOn,
  Value<String?> settledAt,
  Value<String> createdAt,
  Value<int> rowid,
});

final class $$DebtsTableReferences
    extends BaseReferences<_$AppDatabase, $DebtsTable, Debt> {
  $$DebtsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DebtInstallmentsTable, List<DebtInstallment>>
  _debtInstallmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.debtInstallments,
    aliasName: 'debts__id__debt_installments__debt_id',
  );

  $$DebtInstallmentsTableProcessedTableManager get debtInstallmentsRefs {
    final manager = $$DebtInstallmentsTableTableManager(
      $_db,
      $_db.debtInstallments,
    ).filter((f) => f.debtId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _debtInstallmentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DebtsTableFilterComposer extends Composer<_$AppDatabase, $DebtsTable> {
  $$DebtsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creditor => $composableBuilder(
    column: $table.creditor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCents => $composableBuilder(
    column: $table.totalCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get installmentCount => $composableBuilder(
    column: $table.installmentCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get installmentCents => $composableBuilder(
    column: $table.installmentCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstDueOn => $composableBuilder(
    column: $table.firstDueOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get settledAt => $composableBuilder(
    column: $table.settledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> debtInstallmentsRefs(
    Expression<bool> Function($$DebtInstallmentsTableFilterComposer f) f,
  ) {
    final $$DebtInstallmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.debtInstallments,
      getReferencedColumn: (t) => t.debtId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DebtInstallmentsTableFilterComposer(
            $db: $db,
            $table: $db.debtInstallments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DebtsTableOrderingComposer
    extends Composer<_$AppDatabase, $DebtsTable> {
  $$DebtsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creditor => $composableBuilder(
    column: $table.creditor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCents => $composableBuilder(
    column: $table.totalCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get installmentCount => $composableBuilder(
    column: $table.installmentCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get installmentCents => $composableBuilder(
    column: $table.installmentCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstDueOn => $composableBuilder(
    column: $table.firstDueOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get settledAt => $composableBuilder(
    column: $table.settledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DebtsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DebtsTable> {
  $$DebtsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get creditor =>
      $composableBuilder(column: $table.creditor, builder: (column) => column);

  GeneratedColumn<int> get totalCents => $composableBuilder(
    column: $table.totalCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get installmentCount => $composableBuilder(
    column: $table.installmentCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get installmentCents => $composableBuilder(
    column: $table.installmentCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get firstDueOn => $composableBuilder(
    column: $table.firstDueOn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get settledAt =>
      $composableBuilder(column: $table.settledAt, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> debtInstallmentsRefs<T extends Object>(
    Expression<T> Function($$DebtInstallmentsTableAnnotationComposer a) f,
  ) {
    final $$DebtInstallmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.debtInstallments,
      getReferencedColumn: (t) => t.debtId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DebtInstallmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.debtInstallments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DebtsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DebtsTable,
          Debt,
          $$DebtsTableFilterComposer,
          $$DebtsTableOrderingComposer,
          $$DebtsTableAnnotationComposer,
          $$DebtsTableCreateCompanionBuilder,
          $$DebtsTableUpdateCompanionBuilder,
          (Debt, $$DebtsTableReferences),
          Debt,
          PrefetchHooks Function({bool debtInstallmentsRefs})
        > {
  $$DebtsTableTableManager(_$AppDatabase db, $DebtsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DebtsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DebtsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DebtsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> creditor = const Value.absent(),
                Value<int> totalCents = const Value.absent(),
                Value<int> installmentCount = const Value.absent(),
                Value<int> installmentCents = const Value.absent(),
                Value<String> firstDueOn = const Value.absent(),
                Value<String?> settledAt = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DebtsCompanion(
                id: id,
                name: name,
                creditor: creditor,
                totalCents: totalCents,
                installmentCount: installmentCount,
                installmentCents: installmentCents,
                firstDueOn: firstDueOn,
                settledAt: settledAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> creditor = const Value.absent(),
                required int totalCents,
                required int installmentCount,
                required int installmentCents,
                required String firstDueOn,
                Value<String?> settledAt = const Value.absent(),
                required String createdAt,
                Value<int> rowid = const Value.absent(),
              }) => DebtsCompanion.insert(
                id: id,
                name: name,
                creditor: creditor,
                totalCents: totalCents,
                installmentCount: installmentCount,
                installmentCents: installmentCents,
                firstDueOn: firstDueOn,
                settledAt: settledAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DebtsTable, Debt>(table),
                  $$DebtsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({debtInstallmentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (debtInstallmentsRefs) db.debtInstallments,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (debtInstallmentsRefs)
                    await $_getPrefetchedData<
                      Debt,
                      $DebtsTable,
                      DebtInstallment
                    >(
                      currentTable: table,
                      referencedTable: $$DebtsTableReferences
                          ._debtInstallmentsRefsTable(db),
                      managerFromTypedResult: (p0) => $$DebtsTableReferences(
                        db,
                        table,
                        p0,
                      ).debtInstallmentsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.debtId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DebtsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DebtsTable,
      Debt,
      $$DebtsTableFilterComposer,
      $$DebtsTableOrderingComposer,
      $$DebtsTableAnnotationComposer,
      $$DebtsTableCreateCompanionBuilder,
      $$DebtsTableUpdateCompanionBuilder,
      (Debt, $$DebtsTableReferences),
      Debt,
      PrefetchHooks Function({bool debtInstallmentsRefs})
    >;
typedef $$DebtInstallmentsTableCreateCompanionBuilder =
    DebtInstallmentsCompanion Function({
      required String id,
      required String debtId,
      required int number,
      required String dueOn,
      required int amountCents,
      Value<String?> paidOn,
      Value<int> rowid,
    });
typedef $$DebtInstallmentsTableUpdateCompanionBuilder =
    DebtInstallmentsCompanion Function({
      Value<String> id,
      Value<String> debtId,
      Value<int> number,
      Value<String> dueOn,
      Value<int> amountCents,
      Value<String?> paidOn,
      Value<int> rowid,
    });

final class $$DebtInstallmentsTableReferences
    extends
        BaseReferences<_$AppDatabase, $DebtInstallmentsTable, DebtInstallment> {
  $$DebtInstallmentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DebtsTable _debtIdTable(_$AppDatabase db) =>
      db.debts.createAlias('debt_installments__debt_id__debts__id');

  $$DebtsTableProcessedTableManager get debtId {
    final $_column = $_itemColumn<String>('debt_id')!;

    final manager = $$DebtsTableTableManager(
      $_db,
      $_db.debts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_debtIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TransactionsTable, List<Transaction>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: 'debt_installments__id__transactions__debt_installment_id',
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager($_db, $_db.transactions)
        .filter(
          (f) => f.debtInstallmentId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DebtInstallmentsTableFilterComposer
    extends Composer<_$AppDatabase, $DebtInstallmentsTable> {
  $$DebtInstallmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dueOn => $composableBuilder(
    column: $table.dueOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paidOn => $composableBuilder(
    column: $table.paidOn,
    builder: (column) => ColumnFilters(column),
  );

  $$DebtsTableFilterComposer get debtId {
    final $$DebtsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.debtId,
      referencedTable: $db.debts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DebtsTableFilterComposer(
            $db: $db,
            $table: $db.debts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.debtInstallmentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableFilterComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DebtInstallmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DebtInstallmentsTable> {
  $$DebtInstallmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dueOn => $composableBuilder(
    column: $table.dueOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paidOn => $composableBuilder(
    column: $table.paidOn,
    builder: (column) => ColumnOrderings(column),
  );

  $$DebtsTableOrderingComposer get debtId {
    final $$DebtsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.debtId,
      referencedTable: $db.debts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DebtsTableOrderingComposer(
            $db: $db,
            $table: $db.debts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DebtInstallmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DebtInstallmentsTable> {
  $$DebtInstallmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get dueOn =>
      $composableBuilder(column: $table.dueOn, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paidOn =>
      $composableBuilder(column: $table.paidOn, builder: (column) => column);

  $$DebtsTableAnnotationComposer get debtId {
    final $$DebtsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.debtId,
      referencedTable: $db.debts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DebtsTableAnnotationComposer(
            $db: $db,
            $table: $db.debts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.debtInstallmentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.transactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DebtInstallmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DebtInstallmentsTable,
          DebtInstallment,
          $$DebtInstallmentsTableFilterComposer,
          $$DebtInstallmentsTableOrderingComposer,
          $$DebtInstallmentsTableAnnotationComposer,
          $$DebtInstallmentsTableCreateCompanionBuilder,
          $$DebtInstallmentsTableUpdateCompanionBuilder,
          (DebtInstallment, $$DebtInstallmentsTableReferences),
          DebtInstallment,
          PrefetchHooks Function({bool debtId, bool transactionsRefs})
        > {
  $$DebtInstallmentsTableTableManager(
    _$AppDatabase db,
    $DebtInstallmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DebtInstallmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DebtInstallmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DebtInstallmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> debtId = const Value.absent(),
                Value<int> number = const Value.absent(),
                Value<String> dueOn = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<String?> paidOn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DebtInstallmentsCompanion(
                id: id,
                debtId: debtId,
                number: number,
                dueOn: dueOn,
                amountCents: amountCents,
                paidOn: paidOn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String debtId,
                required int number,
                required String dueOn,
                required int amountCents,
                Value<String?> paidOn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DebtInstallmentsCompanion.insert(
                id: id,
                debtId: debtId,
                number: number,
                dueOn: dueOn,
                amountCents: amountCents,
                paidOn: paidOn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DebtInstallmentsTable, DebtInstallment>(table),
                  $$DebtInstallmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({debtId = false, transactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (transactionsRefs) db.transactions],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (debtId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.debtId,
                        referencedTable: $$DebtInstallmentsTableReferences
                            ._debtIdTable(db),
                        referencedColumn: $$DebtInstallmentsTableReferences
                            ._debtIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionsRefs)
                    await $_getPrefetchedData<
                      DebtInstallment,
                      $DebtInstallmentsTable,
                      Transaction
                    >(
                      currentTable: table,
                      referencedTable: $$DebtInstallmentsTableReferences
                          ._transactionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$DebtInstallmentsTableReferences(
                            db,
                            table,
                            p0,
                          ).transactionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.debtInstallmentId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DebtInstallmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DebtInstallmentsTable,
      DebtInstallment,
      $$DebtInstallmentsTableFilterComposer,
      $$DebtInstallmentsTableOrderingComposer,
      $$DebtInstallmentsTableAnnotationComposer,
      $$DebtInstallmentsTableCreateCompanionBuilder,
      $$DebtInstallmentsTableUpdateCompanionBuilder,
      (DebtInstallment, $$DebtInstallmentsTableReferences),
      DebtInstallment,
      PrefetchHooks Function({bool debtId, bool transactionsRefs})
    >;
typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      required String id,
      required String kind,
      required int amountCents,
      required String occurredOn,
      Value<String?> description,
      Value<String?> descriptionNorm,
      Value<String?> paymentMethod,
      Value<String?> nicheId,
      Value<String?> incomeSourceId,
      Value<String?> investmentId,
      Value<String?> debtInstallmentId,
      Value<String?> recurrence,
      Value<String?> recurrenceGroupId,
      required String createdAt,
      required String updatedAt,
      Value<String?> deletedAt,
      Value<int> rowid,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<String> id,
      Value<String> kind,
      Value<int> amountCents,
      Value<String> occurredOn,
      Value<String?> description,
      Value<String?> descriptionNorm,
      Value<String?> paymentMethod,
      Value<String?> nicheId,
      Value<String?> incomeSourceId,
      Value<String?> investmentId,
      Value<String?> debtInstallmentId,
      Value<String?> recurrence,
      Value<String?> recurrenceGroupId,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<String?> deletedAt,
      Value<int> rowid,
    });

final class $$TransactionsTableReferences
    extends BaseReferences<_$AppDatabase, $TransactionsTable, Transaction> {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $IncomeSourcesTable _incomeSourceIdTable(_$AppDatabase db) => db
      .incomeSources
      .createAlias('transactions__income_source_id__income_sources__id');

  $$IncomeSourcesTableProcessedTableManager? get incomeSourceId {
    final $_column = $_itemColumn<String>('income_source_id');
    if ($_column == null) return null;
    final manager = $$IncomeSourcesTableTableManager(
      $_db,
      $_db.incomeSources,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_incomeSourceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $InvestmentsTable _investmentIdTable(_$AppDatabase db) => db
      .investments
      .createAlias('transactions__investment_id__investments__id');

  $$InvestmentsTableProcessedTableManager? get investmentId {
    final $_column = $_itemColumn<String>('investment_id');
    if ($_column == null) return null;
    final manager = $$InvestmentsTableTableManager(
      $_db,
      $_db.investments,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_investmentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DebtInstallmentsTable _debtInstallmentIdTable(_$AppDatabase db) => db
      .debtInstallments
      .createAlias('transactions__debt_installment_id__debt_installments__id');

  $$DebtInstallmentsTableProcessedTableManager? get debtInstallmentId {
    final $_column = $_itemColumn<String>('debt_installment_id');
    if ($_column == null) return null;
    final manager = $$DebtInstallmentsTableTableManager(
      $_db,
      $_db.debtInstallments,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_debtInstallmentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get occurredOn => $composableBuilder(
    column: $table.occurredOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionNorm => $composableBuilder(
    column: $table.descriptionNorm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nicheId => $composableBuilder(
    column: $table.nicheId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recurrence => $composableBuilder(
    column: $table.recurrence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recurrenceGroupId => $composableBuilder(
    column: $table.recurrenceGroupId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$IncomeSourcesTableFilterComposer get incomeSourceId {
    final $$IncomeSourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.incomeSourceId,
      referencedTable: $db.incomeSources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IncomeSourcesTableFilterComposer(
            $db: $db,
            $table: $db.incomeSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvestmentsTableFilterComposer get investmentId {
    final $$InvestmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.investmentId,
      referencedTable: $db.investments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvestmentsTableFilterComposer(
            $db: $db,
            $table: $db.investments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DebtInstallmentsTableFilterComposer get debtInstallmentId {
    final $$DebtInstallmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.debtInstallmentId,
      referencedTable: $db.debtInstallments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DebtInstallmentsTableFilterComposer(
            $db: $db,
            $table: $db.debtInstallments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get occurredOn => $composableBuilder(
    column: $table.occurredOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionNorm => $composableBuilder(
    column: $table.descriptionNorm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nicheId => $composableBuilder(
    column: $table.nicheId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurrence => $composableBuilder(
    column: $table.recurrence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurrenceGroupId => $composableBuilder(
    column: $table.recurrenceGroupId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$IncomeSourcesTableOrderingComposer get incomeSourceId {
    final $$IncomeSourcesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.incomeSourceId,
      referencedTable: $db.incomeSources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IncomeSourcesTableOrderingComposer(
            $db: $db,
            $table: $db.incomeSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvestmentsTableOrderingComposer get investmentId {
    final $$InvestmentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.investmentId,
      referencedTable: $db.investments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvestmentsTableOrderingComposer(
            $db: $db,
            $table: $db.investments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DebtInstallmentsTableOrderingComposer get debtInstallmentId {
    final $$DebtInstallmentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.debtInstallmentId,
      referencedTable: $db.debtInstallments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DebtInstallmentsTableOrderingComposer(
            $db: $db,
            $table: $db.debtInstallments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get occurredOn => $composableBuilder(
    column: $table.occurredOn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get descriptionNorm => $composableBuilder(
    column: $table.descriptionNorm,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nicheId =>
      $composableBuilder(column: $table.nicheId, builder: (column) => column);

  GeneratedColumn<String> get recurrence => $composableBuilder(
    column: $table.recurrence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recurrenceGroupId => $composableBuilder(
    column: $table.recurrenceGroupId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$IncomeSourcesTableAnnotationComposer get incomeSourceId {
    final $$IncomeSourcesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.incomeSourceId,
      referencedTable: $db.incomeSources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IncomeSourcesTableAnnotationComposer(
            $db: $db,
            $table: $db.incomeSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvestmentsTableAnnotationComposer get investmentId {
    final $$InvestmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.investmentId,
      referencedTable: $db.investments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvestmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.investments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DebtInstallmentsTableAnnotationComposer get debtInstallmentId {
    final $$DebtInstallmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.debtInstallmentId,
      referencedTable: $db.debtInstallments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DebtInstallmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.debtInstallments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTable,
          Transaction,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (Transaction, $$TransactionsTableReferences),
          Transaction,
          PrefetchHooks Function({
            bool incomeSourceId,
            bool investmentId,
            bool debtInstallmentId,
          })
        > {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<String> occurredOn = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> descriptionNorm = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                Value<String?> nicheId = const Value.absent(),
                Value<String?> incomeSourceId = const Value.absent(),
                Value<String?> investmentId = const Value.absent(),
                Value<String?> debtInstallmentId = const Value.absent(),
                Value<String?> recurrence = const Value.absent(),
                Value<String?> recurrenceGroupId = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                kind: kind,
                amountCents: amountCents,
                occurredOn: occurredOn,
                description: description,
                descriptionNorm: descriptionNorm,
                paymentMethod: paymentMethod,
                nicheId: nicheId,
                incomeSourceId: incomeSourceId,
                investmentId: investmentId,
                debtInstallmentId: debtInstallmentId,
                recurrence: recurrence,
                recurrenceGroupId: recurrenceGroupId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String kind,
                required int amountCents,
                required String occurredOn,
                Value<String?> description = const Value.absent(),
                Value<String?> descriptionNorm = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                Value<String?> nicheId = const Value.absent(),
                Value<String?> incomeSourceId = const Value.absent(),
                Value<String?> investmentId = const Value.absent(),
                Value<String?> debtInstallmentId = const Value.absent(),
                Value<String?> recurrence = const Value.absent(),
                Value<String?> recurrenceGroupId = const Value.absent(),
                required String createdAt,
                required String updatedAt,
                Value<String?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsCompanion.insert(
                id: id,
                kind: kind,
                amountCents: amountCents,
                occurredOn: occurredOn,
                description: description,
                descriptionNorm: descriptionNorm,
                paymentMethod: paymentMethod,
                nicheId: nicheId,
                incomeSourceId: incomeSourceId,
                investmentId: investmentId,
                debtInstallmentId: debtInstallmentId,
                recurrence: recurrence,
                recurrenceGroupId: recurrenceGroupId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TransactionsTable, Transaction>(table),
                  $$TransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                incomeSourceId = false,
                investmentId = false,
                debtInstallmentId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (incomeSourceId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.incomeSourceId,
                            referencedTable: $$TransactionsTableReferences
                                ._incomeSourceIdTable(db),
                            referencedColumn: $$TransactionsTableReferences
                                ._incomeSourceIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (investmentId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.investmentId,
                            referencedTable: $$TransactionsTableReferences
                                ._investmentIdTable(db),
                            referencedColumn: $$TransactionsTableReferences
                                ._investmentIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (debtInstallmentId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.debtInstallmentId,
                            referencedTable: $$TransactionsTableReferences
                                ._debtInstallmentIdTable(db),
                            referencedColumn: $$TransactionsTableReferences
                                ._debtInstallmentIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$TransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTable,
      Transaction,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (Transaction, $$TransactionsTableReferences),
      Transaction,
      PrefetchHooks Function({
        bool incomeSourceId,
        bool investmentId,
        bool debtInstallmentId,
      })
    >;
typedef $$AppUsageDaysTableCreateCompanionBuilder =
    AppUsageDaysCompanion Function({required String day, Value<int> rowid});
typedef $$AppUsageDaysTableUpdateCompanionBuilder =
    AppUsageDaysCompanion Function({Value<String> day, Value<int> rowid});

class $$AppUsageDaysTableFilterComposer
    extends Composer<_$AppDatabase, $AppUsageDaysTable> {
  $$AppUsageDaysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppUsageDaysTableOrderingComposer
    extends Composer<_$AppDatabase, $AppUsageDaysTable> {
  $$AppUsageDaysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppUsageDaysTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppUsageDaysTable> {
  $$AppUsageDaysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);
}

class $$AppUsageDaysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppUsageDaysTable,
          AppUsageDay,
          $$AppUsageDaysTableFilterComposer,
          $$AppUsageDaysTableOrderingComposer,
          $$AppUsageDaysTableAnnotationComposer,
          $$AppUsageDaysTableCreateCompanionBuilder,
          $$AppUsageDaysTableUpdateCompanionBuilder,
          (
            AppUsageDay,
            BaseReferences<_$AppDatabase, $AppUsageDaysTable, AppUsageDay>,
          ),
          AppUsageDay,
          PrefetchHooks Function()
        > {
  $$AppUsageDaysTableTableManager(_$AppDatabase db, $AppUsageDaysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppUsageDaysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppUsageDaysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppUsageDaysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> day = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => AppUsageDaysCompanion(day: day, rowid: rowid),
          createCompanionCallback: ({
            required String day,
            Value<int> rowid = const Value.absent(),
          }) => AppUsageDaysCompanion.insert(day: day, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppUsageDaysTable, AppUsageDay>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AppUsageDaysTable,
                    AppUsageDay
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppUsageDaysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppUsageDaysTable,
      AppUsageDay,
      $$AppUsageDaysTableFilterComposer,
      $$AppUsageDaysTableOrderingComposer,
      $$AppUsageDaysTableAnnotationComposer,
      $$AppUsageDaysTableCreateCompanionBuilder,
      $$AppUsageDaysTableUpdateCompanionBuilder,
      (
        AppUsageDay,
        BaseReferences<_$AppDatabase, $AppUsageDaysTable, AppUsageDay>,
      ),
      AppUsageDay,
      PrefetchHooks Function()
    >;
typedef $$ErrorLogTableCreateCompanionBuilder = ErrorLogCompanion Function({
  required String id,
  required String occurredAt,
  required String type,
  Value<String?> screen,
  required String stack,
  Value<int> rowid,
});
typedef $$ErrorLogTableUpdateCompanionBuilder = ErrorLogCompanion Function({
  Value<String> id,
  Value<String> occurredAt,
  Value<String> type,
  Value<String?> screen,
  Value<String> stack,
  Value<int> rowid,
});

class $$ErrorLogTableFilterComposer
    extends Composer<_$AppDatabase, $ErrorLogTable> {
  $$ErrorLogTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get screen => $composableBuilder(
    column: $table.screen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stack => $composableBuilder(
    column: $table.stack,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ErrorLogTableOrderingComposer
    extends Composer<_$AppDatabase, $ErrorLogTable> {
  $$ErrorLogTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get screen => $composableBuilder(
    column: $table.screen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stack => $composableBuilder(
    column: $table.stack,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ErrorLogTableAnnotationComposer
    extends Composer<_$AppDatabase, $ErrorLogTable> {
  $$ErrorLogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get screen =>
      $composableBuilder(column: $table.screen, builder: (column) => column);

  GeneratedColumn<String> get stack =>
      $composableBuilder(column: $table.stack, builder: (column) => column);
}

class $$ErrorLogTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ErrorLogTable,
          ErrorLogData,
          $$ErrorLogTableFilterComposer,
          $$ErrorLogTableOrderingComposer,
          $$ErrorLogTableAnnotationComposer,
          $$ErrorLogTableCreateCompanionBuilder,
          $$ErrorLogTableUpdateCompanionBuilder,
          (
            ErrorLogData,
            BaseReferences<_$AppDatabase, $ErrorLogTable, ErrorLogData>,
          ),
          ErrorLogData,
          PrefetchHooks Function()
        > {
  $$ErrorLogTableTableManager(_$AppDatabase db, $ErrorLogTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ErrorLogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ErrorLogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ErrorLogTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> occurredAt = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> screen = const Value.absent(),
                Value<String> stack = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ErrorLogCompanion(
                id: id,
                occurredAt: occurredAt,
                type: type,
                screen: screen,
                stack: stack,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String occurredAt,
                required String type,
                Value<String?> screen = const Value.absent(),
                required String stack,
                Value<int> rowid = const Value.absent(),
              }) => ErrorLogCompanion.insert(
                id: id,
                occurredAt: occurredAt,
                type: type,
                screen: screen,
                stack: stack,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ErrorLogTable, ErrorLogData>(table),
                  BaseReferences<_$AppDatabase, $ErrorLogTable, ErrorLogData>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ErrorLogTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ErrorLogTable,
      ErrorLogData,
      $$ErrorLogTableFilterComposer,
      $$ErrorLogTableOrderingComposer,
      $$ErrorLogTableAnnotationComposer,
      $$ErrorLogTableCreateCompanionBuilder,
      $$ErrorLogTableUpdateCompanionBuilder,
      (
        ErrorLogData,
        BaseReferences<_$AppDatabase, $ErrorLogTable, ErrorLogData>,
      ),
      ErrorLogData,
      PrefetchHooks Function()
    >;
typedef $$InvestmentBalancesTableCreateCompanionBuilder =
    InvestmentBalancesCompanion Function({
      required String id,
      required String investmentId,
      required int balanceCents,
      required String recordedOn,
      Value<int> rowid,
    });
typedef $$InvestmentBalancesTableUpdateCompanionBuilder =
    InvestmentBalancesCompanion Function({
      Value<String> id,
      Value<String> investmentId,
      Value<int> balanceCents,
      Value<String> recordedOn,
      Value<int> rowid,
    });

final class $$InvestmentBalancesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $InvestmentBalancesTable,
          InvestmentBalance
        > {
  $$InvestmentBalancesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $InvestmentsTable _investmentIdTable(_$AppDatabase db) => db
      .investments
      .createAlias('investment_balances__investment_id__investments__id');

  $$InvestmentsTableProcessedTableManager get investmentId {
    final $_column = $_itemColumn<String>('investment_id')!;

    final manager = $$InvestmentsTableTableManager(
      $_db,
      $_db.investments,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_investmentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InvestmentBalancesTableFilterComposer
    extends Composer<_$AppDatabase, $InvestmentBalancesTable> {
  $$InvestmentBalancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get balanceCents => $composableBuilder(
    column: $table.balanceCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordedOn => $composableBuilder(
    column: $table.recordedOn,
    builder: (column) => ColumnFilters(column),
  );

  $$InvestmentsTableFilterComposer get investmentId {
    final $$InvestmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.investmentId,
      referencedTable: $db.investments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvestmentsTableFilterComposer(
            $db: $db,
            $table: $db.investments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvestmentBalancesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvestmentBalancesTable> {
  $$InvestmentBalancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get balanceCents => $composableBuilder(
    column: $table.balanceCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordedOn => $composableBuilder(
    column: $table.recordedOn,
    builder: (column) => ColumnOrderings(column),
  );

  $$InvestmentsTableOrderingComposer get investmentId {
    final $$InvestmentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.investmentId,
      referencedTable: $db.investments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvestmentsTableOrderingComposer(
            $db: $db,
            $table: $db.investments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvestmentBalancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvestmentBalancesTable> {
  $$InvestmentBalancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get balanceCents => $composableBuilder(
    column: $table.balanceCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recordedOn => $composableBuilder(
    column: $table.recordedOn,
    builder: (column) => column,
  );

  $$InvestmentsTableAnnotationComposer get investmentId {
    final $$InvestmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.investmentId,
      referencedTable: $db.investments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvestmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.investments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvestmentBalancesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvestmentBalancesTable,
          InvestmentBalance,
          $$InvestmentBalancesTableFilterComposer,
          $$InvestmentBalancesTableOrderingComposer,
          $$InvestmentBalancesTableAnnotationComposer,
          $$InvestmentBalancesTableCreateCompanionBuilder,
          $$InvestmentBalancesTableUpdateCompanionBuilder,
          (InvestmentBalance, $$InvestmentBalancesTableReferences),
          InvestmentBalance,
          PrefetchHooks Function({bool investmentId})
        > {
  $$InvestmentBalancesTableTableManager(
    _$AppDatabase db,
    $InvestmentBalancesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvestmentBalancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvestmentBalancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvestmentBalancesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> investmentId = const Value.absent(),
                Value<int> balanceCents = const Value.absent(),
                Value<String> recordedOn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvestmentBalancesCompanion(
                id: id,
                investmentId: investmentId,
                balanceCents: balanceCents,
                recordedOn: recordedOn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String investmentId,
                required int balanceCents,
                required String recordedOn,
                Value<int> rowid = const Value.absent(),
              }) => InvestmentBalancesCompanion.insert(
                id: id,
                investmentId: investmentId,
                balanceCents: balanceCents,
                recordedOn: recordedOn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InvestmentBalancesTable, InvestmentBalance>(
                    table,
                  ),
                  $$InvestmentBalancesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({investmentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (investmentId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.investmentId,
                        referencedTable: $$InvestmentBalancesTableReferences
                            ._investmentIdTable(db),
                        referencedColumn: $$InvestmentBalancesTableReferences
                            ._investmentIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InvestmentBalancesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvestmentBalancesTable,
      InvestmentBalance,
      $$InvestmentBalancesTableFilterComposer,
      $$InvestmentBalancesTableOrderingComposer,
      $$InvestmentBalancesTableAnnotationComposer,
      $$InvestmentBalancesTableCreateCompanionBuilder,
      $$InvestmentBalancesTableUpdateCompanionBuilder,
      (InvestmentBalance, $$InvestmentBalancesTableReferences),
      InvestmentBalance,
      PrefetchHooks Function({bool investmentId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$NichesTableTableManager get niches =>
      $$NichesTableTableManager(_db, _db.niches);
  $$IncomeSourcesTableTableManager get incomeSources =>
      $$IncomeSourcesTableTableManager(_db, _db.incomeSources);
  $$InvestmentsTableTableManager get investments =>
      $$InvestmentsTableTableManager(_db, _db.investments);
  $$DebtsTableTableManager get debts =>
      $$DebtsTableTableManager(_db, _db.debts);
  $$DebtInstallmentsTableTableManager get debtInstallments =>
      $$DebtInstallmentsTableTableManager(_db, _db.debtInstallments);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$AppUsageDaysTableTableManager get appUsageDays =>
      $$AppUsageDaysTableTableManager(_db, _db.appUsageDays);
  $$ErrorLogTableTableManager get errorLog =>
      $$ErrorLogTableTableManager(_db, _db.errorLog);
  $$InvestmentBalancesTableTableManager get investmentBalances =>
      $$InvestmentBalancesTableTableManager(_db, _db.investmentBalances);
}
