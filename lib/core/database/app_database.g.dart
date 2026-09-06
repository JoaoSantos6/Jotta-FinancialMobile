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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $NichesTable niches = $NichesTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $AppUsageDaysTable appUsageDays = $AppUsageDaysTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    niches,
    transactions,
    appUsageDays,
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

  ColumnFilters<String> get incomeSourceId => $composableBuilder(
    column: $table.incomeSourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get investmentId => $composableBuilder(
    column: $table.investmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get debtInstallmentId => $composableBuilder(
    column: $table.debtInstallmentId,
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

  ColumnOrderings<String> get incomeSourceId => $composableBuilder(
    column: $table.incomeSourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get investmentId => $composableBuilder(
    column: $table.investmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get debtInstallmentId => $composableBuilder(
    column: $table.debtInstallmentId,
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

  GeneratedColumn<String> get incomeSourceId => $composableBuilder(
    column: $table.incomeSourceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get investmentId => $composableBuilder(
    column: $table.investmentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get debtInstallmentId => $composableBuilder(
    column: $table.debtInstallmentId,
    builder: (column) => column,
  );

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
          (
            Transaction,
            BaseReferences<_$AppDatabase, $TransactionsTable, Transaction>,
          ),
          Transaction,
          PrefetchHooks Function()
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
                  BaseReferences<
                    _$AppDatabase,
                    $TransactionsTable,
                    Transaction
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
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
      (
        Transaction,
        BaseReferences<_$AppDatabase, $TransactionsTable, Transaction>,
      ),
      Transaction,
      PrefetchHooks Function()
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$NichesTableTableManager get niches =>
      $$NichesTableTableManager(_db, _db.niches);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$AppUsageDaysTableTableManager get appUsageDays =>
      $$AppUsageDaysTableTableManager(_db, _db.appUsageDays);
}
