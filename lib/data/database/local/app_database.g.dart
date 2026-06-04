// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProductsTable extends Products
    with TableInfo<$ProductsTable, ProductEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: generateUuid,
  );
  static const VerificationMeta _idbusinessMeta = const VerificationMeta(
    'idbusiness',
  );
  @override
  late final GeneratedColumn<String> idbusiness = GeneratedColumn<String>(
    'idbusiness',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idcategoryMeta = const VerificationMeta(
    'idcategory',
  );
  @override
  late final GeneratedColumn<String> idcategory = GeneratedColumn<String>(
    'idcategory',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stockMeta = const VerificationMeta('stock');
  @override
  late final GeneratedColumn<int> stock = GeneratedColumn<int>(
    'stock',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ownerMeta = const VerificationMeta('owner');
  @override
  late final GeneratedColumn<String> owner = GeneratedColumn<String>(
    'owner',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stockminimumlevelMeta = const VerificationMeta(
    'stockminimumlevel',
  );
  @override
  late final GeneratedColumn<int> stockminimumlevel = GeneratedColumn<int>(
    'stockminimumlevel',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deviceidMeta = const VerificationMeta(
    'deviceid',
  );
  @override
  late final GeneratedColumn<String> deviceid = GeneratedColumn<String>(
    'deviceid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _platformMeta = const VerificationMeta(
    'platform',
  );
  @override
  late final GeneratedColumn<String> platform = GeneratedColumn<String>(
    'platform',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ubicacionMeta = const VerificationMeta(
    'ubicacion',
  );
  @override
  late final GeneratedColumn<String> ubicacion = GeneratedColumn<String>(
    'ubicacion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodegaMeta = const VerificationMeta('bodega');
  @override
  late final GeneratedColumn<String> bodega = GeneratedColumn<String>(
    'bodega',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastsyncedatMeta = const VerificationMeta(
    'lastsyncedat',
  );
  @override
  late final GeneratedColumn<DateTime> lastsyncedat = GeneratedColumn<DateTime>(
    'lastsyncedat',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdatMeta = const VerificationMeta(
    'createdat',
  );
  @override
  late final GeneratedColumn<DateTime> createdat = GeneratedColumn<DateTime>(
    'createdat',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncstateMeta = const VerificationMeta(
    'syncstate',
  );
  @override
  late final GeneratedColumn<String> syncstate = GeneratedColumn<String>(
    'syncstate',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncstatusMeta = const VerificationMeta(
    'syncstatus',
  );
  @override
  late final GeneratedColumn<bool> syncstatus = GeneratedColumn<bool>(
    'syncstatus',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("syncstatus" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isdemoMeta = const VerificationMeta('isdemo');
  @override
  late final GeneratedColumn<bool> isdemo = GeneratedColumn<bool>(
    'isdemo',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("isdemo" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    idbusiness,
    idcategory,
    name,
    image,
    stock,
    price,
    owner,
    barcode,
    stockminimumlevel,
    deviceid,
    platform,
    ubicacion,
    bodega,
    lastsyncedat,
    createdat,
    syncstate,
    syncstatus,
    isdemo,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('idbusiness')) {
      context.handle(
        _idbusinessMeta,
        idbusiness.isAcceptableOrUnknown(data['idbusiness']!, _idbusinessMeta),
      );
    }
    if (data.containsKey('idcategory')) {
      context.handle(
        _idcategoryMeta,
        idcategory.isAcceptableOrUnknown(data['idcategory']!, _idcategoryMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    }
    if (data.containsKey('stock')) {
      context.handle(
        _stockMeta,
        stock.isAcceptableOrUnknown(data['stock']!, _stockMeta),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    }
    if (data.containsKey('owner')) {
      context.handle(
        _ownerMeta,
        owner.isAcceptableOrUnknown(data['owner']!, _ownerMeta),
      );
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('stockminimumlevel')) {
      context.handle(
        _stockminimumlevelMeta,
        stockminimumlevel.isAcceptableOrUnknown(
          data['stockminimumlevel']!,
          _stockminimumlevelMeta,
        ),
      );
    }
    if (data.containsKey('deviceid')) {
      context.handle(
        _deviceidMeta,
        deviceid.isAcceptableOrUnknown(data['deviceid']!, _deviceidMeta),
      );
    }
    if (data.containsKey('platform')) {
      context.handle(
        _platformMeta,
        platform.isAcceptableOrUnknown(data['platform']!, _platformMeta),
      );
    }
    if (data.containsKey('ubicacion')) {
      context.handle(
        _ubicacionMeta,
        ubicacion.isAcceptableOrUnknown(data['ubicacion']!, _ubicacionMeta),
      );
    }
    if (data.containsKey('bodega')) {
      context.handle(
        _bodegaMeta,
        bodega.isAcceptableOrUnknown(data['bodega']!, _bodegaMeta),
      );
    }
    if (data.containsKey('lastsyncedat')) {
      context.handle(
        _lastsyncedatMeta,
        lastsyncedat.isAcceptableOrUnknown(
          data['lastsyncedat']!,
          _lastsyncedatMeta,
        ),
      );
    }
    if (data.containsKey('createdat')) {
      context.handle(
        _createdatMeta,
        createdat.isAcceptableOrUnknown(data['createdat']!, _createdatMeta),
      );
    }
    if (data.containsKey('syncstate')) {
      context.handle(
        _syncstateMeta,
        syncstate.isAcceptableOrUnknown(data['syncstate']!, _syncstateMeta),
      );
    }
    if (data.containsKey('syncstatus')) {
      context.handle(
        _syncstatusMeta,
        syncstatus.isAcceptableOrUnknown(data['syncstatus']!, _syncstatusMeta),
      );
    }
    if (data.containsKey('isdemo')) {
      context.handle(
        _isdemoMeta,
        isdemo.isAcceptableOrUnknown(data['isdemo']!, _isdemoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      idbusiness: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}idbusiness'],
      ),
      idcategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}idcategory'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      image: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image'],
      ),
      stock: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stock'],
      ),
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      ),
      owner: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner'],
      ),
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      stockminimumlevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stockminimumlevel'],
      ),
      deviceid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}deviceid'],
      ),
      platform: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}platform'],
      ),
      ubicacion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ubicacion'],
      ),
      bodega: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bodega'],
      ),
      lastsyncedat: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}lastsyncedat'],
      ),
      createdat: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}createdat'],
      ),
      syncstate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}syncstate'],
      ),
      syncstatus: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}syncstatus'],
      ),
      isdemo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}isdemo'],
      ),
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class ProductEntity extends DataClass implements Insertable<ProductEntity> {
  final String id;
  final String? idbusiness;
  final String? idcategory;
  final String? name;
  final String? image;
  final int? stock;
  final double? price;
  final String? owner;
  final String? barcode;
  final int? stockminimumlevel;
  final String? deviceid;
  final String? platform;
  final String? ubicacion;
  final String? bodega;
  final DateTime? lastsyncedat;
  final DateTime? createdat;
  final String? syncstate;
  final bool? syncstatus;
  final bool? isdemo;
  const ProductEntity({
    required this.id,
    this.idbusiness,
    this.idcategory,
    this.name,
    this.image,
    this.stock,
    this.price,
    this.owner,
    this.barcode,
    this.stockminimumlevel,
    this.deviceid,
    this.platform,
    this.ubicacion,
    this.bodega,
    this.lastsyncedat,
    this.createdat,
    this.syncstate,
    this.syncstatus,
    this.isdemo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || idbusiness != null) {
      map['idbusiness'] = Variable<String>(idbusiness);
    }
    if (!nullToAbsent || idcategory != null) {
      map['idcategory'] = Variable<String>(idcategory);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    if (!nullToAbsent || stock != null) {
      map['stock'] = Variable<int>(stock);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<double>(price);
    }
    if (!nullToAbsent || owner != null) {
      map['owner'] = Variable<String>(owner);
    }
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    if (!nullToAbsent || stockminimumlevel != null) {
      map['stockminimumlevel'] = Variable<int>(stockminimumlevel);
    }
    if (!nullToAbsent || deviceid != null) {
      map['deviceid'] = Variable<String>(deviceid);
    }
    if (!nullToAbsent || platform != null) {
      map['platform'] = Variable<String>(platform);
    }
    if (!nullToAbsent || ubicacion != null) {
      map['ubicacion'] = Variable<String>(ubicacion);
    }
    if (!nullToAbsent || bodega != null) {
      map['bodega'] = Variable<String>(bodega);
    }
    if (!nullToAbsent || lastsyncedat != null) {
      map['lastsyncedat'] = Variable<DateTime>(lastsyncedat);
    }
    if (!nullToAbsent || createdat != null) {
      map['createdat'] = Variable<DateTime>(createdat);
    }
    if (!nullToAbsent || syncstate != null) {
      map['syncstate'] = Variable<String>(syncstate);
    }
    if (!nullToAbsent || syncstatus != null) {
      map['syncstatus'] = Variable<bool>(syncstatus);
    }
    if (!nullToAbsent || isdemo != null) {
      map['isdemo'] = Variable<bool>(isdemo);
    }
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      idbusiness: idbusiness == null && nullToAbsent
          ? const Value.absent()
          : Value(idbusiness),
      idcategory: idcategory == null && nullToAbsent
          ? const Value.absent()
          : Value(idcategory),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      image: image == null && nullToAbsent
          ? const Value.absent()
          : Value(image),
      stock: stock == null && nullToAbsent
          ? const Value.absent()
          : Value(stock),
      price: price == null && nullToAbsent
          ? const Value.absent()
          : Value(price),
      owner: owner == null && nullToAbsent
          ? const Value.absent()
          : Value(owner),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      stockminimumlevel: stockminimumlevel == null && nullToAbsent
          ? const Value.absent()
          : Value(stockminimumlevel),
      deviceid: deviceid == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceid),
      platform: platform == null && nullToAbsent
          ? const Value.absent()
          : Value(platform),
      ubicacion: ubicacion == null && nullToAbsent
          ? const Value.absent()
          : Value(ubicacion),
      bodega: bodega == null && nullToAbsent
          ? const Value.absent()
          : Value(bodega),
      lastsyncedat: lastsyncedat == null && nullToAbsent
          ? const Value.absent()
          : Value(lastsyncedat),
      createdat: createdat == null && nullToAbsent
          ? const Value.absent()
          : Value(createdat),
      syncstate: syncstate == null && nullToAbsent
          ? const Value.absent()
          : Value(syncstate),
      syncstatus: syncstatus == null && nullToAbsent
          ? const Value.absent()
          : Value(syncstatus),
      isdemo: isdemo == null && nullToAbsent
          ? const Value.absent()
          : Value(isdemo),
    );
  }

  factory ProductEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductEntity(
      id: serializer.fromJson<String>(json['id']),
      idbusiness: serializer.fromJson<String?>(json['idbusiness']),
      idcategory: serializer.fromJson<String?>(json['idcategory']),
      name: serializer.fromJson<String?>(json['name']),
      image: serializer.fromJson<String?>(json['image']),
      stock: serializer.fromJson<int?>(json['stock']),
      price: serializer.fromJson<double?>(json['price']),
      owner: serializer.fromJson<String?>(json['owner']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      stockminimumlevel: serializer.fromJson<int?>(json['stockminimumlevel']),
      deviceid: serializer.fromJson<String?>(json['deviceid']),
      platform: serializer.fromJson<String?>(json['platform']),
      ubicacion: serializer.fromJson<String?>(json['ubicacion']),
      bodega: serializer.fromJson<String?>(json['bodega']),
      lastsyncedat: serializer.fromJson<DateTime?>(json['lastsyncedat']),
      createdat: serializer.fromJson<DateTime?>(json['createdat']),
      syncstate: serializer.fromJson<String?>(json['syncstate']),
      syncstatus: serializer.fromJson<bool?>(json['syncstatus']),
      isdemo: serializer.fromJson<bool?>(json['isdemo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'idbusiness': serializer.toJson<String?>(idbusiness),
      'idcategory': serializer.toJson<String?>(idcategory),
      'name': serializer.toJson<String?>(name),
      'image': serializer.toJson<String?>(image),
      'stock': serializer.toJson<int?>(stock),
      'price': serializer.toJson<double?>(price),
      'owner': serializer.toJson<String?>(owner),
      'barcode': serializer.toJson<String?>(barcode),
      'stockminimumlevel': serializer.toJson<int?>(stockminimumlevel),
      'deviceid': serializer.toJson<String?>(deviceid),
      'platform': serializer.toJson<String?>(platform),
      'ubicacion': serializer.toJson<String?>(ubicacion),
      'bodega': serializer.toJson<String?>(bodega),
      'lastsyncedat': serializer.toJson<DateTime?>(lastsyncedat),
      'createdat': serializer.toJson<DateTime?>(createdat),
      'syncstate': serializer.toJson<String?>(syncstate),
      'syncstatus': serializer.toJson<bool?>(syncstatus),
      'isdemo': serializer.toJson<bool?>(isdemo),
    };
  }

  ProductEntity copyWith({
    String? id,
    Value<String?> idbusiness = const Value.absent(),
    Value<String?> idcategory = const Value.absent(),
    Value<String?> name = const Value.absent(),
    Value<String?> image = const Value.absent(),
    Value<int?> stock = const Value.absent(),
    Value<double?> price = const Value.absent(),
    Value<String?> owner = const Value.absent(),
    Value<String?> barcode = const Value.absent(),
    Value<int?> stockminimumlevel = const Value.absent(),
    Value<String?> deviceid = const Value.absent(),
    Value<String?> platform = const Value.absent(),
    Value<String?> ubicacion = const Value.absent(),
    Value<String?> bodega = const Value.absent(),
    Value<DateTime?> lastsyncedat = const Value.absent(),
    Value<DateTime?> createdat = const Value.absent(),
    Value<String?> syncstate = const Value.absent(),
    Value<bool?> syncstatus = const Value.absent(),
    Value<bool?> isdemo = const Value.absent(),
  }) => ProductEntity(
    id: id ?? this.id,
    idbusiness: idbusiness.present ? idbusiness.value : this.idbusiness,
    idcategory: idcategory.present ? idcategory.value : this.idcategory,
    name: name.present ? name.value : this.name,
    image: image.present ? image.value : this.image,
    stock: stock.present ? stock.value : this.stock,
    price: price.present ? price.value : this.price,
    owner: owner.present ? owner.value : this.owner,
    barcode: barcode.present ? barcode.value : this.barcode,
    stockminimumlevel: stockminimumlevel.present
        ? stockminimumlevel.value
        : this.stockminimumlevel,
    deviceid: deviceid.present ? deviceid.value : this.deviceid,
    platform: platform.present ? platform.value : this.platform,
    ubicacion: ubicacion.present ? ubicacion.value : this.ubicacion,
    bodega: bodega.present ? bodega.value : this.bodega,
    lastsyncedat: lastsyncedat.present ? lastsyncedat.value : this.lastsyncedat,
    createdat: createdat.present ? createdat.value : this.createdat,
    syncstate: syncstate.present ? syncstate.value : this.syncstate,
    syncstatus: syncstatus.present ? syncstatus.value : this.syncstatus,
    isdemo: isdemo.present ? isdemo.value : this.isdemo,
  );
  ProductEntity copyWithCompanion(ProductsCompanion data) {
    return ProductEntity(
      id: data.id.present ? data.id.value : this.id,
      idbusiness: data.idbusiness.present
          ? data.idbusiness.value
          : this.idbusiness,
      idcategory: data.idcategory.present
          ? data.idcategory.value
          : this.idcategory,
      name: data.name.present ? data.name.value : this.name,
      image: data.image.present ? data.image.value : this.image,
      stock: data.stock.present ? data.stock.value : this.stock,
      price: data.price.present ? data.price.value : this.price,
      owner: data.owner.present ? data.owner.value : this.owner,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      stockminimumlevel: data.stockminimumlevel.present
          ? data.stockminimumlevel.value
          : this.stockminimumlevel,
      deviceid: data.deviceid.present ? data.deviceid.value : this.deviceid,
      platform: data.platform.present ? data.platform.value : this.platform,
      ubicacion: data.ubicacion.present ? data.ubicacion.value : this.ubicacion,
      bodega: data.bodega.present ? data.bodega.value : this.bodega,
      lastsyncedat: data.lastsyncedat.present
          ? data.lastsyncedat.value
          : this.lastsyncedat,
      createdat: data.createdat.present ? data.createdat.value : this.createdat,
      syncstate: data.syncstate.present ? data.syncstate.value : this.syncstate,
      syncstatus: data.syncstatus.present
          ? data.syncstatus.value
          : this.syncstatus,
      isdemo: data.isdemo.present ? data.isdemo.value : this.isdemo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductEntity(')
          ..write('id: $id, ')
          ..write('idbusiness: $idbusiness, ')
          ..write('idcategory: $idcategory, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('stock: $stock, ')
          ..write('price: $price, ')
          ..write('owner: $owner, ')
          ..write('barcode: $barcode, ')
          ..write('stockminimumlevel: $stockminimumlevel, ')
          ..write('deviceid: $deviceid, ')
          ..write('platform: $platform, ')
          ..write('ubicacion: $ubicacion, ')
          ..write('bodega: $bodega, ')
          ..write('lastsyncedat: $lastsyncedat, ')
          ..write('createdat: $createdat, ')
          ..write('syncstate: $syncstate, ')
          ..write('syncstatus: $syncstatus, ')
          ..write('isdemo: $isdemo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    idbusiness,
    idcategory,
    name,
    image,
    stock,
    price,
    owner,
    barcode,
    stockminimumlevel,
    deviceid,
    platform,
    ubicacion,
    bodega,
    lastsyncedat,
    createdat,
    syncstate,
    syncstatus,
    isdemo,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductEntity &&
          other.id == this.id &&
          other.idbusiness == this.idbusiness &&
          other.idcategory == this.idcategory &&
          other.name == this.name &&
          other.image == this.image &&
          other.stock == this.stock &&
          other.price == this.price &&
          other.owner == this.owner &&
          other.barcode == this.barcode &&
          other.stockminimumlevel == this.stockminimumlevel &&
          other.deviceid == this.deviceid &&
          other.platform == this.platform &&
          other.ubicacion == this.ubicacion &&
          other.bodega == this.bodega &&
          other.lastsyncedat == this.lastsyncedat &&
          other.createdat == this.createdat &&
          other.syncstate == this.syncstate &&
          other.syncstatus == this.syncstatus &&
          other.isdemo == this.isdemo);
}

class ProductsCompanion extends UpdateCompanion<ProductEntity> {
  final Value<String> id;
  final Value<String?> idbusiness;
  final Value<String?> idcategory;
  final Value<String?> name;
  final Value<String?> image;
  final Value<int?> stock;
  final Value<double?> price;
  final Value<String?> owner;
  final Value<String?> barcode;
  final Value<int?> stockminimumlevel;
  final Value<String?> deviceid;
  final Value<String?> platform;
  final Value<String?> ubicacion;
  final Value<String?> bodega;
  final Value<DateTime?> lastsyncedat;
  final Value<DateTime?> createdat;
  final Value<String?> syncstate;
  final Value<bool?> syncstatus;
  final Value<bool?> isdemo;
  final Value<int> rowid;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.idbusiness = const Value.absent(),
    this.idcategory = const Value.absent(),
    this.name = const Value.absent(),
    this.image = const Value.absent(),
    this.stock = const Value.absent(),
    this.price = const Value.absent(),
    this.owner = const Value.absent(),
    this.barcode = const Value.absent(),
    this.stockminimumlevel = const Value.absent(),
    this.deviceid = const Value.absent(),
    this.platform = const Value.absent(),
    this.ubicacion = const Value.absent(),
    this.bodega = const Value.absent(),
    this.lastsyncedat = const Value.absent(),
    this.createdat = const Value.absent(),
    this.syncstate = const Value.absent(),
    this.syncstatus = const Value.absent(),
    this.isdemo = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    this.idbusiness = const Value.absent(),
    this.idcategory = const Value.absent(),
    this.name = const Value.absent(),
    this.image = const Value.absent(),
    this.stock = const Value.absent(),
    this.price = const Value.absent(),
    this.owner = const Value.absent(),
    this.barcode = const Value.absent(),
    this.stockminimumlevel = const Value.absent(),
    this.deviceid = const Value.absent(),
    this.platform = const Value.absent(),
    this.ubicacion = const Value.absent(),
    this.bodega = const Value.absent(),
    this.lastsyncedat = const Value.absent(),
    this.createdat = const Value.absent(),
    this.syncstate = const Value.absent(),
    this.syncstatus = const Value.absent(),
    this.isdemo = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<ProductEntity> custom({
    Expression<String>? id,
    Expression<String>? idbusiness,
    Expression<String>? idcategory,
    Expression<String>? name,
    Expression<String>? image,
    Expression<int>? stock,
    Expression<double>? price,
    Expression<String>? owner,
    Expression<String>? barcode,
    Expression<int>? stockminimumlevel,
    Expression<String>? deviceid,
    Expression<String>? platform,
    Expression<String>? ubicacion,
    Expression<String>? bodega,
    Expression<DateTime>? lastsyncedat,
    Expression<DateTime>? createdat,
    Expression<String>? syncstate,
    Expression<bool>? syncstatus,
    Expression<bool>? isdemo,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idbusiness != null) 'idbusiness': idbusiness,
      if (idcategory != null) 'idcategory': idcategory,
      if (name != null) 'name': name,
      if (image != null) 'image': image,
      if (stock != null) 'stock': stock,
      if (price != null) 'price': price,
      if (owner != null) 'owner': owner,
      if (barcode != null) 'barcode': barcode,
      if (stockminimumlevel != null) 'stockminimumlevel': stockminimumlevel,
      if (deviceid != null) 'deviceid': deviceid,
      if (platform != null) 'platform': platform,
      if (ubicacion != null) 'ubicacion': ubicacion,
      if (bodega != null) 'bodega': bodega,
      if (lastsyncedat != null) 'lastsyncedat': lastsyncedat,
      if (createdat != null) 'createdat': createdat,
      if (syncstate != null) 'syncstate': syncstate,
      if (syncstatus != null) 'syncstatus': syncstatus,
      if (isdemo != null) 'isdemo': isdemo,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith({
    Value<String>? id,
    Value<String?>? idbusiness,
    Value<String?>? idcategory,
    Value<String?>? name,
    Value<String?>? image,
    Value<int?>? stock,
    Value<double?>? price,
    Value<String?>? owner,
    Value<String?>? barcode,
    Value<int?>? stockminimumlevel,
    Value<String?>? deviceid,
    Value<String?>? platform,
    Value<String?>? ubicacion,
    Value<String?>? bodega,
    Value<DateTime?>? lastsyncedat,
    Value<DateTime?>? createdat,
    Value<String?>? syncstate,
    Value<bool?>? syncstatus,
    Value<bool?>? isdemo,
    Value<int>? rowid,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      idbusiness: idbusiness ?? this.idbusiness,
      idcategory: idcategory ?? this.idcategory,
      name: name ?? this.name,
      image: image ?? this.image,
      stock: stock ?? this.stock,
      price: price ?? this.price,
      owner: owner ?? this.owner,
      barcode: barcode ?? this.barcode,
      stockminimumlevel: stockminimumlevel ?? this.stockminimumlevel,
      deviceid: deviceid ?? this.deviceid,
      platform: platform ?? this.platform,
      ubicacion: ubicacion ?? this.ubicacion,
      bodega: bodega ?? this.bodega,
      lastsyncedat: lastsyncedat ?? this.lastsyncedat,
      createdat: createdat ?? this.createdat,
      syncstate: syncstate ?? this.syncstate,
      syncstatus: syncstatus ?? this.syncstatus,
      isdemo: isdemo ?? this.isdemo,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (idbusiness.present) {
      map['idbusiness'] = Variable<String>(idbusiness.value);
    }
    if (idcategory.present) {
      map['idcategory'] = Variable<String>(idcategory.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (stock.present) {
      map['stock'] = Variable<int>(stock.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (owner.present) {
      map['owner'] = Variable<String>(owner.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (stockminimumlevel.present) {
      map['stockminimumlevel'] = Variable<int>(stockminimumlevel.value);
    }
    if (deviceid.present) {
      map['deviceid'] = Variable<String>(deviceid.value);
    }
    if (platform.present) {
      map['platform'] = Variable<String>(platform.value);
    }
    if (ubicacion.present) {
      map['ubicacion'] = Variable<String>(ubicacion.value);
    }
    if (bodega.present) {
      map['bodega'] = Variable<String>(bodega.value);
    }
    if (lastsyncedat.present) {
      map['lastsyncedat'] = Variable<DateTime>(lastsyncedat.value);
    }
    if (createdat.present) {
      map['createdat'] = Variable<DateTime>(createdat.value);
    }
    if (syncstate.present) {
      map['syncstate'] = Variable<String>(syncstate.value);
    }
    if (syncstatus.present) {
      map['syncstatus'] = Variable<bool>(syncstatus.value);
    }
    if (isdemo.present) {
      map['isdemo'] = Variable<bool>(isdemo.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('idbusiness: $idbusiness, ')
          ..write('idcategory: $idcategory, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('stock: $stock, ')
          ..write('price: $price, ')
          ..write('owner: $owner, ')
          ..write('barcode: $barcode, ')
          ..write('stockminimumlevel: $stockminimumlevel, ')
          ..write('deviceid: $deviceid, ')
          ..write('platform: $platform, ')
          ..write('ubicacion: $ubicacion, ')
          ..write('bodega: $bodega, ')
          ..write('lastsyncedat: $lastsyncedat, ')
          ..write('createdat: $createdat, ')
          ..write('syncstate: $syncstate, ')
          ..write('syncstatus: $syncstatus, ')
          ..write('isdemo: $isdemo, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CartGroupsTable extends CartGroups
    with TableInfo<$CartGroupsTable, CartGroupEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CartGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _processedMeta = const VerificationMeta(
    'processed',
  );
  @override
  late final GeneratedColumn<bool> processed = GeneratedColumn<bool>(
    'processed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("processed" IN (0, 1))',
    ),
    defaultValue: Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<bool> syncStatus = GeneratedColumn<bool>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sync_status" IN (0, 1))',
    ),
    defaultValue: Constant(false),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStateMeta = const VerificationMeta(
    'syncState',
  );
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
    'sync_state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    processed,
    createdAt,
    syncStatus,
    lastSyncedAt,
    syncState,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cart_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<CartGroupEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('processed')) {
      context.handle(
        _processedMeta,
        processed.isAcceptableOrUnknown(data['processed']!, _processedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('sync_state')) {
      context.handle(
        _syncStateMeta,
        syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CartGroupEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CartGroupEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      processed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}processed'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
      syncState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_state'],
      )!,
    );
  }

  @override
  $CartGroupsTable createAlias(String alias) {
    return $CartGroupsTable(attachedDatabase, alias);
  }
}

class CartGroupEntity extends DataClass implements Insertable<CartGroupEntity> {
  final int id;
  final String? name;
  final bool processed;
  final DateTime createdAt;
  final bool syncStatus;
  final DateTime? lastSyncedAt;
  final String syncState;
  const CartGroupEntity({
    required this.id,
    this.name,
    required this.processed,
    required this.createdAt,
    required this.syncStatus,
    this.lastSyncedAt,
    required this.syncState,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['processed'] = Variable<bool>(processed);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['sync_status'] = Variable<bool>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    map['sync_state'] = Variable<String>(syncState);
    return map;
  }

  CartGroupsCompanion toCompanion(bool nullToAbsent) {
    return CartGroupsCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      processed: Value(processed),
      createdAt: Value(createdAt),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      syncState: Value(syncState),
    );
  }

  factory CartGroupEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CartGroupEntity(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      processed: serializer.fromJson<bool>(json['processed']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncStatus: serializer.fromJson<bool>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
      syncState: serializer.fromJson<String>(json['syncState']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String?>(name),
      'processed': serializer.toJson<bool>(processed),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncStatus': serializer.toJson<bool>(syncStatus),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
      'syncState': serializer.toJson<String>(syncState),
    };
  }

  CartGroupEntity copyWith({
    int? id,
    Value<String?> name = const Value.absent(),
    bool? processed,
    DateTime? createdAt,
    bool? syncStatus,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
    String? syncState,
  }) => CartGroupEntity(
    id: id ?? this.id,
    name: name.present ? name.value : this.name,
    processed: processed ?? this.processed,
    createdAt: createdAt ?? this.createdAt,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    syncState: syncState ?? this.syncState,
  );
  CartGroupEntity copyWithCompanion(CartGroupsCompanion data) {
    return CartGroupEntity(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      processed: data.processed.present ? data.processed.value : this.processed,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CartGroupEntity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('processed: $processed, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('syncState: $syncState')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    processed,
    createdAt,
    syncStatus,
    lastSyncedAt,
    syncState,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartGroupEntity &&
          other.id == this.id &&
          other.name == this.name &&
          other.processed == this.processed &&
          other.createdAt == this.createdAt &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.syncState == this.syncState);
}

class CartGroupsCompanion extends UpdateCompanion<CartGroupEntity> {
  final Value<int> id;
  final Value<String?> name;
  final Value<bool> processed;
  final Value<DateTime> createdAt;
  final Value<bool> syncStatus;
  final Value<DateTime?> lastSyncedAt;
  final Value<String> syncState;
  const CartGroupsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.processed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.syncState = const Value.absent(),
  });
  CartGroupsCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.processed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.syncState = const Value.absent(),
  });
  static Insertable<CartGroupEntity> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<bool>? processed,
    Expression<DateTime>? createdAt,
    Expression<bool>? syncStatus,
    Expression<DateTime>? lastSyncedAt,
    Expression<String>? syncState,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (processed != null) 'processed': processed,
      if (createdAt != null) 'created_at': createdAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (syncState != null) 'sync_state': syncState,
    });
  }

  CartGroupsCompanion copyWith({
    Value<int>? id,
    Value<String?>? name,
    Value<bool>? processed,
    Value<DateTime>? createdAt,
    Value<bool>? syncStatus,
    Value<DateTime?>? lastSyncedAt,
    Value<String>? syncState,
  }) {
    return CartGroupsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      processed: processed ?? this.processed,
      createdAt: createdAt ?? this.createdAt,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      syncState: syncState ?? this.syncState,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (processed.present) {
      map['processed'] = Variable<bool>(processed.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<bool>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CartGroupsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('processed: $processed, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('syncState: $syncState')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, TransactionEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id)',
    ),
  );
  static const VerificationMeta _cartGroupIdMeta = const VerificationMeta(
    'cartGroupId',
  );
  @override
  late final GeneratedColumn<int> cartGroupId = GeneratedColumn<int>(
    'cart_group_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cart_groups (id)',
    ),
  );
  static const VerificationMeta _transactionTypeMeta = const VerificationMeta(
    'transactionType',
  );
  @override
  late final GeneratedColumn<String> transactionType = GeneratedColumn<String>(
    'transaction_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _conceptMeta = const VerificationMeta(
    'concept',
  );
  @override
  late final GeneratedColumn<String> concept = GeneratedColumn<String>(
    'concept',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _platformMeta = const VerificationMeta(
    'platform',
  );
  @override
  late final GeneratedColumn<String> platform = GeneratedColumn<String>(
    'platform',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<bool> syncStatus = GeneratedColumn<bool>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sync_status" IN (0, 1))',
    ),
    defaultValue: Constant(false),
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStateMeta = const VerificationMeta(
    'syncState',
  );
  @override
  late final GeneratedColumn<String> syncState = GeneratedColumn<String>(
    'sync_state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    cartGroupId,
    transactionType,
    quantity,
    unitPrice,
    totalAmount,
    concept,
    userId,
    platform,
    createdAt,
    syncStatus,
    lastSyncedAt,
    syncState,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('cart_group_id')) {
      context.handle(
        _cartGroupIdMeta,
        cartGroupId.isAcceptableOrUnknown(
          data['cart_group_id']!,
          _cartGroupIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cartGroupIdMeta);
    }
    if (data.containsKey('transaction_type')) {
      context.handle(
        _transactionTypeMeta,
        transactionType.isAcceptableOrUnknown(
          data['transaction_type']!,
          _transactionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionTypeMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    }
    if (data.containsKey('concept')) {
      context.handle(
        _conceptMeta,
        concept.isAcceptableOrUnknown(data['concept']!, _conceptMeta),
      );
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('platform')) {
      context.handle(
        _platformMeta,
        platform.isAcceptableOrUnknown(data['platform']!, _platformMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    if (data.containsKey('sync_state')) {
      context.handle(
        _syncStateMeta,
        syncState.isAcceptableOrUnknown(data['sync_state']!, _syncStateMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      cartGroupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cart_group_id'],
      )!,
      transactionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_type'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      ),
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      ),
      concept: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}concept'],
      ),
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      ),
      platform: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}platform'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sync_status'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
      syncState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_state'],
      )!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class TransactionEntity extends DataClass
    implements Insertable<TransactionEntity> {
  final int id;
  final String productId;
  final int cartGroupId;
  final String transactionType;
  final int quantity;
  final double? unitPrice;
  final double? totalAmount;
  final String? concept;
  final int? userId;
  final String? platform;
  final DateTime createdAt;
  final bool syncStatus;
  final DateTime? lastSyncedAt;
  final String syncState;
  const TransactionEntity({
    required this.id,
    required this.productId,
    required this.cartGroupId,
    required this.transactionType,
    required this.quantity,
    this.unitPrice,
    this.totalAmount,
    this.concept,
    this.userId,
    this.platform,
    required this.createdAt,
    required this.syncStatus,
    this.lastSyncedAt,
    required this.syncState,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<String>(productId);
    map['cart_group_id'] = Variable<int>(cartGroupId);
    map['transaction_type'] = Variable<String>(transactionType);
    map['quantity'] = Variable<int>(quantity);
    if (!nullToAbsent || unitPrice != null) {
      map['unit_price'] = Variable<double>(unitPrice);
    }
    if (!nullToAbsent || totalAmount != null) {
      map['total_amount'] = Variable<double>(totalAmount);
    }
    if (!nullToAbsent || concept != null) {
      map['concept'] = Variable<String>(concept);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    if (!nullToAbsent || platform != null) {
      map['platform'] = Variable<String>(platform);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['sync_status'] = Variable<bool>(syncStatus);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    map['sync_state'] = Variable<String>(syncState);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      productId: Value(productId),
      cartGroupId: Value(cartGroupId),
      transactionType: Value(transactionType),
      quantity: Value(quantity),
      unitPrice: unitPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(unitPrice),
      totalAmount: totalAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(totalAmount),
      concept: concept == null && nullToAbsent
          ? const Value.absent()
          : Value(concept),
      userId: userId == null && nullToAbsent
          ? const Value.absent()
          : Value(userId),
      platform: platform == null && nullToAbsent
          ? const Value.absent()
          : Value(platform),
      createdAt: Value(createdAt),
      syncStatus: Value(syncStatus),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
      syncState: Value(syncState),
    );
  }

  factory TransactionEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionEntity(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<String>(json['productId']),
      cartGroupId: serializer.fromJson<int>(json['cartGroupId']),
      transactionType: serializer.fromJson<String>(json['transactionType']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unitPrice: serializer.fromJson<double?>(json['unitPrice']),
      totalAmount: serializer.fromJson<double?>(json['totalAmount']),
      concept: serializer.fromJson<String?>(json['concept']),
      userId: serializer.fromJson<int?>(json['userId']),
      platform: serializer.fromJson<String?>(json['platform']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncStatus: serializer.fromJson<bool>(json['syncStatus']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
      syncState: serializer.fromJson<String>(json['syncState']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<String>(productId),
      'cartGroupId': serializer.toJson<int>(cartGroupId),
      'transactionType': serializer.toJson<String>(transactionType),
      'quantity': serializer.toJson<int>(quantity),
      'unitPrice': serializer.toJson<double?>(unitPrice),
      'totalAmount': serializer.toJson<double?>(totalAmount),
      'concept': serializer.toJson<String?>(concept),
      'userId': serializer.toJson<int?>(userId),
      'platform': serializer.toJson<String?>(platform),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncStatus': serializer.toJson<bool>(syncStatus),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
      'syncState': serializer.toJson<String>(syncState),
    };
  }

  TransactionEntity copyWith({
    int? id,
    String? productId,
    int? cartGroupId,
    String? transactionType,
    int? quantity,
    Value<double?> unitPrice = const Value.absent(),
    Value<double?> totalAmount = const Value.absent(),
    Value<String?> concept = const Value.absent(),
    Value<int?> userId = const Value.absent(),
    Value<String?> platform = const Value.absent(),
    DateTime? createdAt,
    bool? syncStatus,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
    String? syncState,
  }) => TransactionEntity(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    cartGroupId: cartGroupId ?? this.cartGroupId,
    transactionType: transactionType ?? this.transactionType,
    quantity: quantity ?? this.quantity,
    unitPrice: unitPrice.present ? unitPrice.value : this.unitPrice,
    totalAmount: totalAmount.present ? totalAmount.value : this.totalAmount,
    concept: concept.present ? concept.value : this.concept,
    userId: userId.present ? userId.value : this.userId,
    platform: platform.present ? platform.value : this.platform,
    createdAt: createdAt ?? this.createdAt,
    syncStatus: syncStatus ?? this.syncStatus,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
    syncState: syncState ?? this.syncState,
  );
  TransactionEntity copyWithCompanion(TransactionsCompanion data) {
    return TransactionEntity(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      cartGroupId: data.cartGroupId.present
          ? data.cartGroupId.value
          : this.cartGroupId,
      transactionType: data.transactionType.present
          ? data.transactionType.value
          : this.transactionType,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      concept: data.concept.present ? data.concept.value : this.concept,
      userId: data.userId.present ? data.userId.value : this.userId,
      platform: data.platform.present ? data.platform.value : this.platform,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionEntity(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('cartGroupId: $cartGroupId, ')
          ..write('transactionType: $transactionType, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('concept: $concept, ')
          ..write('userId: $userId, ')
          ..write('platform: $platform, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('syncState: $syncState')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    cartGroupId,
    transactionType,
    quantity,
    unitPrice,
    totalAmount,
    concept,
    userId,
    platform,
    createdAt,
    syncStatus,
    lastSyncedAt,
    syncState,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionEntity &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.cartGroupId == this.cartGroupId &&
          other.transactionType == this.transactionType &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.totalAmount == this.totalAmount &&
          other.concept == this.concept &&
          other.userId == this.userId &&
          other.platform == this.platform &&
          other.createdAt == this.createdAt &&
          other.syncStatus == this.syncStatus &&
          other.lastSyncedAt == this.lastSyncedAt &&
          other.syncState == this.syncState);
}

class TransactionsCompanion extends UpdateCompanion<TransactionEntity> {
  final Value<int> id;
  final Value<String> productId;
  final Value<int> cartGroupId;
  final Value<String> transactionType;
  final Value<int> quantity;
  final Value<double?> unitPrice;
  final Value<double?> totalAmount;
  final Value<String?> concept;
  final Value<int?> userId;
  final Value<String?> platform;
  final Value<DateTime> createdAt;
  final Value<bool> syncStatus;
  final Value<DateTime?> lastSyncedAt;
  final Value<String> syncState;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.cartGroupId = const Value.absent(),
    this.transactionType = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.concept = const Value.absent(),
    this.userId = const Value.absent(),
    this.platform = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.syncState = const Value.absent(),
  });
  TransactionsCompanion.insert({
    this.id = const Value.absent(),
    required String productId,
    required int cartGroupId,
    required String transactionType,
    required int quantity,
    this.unitPrice = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.concept = const Value.absent(),
    this.userId = const Value.absent(),
    this.platform = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
    this.syncState = const Value.absent(),
  }) : productId = Value(productId),
       cartGroupId = Value(cartGroupId),
       transactionType = Value(transactionType),
       quantity = Value(quantity);
  static Insertable<TransactionEntity> custom({
    Expression<int>? id,
    Expression<String>? productId,
    Expression<int>? cartGroupId,
    Expression<String>? transactionType,
    Expression<int>? quantity,
    Expression<double>? unitPrice,
    Expression<double>? totalAmount,
    Expression<String>? concept,
    Expression<int>? userId,
    Expression<String>? platform,
    Expression<DateTime>? createdAt,
    Expression<bool>? syncStatus,
    Expression<DateTime>? lastSyncedAt,
    Expression<String>? syncState,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (cartGroupId != null) 'cart_group_id': cartGroupId,
      if (transactionType != null) 'transaction_type': transactionType,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (concept != null) 'concept': concept,
      if (userId != null) 'user_id': userId,
      if (platform != null) 'platform': platform,
      if (createdAt != null) 'created_at': createdAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
      if (syncState != null) 'sync_state': syncState,
    });
  }

  TransactionsCompanion copyWith({
    Value<int>? id,
    Value<String>? productId,
    Value<int>? cartGroupId,
    Value<String>? transactionType,
    Value<int>? quantity,
    Value<double?>? unitPrice,
    Value<double?>? totalAmount,
    Value<String?>? concept,
    Value<int?>? userId,
    Value<String?>? platform,
    Value<DateTime>? createdAt,
    Value<bool>? syncStatus,
    Value<DateTime?>? lastSyncedAt,
    Value<String>? syncState,
  }) {
    return TransactionsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      cartGroupId: cartGroupId ?? this.cartGroupId,
      transactionType: transactionType ?? this.transactionType,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalAmount: totalAmount ?? this.totalAmount,
      concept: concept ?? this.concept,
      userId: userId ?? this.userId,
      platform: platform ?? this.platform,
      createdAt: createdAt ?? this.createdAt,
      syncStatus: syncStatus ?? this.syncStatus,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      syncState: syncState ?? this.syncState,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (cartGroupId.present) {
      map['cart_group_id'] = Variable<int>(cartGroupId.value);
    }
    if (transactionType.present) {
      map['transaction_type'] = Variable<String>(transactionType.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (concept.present) {
      map['concept'] = Variable<String>(concept.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (platform.present) {
      map['platform'] = Variable<String>(platform.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<bool>(syncStatus.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    if (syncState.present) {
      map['sync_state'] = Variable<String>(syncState.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('cartGroupId: $cartGroupId, ')
          ..write('transactionType: $transactionType, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('concept: $concept, ')
          ..write('userId: $userId, ')
          ..write('platform: $platform, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('lastSyncedAt: $lastSyncedAt, ')
          ..write('syncState: $syncState')
          ..write(')'))
        .toString();
  }
}

class $BusinesssTable extends Businesss
    with TableInfo<$BusinesssTable, BusinessEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BusinesssTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idbusinessMeta = const VerificationMeta(
    'idbusiness',
  );
  @override
  late final GeneratedColumn<String> idbusiness = GeneratedColumn<String>(
    'idbusiness',
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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _websiteMeta = const VerificationMeta(
    'website',
  );
  @override
  late final GeneratedColumn<String> website = GeneratedColumn<String>(
    'website',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _direccionMeta = const VerificationMeta(
    'direccion',
  );
  @override
  late final GeneratedColumn<String> direccion = GeneratedColumn<String>(
    'direccion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paisMeta = const VerificationMeta('pais');
  @override
  late final GeneratedColumn<String> pais = GeneratedColumn<String>(
    'pais',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ciudadMeta = const VerificationMeta('ciudad');
  @override
  late final GeneratedColumn<String> ciudad = GeneratedColumn<String>(
    'ciudad',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudMeta = const VerificationMeta(
    'latitud',
  );
  @override
  late final GeneratedColumn<String> latitud = GeneratedColumn<String>(
    'latitud',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudMeta = const VerificationMeta(
    'longitud',
  );
  @override
  late final GeneratedColumn<String> longitud = GeneratedColumn<String>(
    'longitud',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _acteconomicaMeta = const VerificationMeta(
    'acteconomica',
  );
  @override
  late final GeneratedColumn<String> acteconomica = GeneratedColumn<String>(
    'acteconomica',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _celularMeta = const VerificationMeta(
    'celular',
  );
  @override
  late final GeneratedColumn<String> celular = GeneratedColumn<String>(
    'celular',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdatMeta = const VerificationMeta(
    'createdat',
  );
  @override
  late final GeneratedColumn<DateTime> createdat = GeneratedColumn<DateTime>(
    'createdat',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    idbusiness,
    name,
    website,
    email,
    direccion,
    pais,
    ciudad,
    latitud,
    longitud,
    acteconomica,
    celular,
    createdat,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'businesss';
  @override
  VerificationContext validateIntegrity(
    Insertable<BusinessEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('idbusiness')) {
      context.handle(
        _idbusinessMeta,
        idbusiness.isAcceptableOrUnknown(data['idbusiness']!, _idbusinessMeta),
      );
    } else if (isInserting) {
      context.missing(_idbusinessMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('website')) {
      context.handle(
        _websiteMeta,
        website.isAcceptableOrUnknown(data['website']!, _websiteMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('direccion')) {
      context.handle(
        _direccionMeta,
        direccion.isAcceptableOrUnknown(data['direccion']!, _direccionMeta),
      );
    }
    if (data.containsKey('pais')) {
      context.handle(
        _paisMeta,
        pais.isAcceptableOrUnknown(data['pais']!, _paisMeta),
      );
    }
    if (data.containsKey('ciudad')) {
      context.handle(
        _ciudadMeta,
        ciudad.isAcceptableOrUnknown(data['ciudad']!, _ciudadMeta),
      );
    }
    if (data.containsKey('latitud')) {
      context.handle(
        _latitudMeta,
        latitud.isAcceptableOrUnknown(data['latitud']!, _latitudMeta),
      );
    }
    if (data.containsKey('longitud')) {
      context.handle(
        _longitudMeta,
        longitud.isAcceptableOrUnknown(data['longitud']!, _longitudMeta),
      );
    }
    if (data.containsKey('acteconomica')) {
      context.handle(
        _acteconomicaMeta,
        acteconomica.isAcceptableOrUnknown(
          data['acteconomica']!,
          _acteconomicaMeta,
        ),
      );
    }
    if (data.containsKey('celular')) {
      context.handle(
        _celularMeta,
        celular.isAcceptableOrUnknown(data['celular']!, _celularMeta),
      );
    }
    if (data.containsKey('createdat')) {
      context.handle(
        _createdatMeta,
        createdat.isAcceptableOrUnknown(data['createdat']!, _createdatMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {idbusiness};
  @override
  BusinessEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BusinessEntity(
      idbusiness: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}idbusiness'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      website: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}website'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      direccion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direccion'],
      ),
      pais: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pais'],
      ),
      ciudad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ciudad'],
      ),
      latitud: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}latitud'],
      ),
      longitud: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}longitud'],
      ),
      acteconomica: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}acteconomica'],
      ),
      celular: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}celular'],
      ),
      createdat: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}createdat'],
      )!,
    );
  }

  @override
  $BusinesssTable createAlias(String alias) {
    return $BusinesssTable(attachedDatabase, alias);
  }
}

class BusinessEntity extends DataClass implements Insertable<BusinessEntity> {
  final String idbusiness;
  final String? name;
  final String? website;
  final String? email;
  final String? direccion;
  final String? pais;
  final String? ciudad;
  final String? latitud;
  final String? longitud;
  final String? acteconomica;
  final String? celular;
  final DateTime createdat;
  const BusinessEntity({
    required this.idbusiness,
    this.name,
    this.website,
    this.email,
    this.direccion,
    this.pais,
    this.ciudad,
    this.latitud,
    this.longitud,
    this.acteconomica,
    this.celular,
    required this.createdat,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['idbusiness'] = Variable<String>(idbusiness);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || website != null) {
      map['website'] = Variable<String>(website);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || direccion != null) {
      map['direccion'] = Variable<String>(direccion);
    }
    if (!nullToAbsent || pais != null) {
      map['pais'] = Variable<String>(pais);
    }
    if (!nullToAbsent || ciudad != null) {
      map['ciudad'] = Variable<String>(ciudad);
    }
    if (!nullToAbsent || latitud != null) {
      map['latitud'] = Variable<String>(latitud);
    }
    if (!nullToAbsent || longitud != null) {
      map['longitud'] = Variable<String>(longitud);
    }
    if (!nullToAbsent || acteconomica != null) {
      map['acteconomica'] = Variable<String>(acteconomica);
    }
    if (!nullToAbsent || celular != null) {
      map['celular'] = Variable<String>(celular);
    }
    map['createdat'] = Variable<DateTime>(createdat);
    return map;
  }

  BusinesssCompanion toCompanion(bool nullToAbsent) {
    return BusinesssCompanion(
      idbusiness: Value(idbusiness),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      website: website == null && nullToAbsent
          ? const Value.absent()
          : Value(website),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      direccion: direccion == null && nullToAbsent
          ? const Value.absent()
          : Value(direccion),
      pais: pais == null && nullToAbsent ? const Value.absent() : Value(pais),
      ciudad: ciudad == null && nullToAbsent
          ? const Value.absent()
          : Value(ciudad),
      latitud: latitud == null && nullToAbsent
          ? const Value.absent()
          : Value(latitud),
      longitud: longitud == null && nullToAbsent
          ? const Value.absent()
          : Value(longitud),
      acteconomica: acteconomica == null && nullToAbsent
          ? const Value.absent()
          : Value(acteconomica),
      celular: celular == null && nullToAbsent
          ? const Value.absent()
          : Value(celular),
      createdat: Value(createdat),
    );
  }

  factory BusinessEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BusinessEntity(
      idbusiness: serializer.fromJson<String>(json['idbusiness']),
      name: serializer.fromJson<String?>(json['name']),
      website: serializer.fromJson<String?>(json['website']),
      email: serializer.fromJson<String?>(json['email']),
      direccion: serializer.fromJson<String?>(json['direccion']),
      pais: serializer.fromJson<String?>(json['pais']),
      ciudad: serializer.fromJson<String?>(json['ciudad']),
      latitud: serializer.fromJson<String?>(json['latitud']),
      longitud: serializer.fromJson<String?>(json['longitud']),
      acteconomica: serializer.fromJson<String?>(json['acteconomica']),
      celular: serializer.fromJson<String?>(json['celular']),
      createdat: serializer.fromJson<DateTime>(json['createdat']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'idbusiness': serializer.toJson<String>(idbusiness),
      'name': serializer.toJson<String?>(name),
      'website': serializer.toJson<String?>(website),
      'email': serializer.toJson<String?>(email),
      'direccion': serializer.toJson<String?>(direccion),
      'pais': serializer.toJson<String?>(pais),
      'ciudad': serializer.toJson<String?>(ciudad),
      'latitud': serializer.toJson<String?>(latitud),
      'longitud': serializer.toJson<String?>(longitud),
      'acteconomica': serializer.toJson<String?>(acteconomica),
      'celular': serializer.toJson<String?>(celular),
      'createdat': serializer.toJson<DateTime>(createdat),
    };
  }

  BusinessEntity copyWith({
    String? idbusiness,
    Value<String?> name = const Value.absent(),
    Value<String?> website = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> direccion = const Value.absent(),
    Value<String?> pais = const Value.absent(),
    Value<String?> ciudad = const Value.absent(),
    Value<String?> latitud = const Value.absent(),
    Value<String?> longitud = const Value.absent(),
    Value<String?> acteconomica = const Value.absent(),
    Value<String?> celular = const Value.absent(),
    DateTime? createdat,
  }) => BusinessEntity(
    idbusiness: idbusiness ?? this.idbusiness,
    name: name.present ? name.value : this.name,
    website: website.present ? website.value : this.website,
    email: email.present ? email.value : this.email,
    direccion: direccion.present ? direccion.value : this.direccion,
    pais: pais.present ? pais.value : this.pais,
    ciudad: ciudad.present ? ciudad.value : this.ciudad,
    latitud: latitud.present ? latitud.value : this.latitud,
    longitud: longitud.present ? longitud.value : this.longitud,
    acteconomica: acteconomica.present ? acteconomica.value : this.acteconomica,
    celular: celular.present ? celular.value : this.celular,
    createdat: createdat ?? this.createdat,
  );
  BusinessEntity copyWithCompanion(BusinesssCompanion data) {
    return BusinessEntity(
      idbusiness: data.idbusiness.present
          ? data.idbusiness.value
          : this.idbusiness,
      name: data.name.present ? data.name.value : this.name,
      website: data.website.present ? data.website.value : this.website,
      email: data.email.present ? data.email.value : this.email,
      direccion: data.direccion.present ? data.direccion.value : this.direccion,
      pais: data.pais.present ? data.pais.value : this.pais,
      ciudad: data.ciudad.present ? data.ciudad.value : this.ciudad,
      latitud: data.latitud.present ? data.latitud.value : this.latitud,
      longitud: data.longitud.present ? data.longitud.value : this.longitud,
      acteconomica: data.acteconomica.present
          ? data.acteconomica.value
          : this.acteconomica,
      celular: data.celular.present ? data.celular.value : this.celular,
      createdat: data.createdat.present ? data.createdat.value : this.createdat,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BusinessEntity(')
          ..write('idbusiness: $idbusiness, ')
          ..write('name: $name, ')
          ..write('website: $website, ')
          ..write('email: $email, ')
          ..write('direccion: $direccion, ')
          ..write('pais: $pais, ')
          ..write('ciudad: $ciudad, ')
          ..write('latitud: $latitud, ')
          ..write('longitud: $longitud, ')
          ..write('acteconomica: $acteconomica, ')
          ..write('celular: $celular, ')
          ..write('createdat: $createdat')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    idbusiness,
    name,
    website,
    email,
    direccion,
    pais,
    ciudad,
    latitud,
    longitud,
    acteconomica,
    celular,
    createdat,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BusinessEntity &&
          other.idbusiness == this.idbusiness &&
          other.name == this.name &&
          other.website == this.website &&
          other.email == this.email &&
          other.direccion == this.direccion &&
          other.pais == this.pais &&
          other.ciudad == this.ciudad &&
          other.latitud == this.latitud &&
          other.longitud == this.longitud &&
          other.acteconomica == this.acteconomica &&
          other.celular == this.celular &&
          other.createdat == this.createdat);
}

class BusinesssCompanion extends UpdateCompanion<BusinessEntity> {
  final Value<String> idbusiness;
  final Value<String?> name;
  final Value<String?> website;
  final Value<String?> email;
  final Value<String?> direccion;
  final Value<String?> pais;
  final Value<String?> ciudad;
  final Value<String?> latitud;
  final Value<String?> longitud;
  final Value<String?> acteconomica;
  final Value<String?> celular;
  final Value<DateTime> createdat;
  final Value<int> rowid;
  const BusinesssCompanion({
    this.idbusiness = const Value.absent(),
    this.name = const Value.absent(),
    this.website = const Value.absent(),
    this.email = const Value.absent(),
    this.direccion = const Value.absent(),
    this.pais = const Value.absent(),
    this.ciudad = const Value.absent(),
    this.latitud = const Value.absent(),
    this.longitud = const Value.absent(),
    this.acteconomica = const Value.absent(),
    this.celular = const Value.absent(),
    this.createdat = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BusinesssCompanion.insert({
    required String idbusiness,
    this.name = const Value.absent(),
    this.website = const Value.absent(),
    this.email = const Value.absent(),
    this.direccion = const Value.absent(),
    this.pais = const Value.absent(),
    this.ciudad = const Value.absent(),
    this.latitud = const Value.absent(),
    this.longitud = const Value.absent(),
    this.acteconomica = const Value.absent(),
    this.celular = const Value.absent(),
    this.createdat = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : idbusiness = Value(idbusiness);
  static Insertable<BusinessEntity> custom({
    Expression<String>? idbusiness,
    Expression<String>? name,
    Expression<String>? website,
    Expression<String>? email,
    Expression<String>? direccion,
    Expression<String>? pais,
    Expression<String>? ciudad,
    Expression<String>? latitud,
    Expression<String>? longitud,
    Expression<String>? acteconomica,
    Expression<String>? celular,
    Expression<DateTime>? createdat,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (idbusiness != null) 'idbusiness': idbusiness,
      if (name != null) 'name': name,
      if (website != null) 'website': website,
      if (email != null) 'email': email,
      if (direccion != null) 'direccion': direccion,
      if (pais != null) 'pais': pais,
      if (ciudad != null) 'ciudad': ciudad,
      if (latitud != null) 'latitud': latitud,
      if (longitud != null) 'longitud': longitud,
      if (acteconomica != null) 'acteconomica': acteconomica,
      if (celular != null) 'celular': celular,
      if (createdat != null) 'createdat': createdat,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BusinesssCompanion copyWith({
    Value<String>? idbusiness,
    Value<String?>? name,
    Value<String?>? website,
    Value<String?>? email,
    Value<String?>? direccion,
    Value<String?>? pais,
    Value<String?>? ciudad,
    Value<String?>? latitud,
    Value<String?>? longitud,
    Value<String?>? acteconomica,
    Value<String?>? celular,
    Value<DateTime>? createdat,
    Value<int>? rowid,
  }) {
    return BusinesssCompanion(
      idbusiness: idbusiness ?? this.idbusiness,
      name: name ?? this.name,
      website: website ?? this.website,
      email: email ?? this.email,
      direccion: direccion ?? this.direccion,
      pais: pais ?? this.pais,
      ciudad: ciudad ?? this.ciudad,
      latitud: latitud ?? this.latitud,
      longitud: longitud ?? this.longitud,
      acteconomica: acteconomica ?? this.acteconomica,
      celular: celular ?? this.celular,
      createdat: createdat ?? this.createdat,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (idbusiness.present) {
      map['idbusiness'] = Variable<String>(idbusiness.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (website.present) {
      map['website'] = Variable<String>(website.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (direccion.present) {
      map['direccion'] = Variable<String>(direccion.value);
    }
    if (pais.present) {
      map['pais'] = Variable<String>(pais.value);
    }
    if (ciudad.present) {
      map['ciudad'] = Variable<String>(ciudad.value);
    }
    if (latitud.present) {
      map['latitud'] = Variable<String>(latitud.value);
    }
    if (longitud.present) {
      map['longitud'] = Variable<String>(longitud.value);
    }
    if (acteconomica.present) {
      map['acteconomica'] = Variable<String>(acteconomica.value);
    }
    if (celular.present) {
      map['celular'] = Variable<String>(celular.value);
    }
    if (createdat.present) {
      map['createdat'] = Variable<DateTime>(createdat.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BusinesssCompanion(')
          ..write('idbusiness: $idbusiness, ')
          ..write('name: $name, ')
          ..write('website: $website, ')
          ..write('email: $email, ')
          ..write('direccion: $direccion, ')
          ..write('pais: $pais, ')
          ..write('ciudad: $ciudad, ')
          ..write('latitud: $latitud, ')
          ..write('longitud: $longitud, ')
          ..write('acteconomica: $acteconomica, ')
          ..write('celular: $celular, ')
          ..write('createdat: $createdat, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, UsersEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tenantidMeta = const VerificationMeta(
    'tenantid',
  );
  @override
  late final GeneratedColumn<String> tenantid = GeneratedColumn<String>(
    'tenantid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES businesss (idbusiness)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _direccionMeta = const VerificationMeta(
    'direccion',
  );
  @override
  late final GeneratedColumn<String> direccion = GeneratedColumn<String>(
    'direccion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paisMeta = const VerificationMeta('pais');
  @override
  late final GeneratedColumn<String> pais = GeneratedColumn<String>(
    'pais',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ciudadMeta = const VerificationMeta('ciudad');
  @override
  late final GeneratedColumn<String> ciudad = GeneratedColumn<String>(
    'ciudad',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _celularMeta = const VerificationMeta(
    'celular',
  );
  @override
  late final GeneratedColumn<String> celular = GeneratedColumn<String>(
    'celular',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idbusinessMeta = const VerificationMeta(
    'idbusiness',
  );
  @override
  late final GeneratedColumn<String> idbusiness = GeneratedColumn<String>(
    'idbusiness',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idrolMeta = const VerificationMeta('idrol');
  @override
  late final GeneratedColumn<int> idrol = GeneratedColumn<int>(
    'idrol',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isGuestMeta = const VerificationMeta(
    'isGuest',
  );
  @override
  late final GeneratedColumn<bool> isGuest = GeneratedColumn<bool>(
    'is_guest',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_guest" IN (0, 1))',
    ),
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _platformMeta = const VerificationMeta(
    'platform',
  );
  @override
  late final GeneratedColumn<String> platform = GeneratedColumn<String>(
    'platform',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantid,
    name,
    email,
    direccion,
    pais,
    ciudad,
    celular,
    createdAt,
    username,
    phone,
    idbusiness,
    idrol,
    isGuest,
    deviceId,
    platform,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<UsersEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tenantid')) {
      context.handle(
        _tenantidMeta,
        tenantid.isAcceptableOrUnknown(data['tenantid']!, _tenantidMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('direccion')) {
      context.handle(
        _direccionMeta,
        direccion.isAcceptableOrUnknown(data['direccion']!, _direccionMeta),
      );
    }
    if (data.containsKey('pais')) {
      context.handle(
        _paisMeta,
        pais.isAcceptableOrUnknown(data['pais']!, _paisMeta),
      );
    }
    if (data.containsKey('ciudad')) {
      context.handle(
        _ciudadMeta,
        ciudad.isAcceptableOrUnknown(data['ciudad']!, _ciudadMeta),
      );
    }
    if (data.containsKey('celular')) {
      context.handle(
        _celularMeta,
        celular.isAcceptableOrUnknown(data['celular']!, _celularMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('idbusiness')) {
      context.handle(
        _idbusinessMeta,
        idbusiness.isAcceptableOrUnknown(data['idbusiness']!, _idbusinessMeta),
      );
    }
    if (data.containsKey('idrol')) {
      context.handle(
        _idrolMeta,
        idrol.isAcceptableOrUnknown(data['idrol']!, _idrolMeta),
      );
    }
    if (data.containsKey('is_guest')) {
      context.handle(
        _isGuestMeta,
        isGuest.isAcceptableOrUnknown(data['is_guest']!, _isGuestMeta),
      );
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    }
    if (data.containsKey('platform')) {
      context.handle(
        _platformMeta,
        platform.isAcceptableOrUnknown(data['platform']!, _platformMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UsersEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UsersEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tenantid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenantid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      direccion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direccion'],
      ),
      pais: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pais'],
      ),
      ciudad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ciudad'],
      ),
      celular: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}celular'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      idbusiness: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}idbusiness'],
      ),
      idrol: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}idrol'],
      ),
      isGuest: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_guest'],
      ),
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      ),
      platform: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}platform'],
      ),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class UsersEntity extends DataClass implements Insertable<UsersEntity> {
  final int id;
  final String tenantid;
  final String? name;
  final String? email;
  final String? direccion;
  final String? pais;
  final String? ciudad;
  final String? celular;
  final DateTime? createdAt;
  final String? username;
  final String? phone;
  final String? idbusiness;
  final int? idrol;
  final bool? isGuest;
  final String? deviceId;
  final String? platform;
  const UsersEntity({
    required this.id,
    required this.tenantid,
    this.name,
    this.email,
    this.direccion,
    this.pais,
    this.ciudad,
    this.celular,
    this.createdAt,
    this.username,
    this.phone,
    this.idbusiness,
    this.idrol,
    this.isGuest,
    this.deviceId,
    this.platform,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tenantid'] = Variable<String>(tenantid);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || direccion != null) {
      map['direccion'] = Variable<String>(direccion);
    }
    if (!nullToAbsent || pais != null) {
      map['pais'] = Variable<String>(pais);
    }
    if (!nullToAbsent || ciudad != null) {
      map['ciudad'] = Variable<String>(ciudad);
    }
    if (!nullToAbsent || celular != null) {
      map['celular'] = Variable<String>(celular);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || idbusiness != null) {
      map['idbusiness'] = Variable<String>(idbusiness);
    }
    if (!nullToAbsent || idrol != null) {
      map['idrol'] = Variable<int>(idrol);
    }
    if (!nullToAbsent || isGuest != null) {
      map['is_guest'] = Variable<bool>(isGuest);
    }
    if (!nullToAbsent || deviceId != null) {
      map['device_id'] = Variable<String>(deviceId);
    }
    if (!nullToAbsent || platform != null) {
      map['platform'] = Variable<String>(platform);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      tenantid: Value(tenantid),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      direccion: direccion == null && nullToAbsent
          ? const Value.absent()
          : Value(direccion),
      pais: pais == null && nullToAbsent ? const Value.absent() : Value(pais),
      ciudad: ciudad == null && nullToAbsent
          ? const Value.absent()
          : Value(ciudad),
      celular: celular == null && nullToAbsent
          ? const Value.absent()
          : Value(celular),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      idbusiness: idbusiness == null && nullToAbsent
          ? const Value.absent()
          : Value(idbusiness),
      idrol: idrol == null && nullToAbsent
          ? const Value.absent()
          : Value(idrol),
      isGuest: isGuest == null && nullToAbsent
          ? const Value.absent()
          : Value(isGuest),
      deviceId: deviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceId),
      platform: platform == null && nullToAbsent
          ? const Value.absent()
          : Value(platform),
    );
  }

  factory UsersEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsersEntity(
      id: serializer.fromJson<int>(json['id']),
      tenantid: serializer.fromJson<String>(json['tenantid']),
      name: serializer.fromJson<String?>(json['name']),
      email: serializer.fromJson<String?>(json['email']),
      direccion: serializer.fromJson<String?>(json['direccion']),
      pais: serializer.fromJson<String?>(json['pais']),
      ciudad: serializer.fromJson<String?>(json['ciudad']),
      celular: serializer.fromJson<String?>(json['celular']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      username: serializer.fromJson<String?>(json['username']),
      phone: serializer.fromJson<String?>(json['phone']),
      idbusiness: serializer.fromJson<String?>(json['idbusiness']),
      idrol: serializer.fromJson<int?>(json['idrol']),
      isGuest: serializer.fromJson<bool?>(json['isGuest']),
      deviceId: serializer.fromJson<String?>(json['deviceId']),
      platform: serializer.fromJson<String?>(json['platform']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tenantid': serializer.toJson<String>(tenantid),
      'name': serializer.toJson<String?>(name),
      'email': serializer.toJson<String?>(email),
      'direccion': serializer.toJson<String?>(direccion),
      'pais': serializer.toJson<String?>(pais),
      'ciudad': serializer.toJson<String?>(ciudad),
      'celular': serializer.toJson<String?>(celular),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'username': serializer.toJson<String?>(username),
      'phone': serializer.toJson<String?>(phone),
      'idbusiness': serializer.toJson<String?>(idbusiness),
      'idrol': serializer.toJson<int?>(idrol),
      'isGuest': serializer.toJson<bool?>(isGuest),
      'deviceId': serializer.toJson<String?>(deviceId),
      'platform': serializer.toJson<String?>(platform),
    };
  }

  UsersEntity copyWith({
    int? id,
    String? tenantid,
    Value<String?> name = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> direccion = const Value.absent(),
    Value<String?> pais = const Value.absent(),
    Value<String?> ciudad = const Value.absent(),
    Value<String?> celular = const Value.absent(),
    Value<DateTime?> createdAt = const Value.absent(),
    Value<String?> username = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> idbusiness = const Value.absent(),
    Value<int?> idrol = const Value.absent(),
    Value<bool?> isGuest = const Value.absent(),
    Value<String?> deviceId = const Value.absent(),
    Value<String?> platform = const Value.absent(),
  }) => UsersEntity(
    id: id ?? this.id,
    tenantid: tenantid ?? this.tenantid,
    name: name.present ? name.value : this.name,
    email: email.present ? email.value : this.email,
    direccion: direccion.present ? direccion.value : this.direccion,
    pais: pais.present ? pais.value : this.pais,
    ciudad: ciudad.present ? ciudad.value : this.ciudad,
    celular: celular.present ? celular.value : this.celular,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    username: username.present ? username.value : this.username,
    phone: phone.present ? phone.value : this.phone,
    idbusiness: idbusiness.present ? idbusiness.value : this.idbusiness,
    idrol: idrol.present ? idrol.value : this.idrol,
    isGuest: isGuest.present ? isGuest.value : this.isGuest,
    deviceId: deviceId.present ? deviceId.value : this.deviceId,
    platform: platform.present ? platform.value : this.platform,
  );
  UsersEntity copyWithCompanion(UsersCompanion data) {
    return UsersEntity(
      id: data.id.present ? data.id.value : this.id,
      tenantid: data.tenantid.present ? data.tenantid.value : this.tenantid,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      direccion: data.direccion.present ? data.direccion.value : this.direccion,
      pais: data.pais.present ? data.pais.value : this.pais,
      ciudad: data.ciudad.present ? data.ciudad.value : this.ciudad,
      celular: data.celular.present ? data.celular.value : this.celular,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      username: data.username.present ? data.username.value : this.username,
      phone: data.phone.present ? data.phone.value : this.phone,
      idbusiness: data.idbusiness.present
          ? data.idbusiness.value
          : this.idbusiness,
      idrol: data.idrol.present ? data.idrol.value : this.idrol,
      isGuest: data.isGuest.present ? data.isGuest.value : this.isGuest,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      platform: data.platform.present ? data.platform.value : this.platform,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UsersEntity(')
          ..write('id: $id, ')
          ..write('tenantid: $tenantid, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('direccion: $direccion, ')
          ..write('pais: $pais, ')
          ..write('ciudad: $ciudad, ')
          ..write('celular: $celular, ')
          ..write('createdAt: $createdAt, ')
          ..write('username: $username, ')
          ..write('phone: $phone, ')
          ..write('idbusiness: $idbusiness, ')
          ..write('idrol: $idrol, ')
          ..write('isGuest: $isGuest, ')
          ..write('deviceId: $deviceId, ')
          ..write('platform: $platform')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantid,
    name,
    email,
    direccion,
    pais,
    ciudad,
    celular,
    createdAt,
    username,
    phone,
    idbusiness,
    idrol,
    isGuest,
    deviceId,
    platform,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsersEntity &&
          other.id == this.id &&
          other.tenantid == this.tenantid &&
          other.name == this.name &&
          other.email == this.email &&
          other.direccion == this.direccion &&
          other.pais == this.pais &&
          other.ciudad == this.ciudad &&
          other.celular == this.celular &&
          other.createdAt == this.createdAt &&
          other.username == this.username &&
          other.phone == this.phone &&
          other.idbusiness == this.idbusiness &&
          other.idrol == this.idrol &&
          other.isGuest == this.isGuest &&
          other.deviceId == this.deviceId &&
          other.platform == this.platform);
}

class UsersCompanion extends UpdateCompanion<UsersEntity> {
  final Value<int> id;
  final Value<String> tenantid;
  final Value<String?> name;
  final Value<String?> email;
  final Value<String?> direccion;
  final Value<String?> pais;
  final Value<String?> ciudad;
  final Value<String?> celular;
  final Value<DateTime?> createdAt;
  final Value<String?> username;
  final Value<String?> phone;
  final Value<String?> idbusiness;
  final Value<int?> idrol;
  final Value<bool?> isGuest;
  final Value<String?> deviceId;
  final Value<String?> platform;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.tenantid = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.direccion = const Value.absent(),
    this.pais = const Value.absent(),
    this.ciudad = const Value.absent(),
    this.celular = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.username = const Value.absent(),
    this.phone = const Value.absent(),
    this.idbusiness = const Value.absent(),
    this.idrol = const Value.absent(),
    this.isGuest = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.platform = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String tenantid,
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.direccion = const Value.absent(),
    this.pais = const Value.absent(),
    this.ciudad = const Value.absent(),
    this.celular = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.username = const Value.absent(),
    this.phone = const Value.absent(),
    this.idbusiness = const Value.absent(),
    this.idrol = const Value.absent(),
    this.isGuest = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.platform = const Value.absent(),
  }) : tenantid = Value(tenantid);
  static Insertable<UsersEntity> custom({
    Expression<int>? id,
    Expression<String>? tenantid,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? direccion,
    Expression<String>? pais,
    Expression<String>? ciudad,
    Expression<String>? celular,
    Expression<DateTime>? createdAt,
    Expression<String>? username,
    Expression<String>? phone,
    Expression<String>? idbusiness,
    Expression<int>? idrol,
    Expression<bool>? isGuest,
    Expression<String>? deviceId,
    Expression<String>? platform,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantid != null) 'tenantid': tenantid,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (direccion != null) 'direccion': direccion,
      if (pais != null) 'pais': pais,
      if (ciudad != null) 'ciudad': ciudad,
      if (celular != null) 'celular': celular,
      if (createdAt != null) 'created_at': createdAt,
      if (username != null) 'username': username,
      if (phone != null) 'phone': phone,
      if (idbusiness != null) 'idbusiness': idbusiness,
      if (idrol != null) 'idrol': idrol,
      if (isGuest != null) 'is_guest': isGuest,
      if (deviceId != null) 'device_id': deviceId,
      if (platform != null) 'platform': platform,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? tenantid,
    Value<String?>? name,
    Value<String?>? email,
    Value<String?>? direccion,
    Value<String?>? pais,
    Value<String?>? ciudad,
    Value<String?>? celular,
    Value<DateTime?>? createdAt,
    Value<String?>? username,
    Value<String?>? phone,
    Value<String?>? idbusiness,
    Value<int?>? idrol,
    Value<bool?>? isGuest,
    Value<String?>? deviceId,
    Value<String?>? platform,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      tenantid: tenantid ?? this.tenantid,
      name: name ?? this.name,
      email: email ?? this.email,
      direccion: direccion ?? this.direccion,
      pais: pais ?? this.pais,
      ciudad: ciudad ?? this.ciudad,
      celular: celular ?? this.celular,
      createdAt: createdAt ?? this.createdAt,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      idbusiness: idbusiness ?? this.idbusiness,
      idrol: idrol ?? this.idrol,
      isGuest: isGuest ?? this.isGuest,
      deviceId: deviceId ?? this.deviceId,
      platform: platform ?? this.platform,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tenantid.present) {
      map['tenantid'] = Variable<String>(tenantid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (direccion.present) {
      map['direccion'] = Variable<String>(direccion.value);
    }
    if (pais.present) {
      map['pais'] = Variable<String>(pais.value);
    }
    if (ciudad.present) {
      map['ciudad'] = Variable<String>(ciudad.value);
    }
    if (celular.present) {
      map['celular'] = Variable<String>(celular.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (idbusiness.present) {
      map['idbusiness'] = Variable<String>(idbusiness.value);
    }
    if (idrol.present) {
      map['idrol'] = Variable<int>(idrol.value);
    }
    if (isGuest.present) {
      map['is_guest'] = Variable<bool>(isGuest.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (platform.present) {
      map['platform'] = Variable<String>(platform.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('tenantid: $tenantid, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('direccion: $direccion, ')
          ..write('pais: $pais, ')
          ..write('ciudad: $ciudad, ')
          ..write('celular: $celular, ')
          ..write('createdAt: $createdAt, ')
          ..write('username: $username, ')
          ..write('phone: $phone, ')
          ..write('idbusiness: $idbusiness, ')
          ..write('idrol: $idrol, ')
          ..write('isGuest: $isGuest, ')
          ..write('deviceId: $deviceId, ')
          ..write('platform: $platform')
          ..write(')'))
        .toString();
  }
}

class $ClientAttributesTable extends ClientAttributes
    with TableInfo<$ClientAttributesTable, ClientAttributesEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientAttributesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clientTypeMeta = const VerificationMeta(
    'clientType',
  );
  @override
  late final GeneratedColumn<String> clientType = GeneratedColumn<String>(
    'client_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fieldNameMeta = const VerificationMeta(
    'fieldName',
  );
  @override
  late final GeneratedColumn<String> fieldName = GeneratedColumn<String>(
    'field_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fieldTypeMeta = const VerificationMeta(
    'fieldType',
  );
  @override
  late final GeneratedColumn<String> fieldType = GeneratedColumn<String>(
    'field_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isRequiredMeta = const VerificationMeta(
    'isRequired',
  );
  @override
  late final GeneratedColumn<bool> isRequired = GeneratedColumn<bool>(
    'is_required',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_required" IN (0, 1))',
    ),
    defaultValue: Constant(false),
  );
  static const VerificationMeta _displayOrderMeta = const VerificationMeta(
    'displayOrder',
  );
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
    'display_order',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    uuid,
    clientType,
    fieldName,
    fieldType,
    isRequired,
    displayOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'client_attributes';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClientAttributesEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    }
    if (data.containsKey('client_type')) {
      context.handle(
        _clientTypeMeta,
        clientType.isAcceptableOrUnknown(data['client_type']!, _clientTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_clientTypeMeta);
    }
    if (data.containsKey('field_name')) {
      context.handle(
        _fieldNameMeta,
        fieldName.isAcceptableOrUnknown(data['field_name']!, _fieldNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldNameMeta);
    }
    if (data.containsKey('field_type')) {
      context.handle(
        _fieldTypeMeta,
        fieldType.isAcceptableOrUnknown(data['field_type']!, _fieldTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldTypeMeta);
    }
    if (data.containsKey('is_required')) {
      context.handle(
        _isRequiredMeta,
        isRequired.isAcceptableOrUnknown(data['is_required']!, _isRequiredMeta),
      );
    }
    if (data.containsKey('display_order')) {
      context.handle(
        _displayOrderMeta,
        displayOrder.isAcceptableOrUnknown(
          data['display_order']!,
          _displayOrderMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClientAttributesEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClientAttributesEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      ),
      clientType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_type'],
      )!,
      fieldName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_name'],
      )!,
      fieldType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_type'],
      )!,
      isRequired: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_required'],
      )!,
      displayOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}display_order'],
      ),
    );
  }

  @override
  $ClientAttributesTable createAlias(String alias) {
    return $ClientAttributesTable(attachedDatabase, alias);
  }
}

class ClientAttributesEntity extends DataClass
    implements Insertable<ClientAttributesEntity> {
  final int id;
  final String? uuid;
  final String clientType;
  final String fieldName;
  final String fieldType;
  final bool isRequired;
  final int? displayOrder;
  const ClientAttributesEntity({
    required this.id,
    this.uuid,
    required this.clientType,
    required this.fieldName,
    required this.fieldType,
    required this.isRequired,
    this.displayOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || uuid != null) {
      map['uuid'] = Variable<String>(uuid);
    }
    map['client_type'] = Variable<String>(clientType);
    map['field_name'] = Variable<String>(fieldName);
    map['field_type'] = Variable<String>(fieldType);
    map['is_required'] = Variable<bool>(isRequired);
    if (!nullToAbsent || displayOrder != null) {
      map['display_order'] = Variable<int>(displayOrder);
    }
    return map;
  }

  ClientAttributesCompanion toCompanion(bool nullToAbsent) {
    return ClientAttributesCompanion(
      id: Value(id),
      uuid: uuid == null && nullToAbsent ? const Value.absent() : Value(uuid),
      clientType: Value(clientType),
      fieldName: Value(fieldName),
      fieldType: Value(fieldType),
      isRequired: Value(isRequired),
      displayOrder: displayOrder == null && nullToAbsent
          ? const Value.absent()
          : Value(displayOrder),
    );
  }

  factory ClientAttributesEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClientAttributesEntity(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String?>(json['uuid']),
      clientType: serializer.fromJson<String>(json['clientType']),
      fieldName: serializer.fromJson<String>(json['fieldName']),
      fieldType: serializer.fromJson<String>(json['fieldType']),
      isRequired: serializer.fromJson<bool>(json['isRequired']),
      displayOrder: serializer.fromJson<int?>(json['displayOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uuid': serializer.toJson<String?>(uuid),
      'clientType': serializer.toJson<String>(clientType),
      'fieldName': serializer.toJson<String>(fieldName),
      'fieldType': serializer.toJson<String>(fieldType),
      'isRequired': serializer.toJson<bool>(isRequired),
      'displayOrder': serializer.toJson<int?>(displayOrder),
    };
  }

  ClientAttributesEntity copyWith({
    int? id,
    Value<String?> uuid = const Value.absent(),
    String? clientType,
    String? fieldName,
    String? fieldType,
    bool? isRequired,
    Value<int?> displayOrder = const Value.absent(),
  }) => ClientAttributesEntity(
    id: id ?? this.id,
    uuid: uuid.present ? uuid.value : this.uuid,
    clientType: clientType ?? this.clientType,
    fieldName: fieldName ?? this.fieldName,
    fieldType: fieldType ?? this.fieldType,
    isRequired: isRequired ?? this.isRequired,
    displayOrder: displayOrder.present ? displayOrder.value : this.displayOrder,
  );
  ClientAttributesEntity copyWithCompanion(ClientAttributesCompanion data) {
    return ClientAttributesEntity(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      clientType: data.clientType.present
          ? data.clientType.value
          : this.clientType,
      fieldName: data.fieldName.present ? data.fieldName.value : this.fieldName,
      fieldType: data.fieldType.present ? data.fieldType.value : this.fieldType,
      isRequired: data.isRequired.present
          ? data.isRequired.value
          : this.isRequired,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClientAttributesEntity(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('clientType: $clientType, ')
          ..write('fieldName: $fieldName, ')
          ..write('fieldType: $fieldType, ')
          ..write('isRequired: $isRequired, ')
          ..write('displayOrder: $displayOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    uuid,
    clientType,
    fieldName,
    fieldType,
    isRequired,
    displayOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClientAttributesEntity &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.clientType == this.clientType &&
          other.fieldName == this.fieldName &&
          other.fieldType == this.fieldType &&
          other.isRequired == this.isRequired &&
          other.displayOrder == this.displayOrder);
}

class ClientAttributesCompanion
    extends UpdateCompanion<ClientAttributesEntity> {
  final Value<int> id;
  final Value<String?> uuid;
  final Value<String> clientType;
  final Value<String> fieldName;
  final Value<String> fieldType;
  final Value<bool> isRequired;
  final Value<int?> displayOrder;
  const ClientAttributesCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.clientType = const Value.absent(),
    this.fieldName = const Value.absent(),
    this.fieldType = const Value.absent(),
    this.isRequired = const Value.absent(),
    this.displayOrder = const Value.absent(),
  });
  ClientAttributesCompanion.insert({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    required String clientType,
    required String fieldName,
    required String fieldType,
    this.isRequired = const Value.absent(),
    this.displayOrder = const Value.absent(),
  }) : clientType = Value(clientType),
       fieldName = Value(fieldName),
       fieldType = Value(fieldType);
  static Insertable<ClientAttributesEntity> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? clientType,
    Expression<String>? fieldName,
    Expression<String>? fieldType,
    Expression<bool>? isRequired,
    Expression<int>? displayOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (clientType != null) 'client_type': clientType,
      if (fieldName != null) 'field_name': fieldName,
      if (fieldType != null) 'field_type': fieldType,
      if (isRequired != null) 'is_required': isRequired,
      if (displayOrder != null) 'display_order': displayOrder,
    });
  }

  ClientAttributesCompanion copyWith({
    Value<int>? id,
    Value<String?>? uuid,
    Value<String>? clientType,
    Value<String>? fieldName,
    Value<String>? fieldType,
    Value<bool>? isRequired,
    Value<int?>? displayOrder,
  }) {
    return ClientAttributesCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      clientType: clientType ?? this.clientType,
      fieldName: fieldName ?? this.fieldName,
      fieldType: fieldType ?? this.fieldType,
      isRequired: isRequired ?? this.isRequired,
      displayOrder: displayOrder ?? this.displayOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (clientType.present) {
      map['client_type'] = Variable<String>(clientType.value);
    }
    if (fieldName.present) {
      map['field_name'] = Variable<String>(fieldName.value);
    }
    if (fieldType.present) {
      map['field_type'] = Variable<String>(fieldType.value);
    }
    if (isRequired.present) {
      map['is_required'] = Variable<bool>(isRequired.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientAttributesCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('clientType: $clientType, ')
          ..write('fieldName: $fieldName, ')
          ..write('fieldType: $fieldType, ')
          ..write('isRequired: $isRequired, ')
          ..write('displayOrder: $displayOrder')
          ..write(')'))
        .toString();
  }
}

class $ProductAttributesTable extends ProductAttributes
    with TableInfo<$ProductAttributesTable, ProductAttributeEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductAttributesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: generateUuid,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id)',
    ),
  );
  static const VerificationMeta _fieldNameMeta = const VerificationMeta(
    'fieldName',
  );
  @override
  late final GeneratedColumn<String> fieldName = GeneratedColumn<String>(
    'field_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fieldTypeMeta = const VerificationMeta(
    'fieldType',
  );
  @override
  late final GeneratedColumn<String> fieldType = GeneratedColumn<String>(
    'field_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fieldValueMeta = const VerificationMeta(
    'fieldValue',
  );
  @override
  late final GeneratedColumn<String> fieldValue = GeneratedColumn<String>(
    'field_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isRequiredMeta = const VerificationMeta(
    'isRequired',
  );
  @override
  late final GeneratedColumn<bool> isRequired = GeneratedColumn<bool>(
    'is_required',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_required" IN (0, 1))',
    ),
    defaultValue: Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    fieldName,
    fieldType,
    fieldValue,
    isRequired,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_attributes';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductAttributeEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('field_name')) {
      context.handle(
        _fieldNameMeta,
        fieldName.isAcceptableOrUnknown(data['field_name']!, _fieldNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldNameMeta);
    }
    if (data.containsKey('field_type')) {
      context.handle(
        _fieldTypeMeta,
        fieldType.isAcceptableOrUnknown(data['field_type']!, _fieldTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldTypeMeta);
    }
    if (data.containsKey('field_value')) {
      context.handle(
        _fieldValueMeta,
        fieldValue.isAcceptableOrUnknown(data['field_value']!, _fieldValueMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldValueMeta);
    }
    if (data.containsKey('is_required')) {
      context.handle(
        _isRequiredMeta,
        isRequired.isAcceptableOrUnknown(data['is_required']!, _isRequiredMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  ProductAttributeEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductAttributeEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      fieldName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_name'],
      )!,
      fieldType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_type'],
      )!,
      fieldValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_value'],
      )!,
      isRequired: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_required'],
      )!,
    );
  }

  @override
  $ProductAttributesTable createAlias(String alias) {
    return $ProductAttributesTable(attachedDatabase, alias);
  }
}

class ProductAttributeEntity extends DataClass
    implements Insertable<ProductAttributeEntity> {
  final String id;
  final String productId;
  final String fieldName;
  final String fieldType;
  final String fieldValue;
  final bool isRequired;
  const ProductAttributeEntity({
    required this.id,
    required this.productId,
    required this.fieldName,
    required this.fieldType,
    required this.fieldValue,
    required this.isRequired,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['product_id'] = Variable<String>(productId);
    map['field_name'] = Variable<String>(fieldName);
    map['field_type'] = Variable<String>(fieldType);
    map['field_value'] = Variable<String>(fieldValue);
    map['is_required'] = Variable<bool>(isRequired);
    return map;
  }

  ProductAttributesCompanion toCompanion(bool nullToAbsent) {
    return ProductAttributesCompanion(
      id: Value(id),
      productId: Value(productId),
      fieldName: Value(fieldName),
      fieldType: Value(fieldType),
      fieldValue: Value(fieldValue),
      isRequired: Value(isRequired),
    );
  }

  factory ProductAttributeEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductAttributeEntity(
      id: serializer.fromJson<String>(json['id']),
      productId: serializer.fromJson<String>(json['productId']),
      fieldName: serializer.fromJson<String>(json['fieldName']),
      fieldType: serializer.fromJson<String>(json['fieldType']),
      fieldValue: serializer.fromJson<String>(json['fieldValue']),
      isRequired: serializer.fromJson<bool>(json['isRequired']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'productId': serializer.toJson<String>(productId),
      'fieldName': serializer.toJson<String>(fieldName),
      'fieldType': serializer.toJson<String>(fieldType),
      'fieldValue': serializer.toJson<String>(fieldValue),
      'isRequired': serializer.toJson<bool>(isRequired),
    };
  }

  ProductAttributeEntity copyWith({
    String? id,
    String? productId,
    String? fieldName,
    String? fieldType,
    String? fieldValue,
    bool? isRequired,
  }) => ProductAttributeEntity(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    fieldName: fieldName ?? this.fieldName,
    fieldType: fieldType ?? this.fieldType,
    fieldValue: fieldValue ?? this.fieldValue,
    isRequired: isRequired ?? this.isRequired,
  );
  ProductAttributeEntity copyWithCompanion(ProductAttributesCompanion data) {
    return ProductAttributeEntity(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      fieldName: data.fieldName.present ? data.fieldName.value : this.fieldName,
      fieldType: data.fieldType.present ? data.fieldType.value : this.fieldType,
      fieldValue: data.fieldValue.present
          ? data.fieldValue.value
          : this.fieldValue,
      isRequired: data.isRequired.present
          ? data.isRequired.value
          : this.isRequired,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductAttributeEntity(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('fieldName: $fieldName, ')
          ..write('fieldType: $fieldType, ')
          ..write('fieldValue: $fieldValue, ')
          ..write('isRequired: $isRequired')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, productId, fieldName, fieldType, fieldValue, isRequired);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductAttributeEntity &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.fieldName == this.fieldName &&
          other.fieldType == this.fieldType &&
          other.fieldValue == this.fieldValue &&
          other.isRequired == this.isRequired);
}

class ProductAttributesCompanion
    extends UpdateCompanion<ProductAttributeEntity> {
  final Value<String> id;
  final Value<String> productId;
  final Value<String> fieldName;
  final Value<String> fieldType;
  final Value<String> fieldValue;
  final Value<bool> isRequired;
  final Value<int> rowid;
  const ProductAttributesCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.fieldName = const Value.absent(),
    this.fieldType = const Value.absent(),
    this.fieldValue = const Value.absent(),
    this.isRequired = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductAttributesCompanion.insert({
    this.id = const Value.absent(),
    required String productId,
    required String fieldName,
    required String fieldType,
    required String fieldValue,
    this.isRequired = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : productId = Value(productId),
       fieldName = Value(fieldName),
       fieldType = Value(fieldType),
       fieldValue = Value(fieldValue);
  static Insertable<ProductAttributeEntity> custom({
    Expression<String>? id,
    Expression<String>? productId,
    Expression<String>? fieldName,
    Expression<String>? fieldType,
    Expression<String>? fieldValue,
    Expression<bool>? isRequired,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (fieldName != null) 'field_name': fieldName,
      if (fieldType != null) 'field_type': fieldType,
      if (fieldValue != null) 'field_value': fieldValue,
      if (isRequired != null) 'is_required': isRequired,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductAttributesCompanion copyWith({
    Value<String>? id,
    Value<String>? productId,
    Value<String>? fieldName,
    Value<String>? fieldType,
    Value<String>? fieldValue,
    Value<bool>? isRequired,
    Value<int>? rowid,
  }) {
    return ProductAttributesCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      fieldName: fieldName ?? this.fieldName,
      fieldType: fieldType ?? this.fieldType,
      fieldValue: fieldValue ?? this.fieldValue,
      isRequired: isRequired ?? this.isRequired,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (fieldName.present) {
      map['field_name'] = Variable<String>(fieldName.value);
    }
    if (fieldType.present) {
      map['field_type'] = Variable<String>(fieldType.value);
    }
    if (fieldValue.present) {
      map['field_value'] = Variable<String>(fieldValue.value);
    }
    if (isRequired.present) {
      map['is_required'] = Variable<bool>(isRequired.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductAttributesCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('fieldName: $fieldName, ')
          ..write('fieldType: $fieldType, ')
          ..write('fieldValue: $fieldValue, ')
          ..write('isRequired: $isRequired, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $CartGroupsTable cartGroups = $CartGroupsTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $BusinesssTable businesss = $BusinesssTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $ClientAttributesTable clientAttributes = $ClientAttributesTable(
    this,
  );
  late final $ProductAttributesTable productAttributes =
      $ProductAttributesTable(this);
  late final ProductDao productDao = ProductDao(this as AppDatabase);
  late final TransactionDao transactionDao = TransactionDao(
    this as AppDatabase,
  );
  late final CartGroupsDao cartGroupsDao = CartGroupsDao(this as AppDatabase);
  late final BusinessDao businessDao = BusinessDao(this as AppDatabase);
  late final UsersDao usersDao = UsersDao(this as AppDatabase);
  late final ClientAttributesDao clientAttributesDao = ClientAttributesDao(
    this as AppDatabase,
  );
  late final ProductAttributesDao productAttributesDao = ProductAttributesDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    products,
    cartGroups,
    transactions,
    businesss,
    users,
    clientAttributes,
    productAttributes,
  ];
}

typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      Value<String> id,
      Value<String?> idbusiness,
      Value<String?> idcategory,
      Value<String?> name,
      Value<String?> image,
      Value<int?> stock,
      Value<double?> price,
      Value<String?> owner,
      Value<String?> barcode,
      Value<int?> stockminimumlevel,
      Value<String?> deviceid,
      Value<String?> platform,
      Value<String?> ubicacion,
      Value<String?> bodega,
      Value<DateTime?> lastsyncedat,
      Value<DateTime?> createdat,
      Value<String?> syncstate,
      Value<bool?> syncstatus,
      Value<bool?> isdemo,
      Value<int> rowid,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<String> id,
      Value<String?> idbusiness,
      Value<String?> idcategory,
      Value<String?> name,
      Value<String?> image,
      Value<int?> stock,
      Value<double?> price,
      Value<String?> owner,
      Value<String?> barcode,
      Value<int?> stockminimumlevel,
      Value<String?> deviceid,
      Value<String?> platform,
      Value<String?> ubicacion,
      Value<String?> bodega,
      Value<DateTime?> lastsyncedat,
      Value<DateTime?> createdat,
      Value<String?> syncstate,
      Value<bool?> syncstatus,
      Value<bool?> isdemo,
      Value<int> rowid,
    });

final class $$ProductsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTable, ProductEntity> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionsTable, List<TransactionEntity>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: $_aliasNameGenerator(db.products.id, db.transactions.productId),
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ProductAttributesTable,
    List<ProductAttributeEntity>
  >
  _productAttributesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.productAttributes,
        aliasName: $_aliasNameGenerator(
          db.products.id,
          db.productAttributes.productId,
        ),
      );

  $$ProductAttributesTableProcessedTableManager get productAttributesRefs {
    final manager = $$ProductAttributesTableTableManager(
      $_db,
      $_db.productAttributes,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _productAttributesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
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

  ColumnFilters<String> get idbusiness => $composableBuilder(
    column: $table.idbusiness,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get idcategory => $composableBuilder(
    column: $table.idcategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stock => $composableBuilder(
    column: $table.stock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get owner => $composableBuilder(
    column: $table.owner,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stockminimumlevel => $composableBuilder(
    column: $table.stockminimumlevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceid => $composableBuilder(
    column: $table.deviceid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ubicacion => $composableBuilder(
    column: $table.ubicacion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodega => $composableBuilder(
    column: $table.bodega,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastsyncedat => $composableBuilder(
    column: $table.lastsyncedat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdat => $composableBuilder(
    column: $table.createdat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncstate => $composableBuilder(
    column: $table.syncstate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get syncstatus => $composableBuilder(
    column: $table.syncstatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isdemo => $composableBuilder(
    column: $table.isdemo,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.productId,
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

  Expression<bool> productAttributesRefs(
    Expression<bool> Function($$ProductAttributesTableFilterComposer f) f,
  ) {
    final $$ProductAttributesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productAttributes,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductAttributesTableFilterComposer(
            $db: $db,
            $table: $db.productAttributes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
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

  ColumnOrderings<String> get idbusiness => $composableBuilder(
    column: $table.idbusiness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get idcategory => $composableBuilder(
    column: $table.idcategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stock => $composableBuilder(
    column: $table.stock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get owner => $composableBuilder(
    column: $table.owner,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stockminimumlevel => $composableBuilder(
    column: $table.stockminimumlevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceid => $composableBuilder(
    column: $table.deviceid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ubicacion => $composableBuilder(
    column: $table.ubicacion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodega => $composableBuilder(
    column: $table.bodega,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastsyncedat => $composableBuilder(
    column: $table.lastsyncedat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdat => $composableBuilder(
    column: $table.createdat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncstate => $composableBuilder(
    column: $table.syncstate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get syncstatus => $composableBuilder(
    column: $table.syncstatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isdemo => $composableBuilder(
    column: $table.isdemo,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get idbusiness => $composableBuilder(
    column: $table.idbusiness,
    builder: (column) => column,
  );

  GeneratedColumn<String> get idcategory => $composableBuilder(
    column: $table.idcategory,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<int> get stock =>
      $composableBuilder(column: $table.stock, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get owner =>
      $composableBuilder(column: $table.owner, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<int> get stockminimumlevel => $composableBuilder(
    column: $table.stockminimumlevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deviceid =>
      $composableBuilder(column: $table.deviceid, builder: (column) => column);

  GeneratedColumn<String> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  GeneratedColumn<String> get ubicacion =>
      $composableBuilder(column: $table.ubicacion, builder: (column) => column);

  GeneratedColumn<String> get bodega =>
      $composableBuilder(column: $table.bodega, builder: (column) => column);

  GeneratedColumn<DateTime> get lastsyncedat => $composableBuilder(
    column: $table.lastsyncedat,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdat =>
      $composableBuilder(column: $table.createdat, builder: (column) => column);

  GeneratedColumn<String> get syncstate =>
      $composableBuilder(column: $table.syncstate, builder: (column) => column);

  GeneratedColumn<bool> get syncstatus => $composableBuilder(
    column: $table.syncstatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isdemo =>
      $composableBuilder(column: $table.isdemo, builder: (column) => column);

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.productId,
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

  Expression<T> productAttributesRefs<T extends Object>(
    Expression<T> Function($$ProductAttributesTableAnnotationComposer a) f,
  ) {
    final $$ProductAttributesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.productAttributes,
          getReferencedColumn: (t) => t.productId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProductAttributesTableAnnotationComposer(
                $db: $db,
                $table: $db.productAttributes,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          ProductEntity,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (ProductEntity, $$ProductsTableReferences),
          ProductEntity,
          PrefetchHooks Function({
            bool transactionsRefs,
            bool productAttributesRefs,
          })
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> idbusiness = const Value.absent(),
                Value<String?> idcategory = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> image = const Value.absent(),
                Value<int?> stock = const Value.absent(),
                Value<double?> price = const Value.absent(),
                Value<String?> owner = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<int?> stockminimumlevel = const Value.absent(),
                Value<String?> deviceid = const Value.absent(),
                Value<String?> platform = const Value.absent(),
                Value<String?> ubicacion = const Value.absent(),
                Value<String?> bodega = const Value.absent(),
                Value<DateTime?> lastsyncedat = const Value.absent(),
                Value<DateTime?> createdat = const Value.absent(),
                Value<String?> syncstate = const Value.absent(),
                Value<bool?> syncstatus = const Value.absent(),
                Value<bool?> isdemo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                idbusiness: idbusiness,
                idcategory: idcategory,
                name: name,
                image: image,
                stock: stock,
                price: price,
                owner: owner,
                barcode: barcode,
                stockminimumlevel: stockminimumlevel,
                deviceid: deviceid,
                platform: platform,
                ubicacion: ubicacion,
                bodega: bodega,
                lastsyncedat: lastsyncedat,
                createdat: createdat,
                syncstate: syncstate,
                syncstatus: syncstatus,
                isdemo: isdemo,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> idbusiness = const Value.absent(),
                Value<String?> idcategory = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> image = const Value.absent(),
                Value<int?> stock = const Value.absent(),
                Value<double?> price = const Value.absent(),
                Value<String?> owner = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<int?> stockminimumlevel = const Value.absent(),
                Value<String?> deviceid = const Value.absent(),
                Value<String?> platform = const Value.absent(),
                Value<String?> ubicacion = const Value.absent(),
                Value<String?> bodega = const Value.absent(),
                Value<DateTime?> lastsyncedat = const Value.absent(),
                Value<DateTime?> createdat = const Value.absent(),
                Value<String?> syncstate = const Value.absent(),
                Value<bool?> syncstatus = const Value.absent(),
                Value<bool?> isdemo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion.insert(
                id: id,
                idbusiness: idbusiness,
                idcategory: idcategory,
                name: name,
                image: image,
                stock: stock,
                price: price,
                owner: owner,
                barcode: barcode,
                stockminimumlevel: stockminimumlevel,
                deviceid: deviceid,
                platform: platform,
                ubicacion: ubicacion,
                bodega: bodega,
                lastsyncedat: lastsyncedat,
                createdat: createdat,
                syncstate: syncstate,
                syncstatus: syncstatus,
                isdemo: isdemo,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({transactionsRefs = false, productAttributesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (transactionsRefs) db.transactions,
                    if (productAttributesRefs) db.productAttributes,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (transactionsRefs)
                        await $_getPrefetchedData<
                          ProductEntity,
                          $ProductsTable,
                          TransactionEntity
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._transactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).transactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (productAttributesRefs)
                        await $_getPrefetchedData<
                          ProductEntity,
                          $ProductsTable,
                          ProductAttributeEntity
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._productAttributesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).productAttributesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.productId == item.id,
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

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      ProductEntity,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (ProductEntity, $$ProductsTableReferences),
      ProductEntity,
      PrefetchHooks Function({
        bool transactionsRefs,
        bool productAttributesRefs,
      })
    >;
typedef $$CartGroupsTableCreateCompanionBuilder =
    CartGroupsCompanion Function({
      Value<int> id,
      Value<String?> name,
      Value<bool> processed,
      Value<DateTime> createdAt,
      Value<bool> syncStatus,
      Value<DateTime?> lastSyncedAt,
      Value<String> syncState,
    });
typedef $$CartGroupsTableUpdateCompanionBuilder =
    CartGroupsCompanion Function({
      Value<int> id,
      Value<String?> name,
      Value<bool> processed,
      Value<DateTime> createdAt,
      Value<bool> syncStatus,
      Value<DateTime?> lastSyncedAt,
      Value<String> syncState,
    });

final class $$CartGroupsTableReferences
    extends BaseReferences<_$AppDatabase, $CartGroupsTable, CartGroupEntity> {
  $$CartGroupsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionsTable, List<TransactionEntity>>
  _transactionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transactions,
    aliasName: $_aliasNameGenerator(
      db.cartGroups.id,
      db.transactions.cartGroupId,
    ),
  );

  $$TransactionsTableProcessedTableManager get transactionsRefs {
    final manager = $$TransactionsTableTableManager(
      $_db,
      $_db.transactions,
    ).filter((f) => f.cartGroupId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transactionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CartGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $CartGroupsTable> {
  $$CartGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get processed => $composableBuilder(
    column: $table.processed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncState => $composableBuilder(
    column: $table.syncState,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transactionsRefs(
    Expression<bool> Function($$TransactionsTableFilterComposer f) f,
  ) {
    final $$TransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.cartGroupId,
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

class $$CartGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $CartGroupsTable> {
  $$CartGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get processed => $composableBuilder(
    column: $table.processed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncState => $composableBuilder(
    column: $table.syncState,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CartGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CartGroupsTable> {
  $$CartGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get processed =>
      $composableBuilder(column: $table.processed, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  Expression<T> transactionsRefs<T extends Object>(
    Expression<T> Function($$TransactionsTableAnnotationComposer a) f,
  ) {
    final $$TransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transactions,
      getReferencedColumn: (t) => t.cartGroupId,
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

class $$CartGroupsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CartGroupsTable,
          CartGroupEntity,
          $$CartGroupsTableFilterComposer,
          $$CartGroupsTableOrderingComposer,
          $$CartGroupsTableAnnotationComposer,
          $$CartGroupsTableCreateCompanionBuilder,
          $$CartGroupsTableUpdateCompanionBuilder,
          (CartGroupEntity, $$CartGroupsTableReferences),
          CartGroupEntity,
          PrefetchHooks Function({bool transactionsRefs})
        > {
  $$CartGroupsTableTableManager(_$AppDatabase db, $CartGroupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CartGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CartGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CartGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<bool> processed = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> syncStatus = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<String> syncState = const Value.absent(),
              }) => CartGroupsCompanion(
                id: id,
                name: name,
                processed: processed,
                createdAt: createdAt,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                syncState: syncState,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<bool> processed = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> syncStatus = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<String> syncState = const Value.absent(),
              }) => CartGroupsCompanion.insert(
                id: id,
                name: name,
                processed: processed,
                createdAt: createdAt,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                syncState: syncState,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CartGroupsTableReferences(db, table, e),
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
                      CartGroupEntity,
                      $CartGroupsTable,
                      TransactionEntity
                    >(
                      currentTable: table,
                      referencedTable: $$CartGroupsTableReferences
                          ._transactionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CartGroupsTableReferences(
                            db,
                            table,
                            p0,
                          ).transactionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.cartGroupId == item.id,
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

typedef $$CartGroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CartGroupsTable,
      CartGroupEntity,
      $$CartGroupsTableFilterComposer,
      $$CartGroupsTableOrderingComposer,
      $$CartGroupsTableAnnotationComposer,
      $$CartGroupsTableCreateCompanionBuilder,
      $$CartGroupsTableUpdateCompanionBuilder,
      (CartGroupEntity, $$CartGroupsTableReferences),
      CartGroupEntity,
      PrefetchHooks Function({bool transactionsRefs})
    >;
typedef $$TransactionsTableCreateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      required String productId,
      required int cartGroupId,
      required String transactionType,
      required int quantity,
      Value<double?> unitPrice,
      Value<double?> totalAmount,
      Value<String?> concept,
      Value<int?> userId,
      Value<String?> platform,
      Value<DateTime> createdAt,
      Value<bool> syncStatus,
      Value<DateTime?> lastSyncedAt,
      Value<String> syncState,
    });
typedef $$TransactionsTableUpdateCompanionBuilder =
    TransactionsCompanion Function({
      Value<int> id,
      Value<String> productId,
      Value<int> cartGroupId,
      Value<String> transactionType,
      Value<int> quantity,
      Value<double?> unitPrice,
      Value<double?> totalAmount,
      Value<String?> concept,
      Value<int?> userId,
      Value<String?> platform,
      Value<DateTime> createdAt,
      Value<bool> syncStatus,
      Value<DateTime?> lastSyncedAt,
      Value<String> syncState,
    });

final class $$TransactionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $TransactionsTable, TransactionEntity> {
  $$TransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias(
        $_aliasNameGenerator(db.transactions.productId, db.products.id),
      );

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CartGroupsTable _cartGroupIdTable(_$AppDatabase db) =>
      db.cartGroups.createAlias(
        $_aliasNameGenerator(db.transactions.cartGroupId, db.cartGroups.id),
      );

  $$CartGroupsTableProcessedTableManager get cartGroupId {
    final $_column = $_itemColumn<int>('cart_group_id')!;

    final manager = $$CartGroupsTableTableManager(
      $_db,
      $_db.cartGroups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cartGroupIdTable($_db));
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
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get concept => $composableBuilder(
    column: $table.concept,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncState => $composableBuilder(
    column: $table.syncState,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CartGroupsTableFilterComposer get cartGroupId {
    final $$CartGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cartGroupId,
      referencedTable: $db.cartGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CartGroupsTableFilterComposer(
            $db: $db,
            $table: $db.cartGroups,
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
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get concept => $composableBuilder(
    column: $table.concept,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncState => $composableBuilder(
    column: $table.syncState,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CartGroupsTableOrderingComposer get cartGroupId {
    final $$CartGroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cartGroupId,
      referencedTable: $db.cartGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CartGroupsTableOrderingComposer(
            $db: $db,
            $table: $db.cartGroups,
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
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get concept =>
      $composableBuilder(column: $table.concept, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CartGroupsTableAnnotationComposer get cartGroupId {
    final $$CartGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cartGroupId,
      referencedTable: $db.cartGroups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CartGroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.cartGroups,
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
          TransactionEntity,
          $$TransactionsTableFilterComposer,
          $$TransactionsTableOrderingComposer,
          $$TransactionsTableAnnotationComposer,
          $$TransactionsTableCreateCompanionBuilder,
          $$TransactionsTableUpdateCompanionBuilder,
          (TransactionEntity, $$TransactionsTableReferences),
          TransactionEntity,
          PrefetchHooks Function({bool productId, bool cartGroupId})
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
                Value<int> id = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<int> cartGroupId = const Value.absent(),
                Value<String> transactionType = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double?> unitPrice = const Value.absent(),
                Value<double?> totalAmount = const Value.absent(),
                Value<String?> concept = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                Value<String?> platform = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> syncStatus = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<String> syncState = const Value.absent(),
              }) => TransactionsCompanion(
                id: id,
                productId: productId,
                cartGroupId: cartGroupId,
                transactionType: transactionType,
                quantity: quantity,
                unitPrice: unitPrice,
                totalAmount: totalAmount,
                concept: concept,
                userId: userId,
                platform: platform,
                createdAt: createdAt,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                syncState: syncState,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String productId,
                required int cartGroupId,
                required String transactionType,
                required int quantity,
                Value<double?> unitPrice = const Value.absent(),
                Value<double?> totalAmount = const Value.absent(),
                Value<String?> concept = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                Value<String?> platform = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<bool> syncStatus = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
                Value<String> syncState = const Value.absent(),
              }) => TransactionsCompanion.insert(
                id: id,
                productId: productId,
                cartGroupId: cartGroupId,
                transactionType: transactionType,
                quantity: quantity,
                unitPrice: unitPrice,
                totalAmount: totalAmount,
                concept: concept,
                userId: userId,
                platform: platform,
                createdAt: createdAt,
                syncStatus: syncStatus,
                lastSyncedAt: lastSyncedAt,
                syncState: syncState,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false, cartGroupId = false}) {
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
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable: $$TransactionsTableReferences
                                    ._productIdTable(db),
                                referencedColumn: $$TransactionsTableReferences
                                    ._productIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (cartGroupId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.cartGroupId,
                                referencedTable: $$TransactionsTableReferences
                                    ._cartGroupIdTable(db),
                                referencedColumn: $$TransactionsTableReferences
                                    ._cartGroupIdTable(db)
                                    .id,
                              )
                              as T;
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
      TransactionEntity,
      $$TransactionsTableFilterComposer,
      $$TransactionsTableOrderingComposer,
      $$TransactionsTableAnnotationComposer,
      $$TransactionsTableCreateCompanionBuilder,
      $$TransactionsTableUpdateCompanionBuilder,
      (TransactionEntity, $$TransactionsTableReferences),
      TransactionEntity,
      PrefetchHooks Function({bool productId, bool cartGroupId})
    >;
typedef $$BusinesssTableCreateCompanionBuilder =
    BusinesssCompanion Function({
      required String idbusiness,
      Value<String?> name,
      Value<String?> website,
      Value<String?> email,
      Value<String?> direccion,
      Value<String?> pais,
      Value<String?> ciudad,
      Value<String?> latitud,
      Value<String?> longitud,
      Value<String?> acteconomica,
      Value<String?> celular,
      Value<DateTime> createdat,
      Value<int> rowid,
    });
typedef $$BusinesssTableUpdateCompanionBuilder =
    BusinesssCompanion Function({
      Value<String> idbusiness,
      Value<String?> name,
      Value<String?> website,
      Value<String?> email,
      Value<String?> direccion,
      Value<String?> pais,
      Value<String?> ciudad,
      Value<String?> latitud,
      Value<String?> longitud,
      Value<String?> acteconomica,
      Value<String?> celular,
      Value<DateTime> createdat,
      Value<int> rowid,
    });

final class $$BusinesssTableReferences
    extends BaseReferences<_$AppDatabase, $BusinesssTable, BusinessEntity> {
  $$BusinesssTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UsersTable, List<UsersEntity>> _usersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.users,
    aliasName: $_aliasNameGenerator(db.businesss.idbusiness, db.users.tenantid),
  );

  $$UsersTableProcessedTableManager get usersRefs {
    final manager = $$UsersTableTableManager($_db, $_db.users).filter(
      (f) =>
          f.tenantid.idbusiness.sqlEquals($_itemColumn<String>('idbusiness')!),
    );

    final cache = $_typedResult.readTableOrNull(_usersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BusinesssTableFilterComposer
    extends Composer<_$AppDatabase, $BusinesssTable> {
  $$BusinesssTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get idbusiness => $composableBuilder(
    column: $table.idbusiness,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get website => $composableBuilder(
    column: $table.website,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direccion => $composableBuilder(
    column: $table.direccion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pais => $composableBuilder(
    column: $table.pais,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ciudad => $composableBuilder(
    column: $table.ciudad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get latitud => $composableBuilder(
    column: $table.latitud,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get longitud => $composableBuilder(
    column: $table.longitud,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get acteconomica => $composableBuilder(
    column: $table.acteconomica,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get celular => $composableBuilder(
    column: $table.celular,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdat => $composableBuilder(
    column: $table.createdat,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> usersRefs(
    Expression<bool> Function($$UsersTableFilterComposer f) f,
  ) {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idbusiness,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.tenantid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BusinesssTableOrderingComposer
    extends Composer<_$AppDatabase, $BusinesssTable> {
  $$BusinesssTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get idbusiness => $composableBuilder(
    column: $table.idbusiness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get website => $composableBuilder(
    column: $table.website,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direccion => $composableBuilder(
    column: $table.direccion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pais => $composableBuilder(
    column: $table.pais,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ciudad => $composableBuilder(
    column: $table.ciudad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get latitud => $composableBuilder(
    column: $table.latitud,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get longitud => $composableBuilder(
    column: $table.longitud,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get acteconomica => $composableBuilder(
    column: $table.acteconomica,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get celular => $composableBuilder(
    column: $table.celular,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdat => $composableBuilder(
    column: $table.createdat,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BusinesssTableAnnotationComposer
    extends Composer<_$AppDatabase, $BusinesssTable> {
  $$BusinesssTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get idbusiness => $composableBuilder(
    column: $table.idbusiness,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get website =>
      $composableBuilder(column: $table.website, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get direccion =>
      $composableBuilder(column: $table.direccion, builder: (column) => column);

  GeneratedColumn<String> get pais =>
      $composableBuilder(column: $table.pais, builder: (column) => column);

  GeneratedColumn<String> get ciudad =>
      $composableBuilder(column: $table.ciudad, builder: (column) => column);

  GeneratedColumn<String> get latitud =>
      $composableBuilder(column: $table.latitud, builder: (column) => column);

  GeneratedColumn<String> get longitud =>
      $composableBuilder(column: $table.longitud, builder: (column) => column);

  GeneratedColumn<String> get acteconomica => $composableBuilder(
    column: $table.acteconomica,
    builder: (column) => column,
  );

  GeneratedColumn<String> get celular =>
      $composableBuilder(column: $table.celular, builder: (column) => column);

  GeneratedColumn<DateTime> get createdat =>
      $composableBuilder(column: $table.createdat, builder: (column) => column);

  Expression<T> usersRefs<T extends Object>(
    Expression<T> Function($$UsersTableAnnotationComposer a) f,
  ) {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.idbusiness,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.tenantid,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BusinesssTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BusinesssTable,
          BusinessEntity,
          $$BusinesssTableFilterComposer,
          $$BusinesssTableOrderingComposer,
          $$BusinesssTableAnnotationComposer,
          $$BusinesssTableCreateCompanionBuilder,
          $$BusinesssTableUpdateCompanionBuilder,
          (BusinessEntity, $$BusinesssTableReferences),
          BusinessEntity,
          PrefetchHooks Function({bool usersRefs})
        > {
  $$BusinesssTableTableManager(_$AppDatabase db, $BusinesssTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BusinesssTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BusinesssTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BusinesssTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> idbusiness = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> website = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> direccion = const Value.absent(),
                Value<String?> pais = const Value.absent(),
                Value<String?> ciudad = const Value.absent(),
                Value<String?> latitud = const Value.absent(),
                Value<String?> longitud = const Value.absent(),
                Value<String?> acteconomica = const Value.absent(),
                Value<String?> celular = const Value.absent(),
                Value<DateTime> createdat = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BusinesssCompanion(
                idbusiness: idbusiness,
                name: name,
                website: website,
                email: email,
                direccion: direccion,
                pais: pais,
                ciudad: ciudad,
                latitud: latitud,
                longitud: longitud,
                acteconomica: acteconomica,
                celular: celular,
                createdat: createdat,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String idbusiness,
                Value<String?> name = const Value.absent(),
                Value<String?> website = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> direccion = const Value.absent(),
                Value<String?> pais = const Value.absent(),
                Value<String?> ciudad = const Value.absent(),
                Value<String?> latitud = const Value.absent(),
                Value<String?> longitud = const Value.absent(),
                Value<String?> acteconomica = const Value.absent(),
                Value<String?> celular = const Value.absent(),
                Value<DateTime> createdat = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BusinesssCompanion.insert(
                idbusiness: idbusiness,
                name: name,
                website: website,
                email: email,
                direccion: direccion,
                pais: pais,
                ciudad: ciudad,
                latitud: latitud,
                longitud: longitud,
                acteconomica: acteconomica,
                celular: celular,
                createdat: createdat,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BusinesssTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({usersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (usersRefs) db.users],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (usersRefs)
                    await $_getPrefetchedData<
                      BusinessEntity,
                      $BusinesssTable,
                      UsersEntity
                    >(
                      currentTable: table,
                      referencedTable: $$BusinesssTableReferences
                          ._usersRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$BusinesssTableReferences(db, table, p0).usersRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.tenantid == item.idbusiness,
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

typedef $$BusinesssTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BusinesssTable,
      BusinessEntity,
      $$BusinesssTableFilterComposer,
      $$BusinesssTableOrderingComposer,
      $$BusinesssTableAnnotationComposer,
      $$BusinesssTableCreateCompanionBuilder,
      $$BusinesssTableUpdateCompanionBuilder,
      (BusinessEntity, $$BusinesssTableReferences),
      BusinessEntity,
      PrefetchHooks Function({bool usersRefs})
    >;
typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String tenantid,
      Value<String?> name,
      Value<String?> email,
      Value<String?> direccion,
      Value<String?> pais,
      Value<String?> ciudad,
      Value<String?> celular,
      Value<DateTime?> createdAt,
      Value<String?> username,
      Value<String?> phone,
      Value<String?> idbusiness,
      Value<int?> idrol,
      Value<bool?> isGuest,
      Value<String?> deviceId,
      Value<String?> platform,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> tenantid,
      Value<String?> name,
      Value<String?> email,
      Value<String?> direccion,
      Value<String?> pais,
      Value<String?> ciudad,
      Value<String?> celular,
      Value<DateTime?> createdAt,
      Value<String?> username,
      Value<String?> phone,
      Value<String?> idbusiness,
      Value<int?> idrol,
      Value<bool?> isGuest,
      Value<String?> deviceId,
      Value<String?> platform,
    });

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, UsersEntity> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BusinesssTable _tenantidTable(_$AppDatabase db) =>
      db.businesss.createAlias(
        $_aliasNameGenerator(db.users.tenantid, db.businesss.idbusiness),
      );

  $$BusinesssTableProcessedTableManager get tenantid {
    final $_column = $_itemColumn<String>('tenantid')!;

    final manager = $$BusinesssTableTableManager(
      $_db,
      $_db.businesss,
    ).filter((f) => f.idbusiness.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tenantidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direccion => $composableBuilder(
    column: $table.direccion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pais => $composableBuilder(
    column: $table.pais,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ciudad => $composableBuilder(
    column: $table.ciudad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get celular => $composableBuilder(
    column: $table.celular,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get idbusiness => $composableBuilder(
    column: $table.idbusiness,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idrol => $composableBuilder(
    column: $table.idrol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isGuest => $composableBuilder(
    column: $table.isGuest,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnFilters(column),
  );

  $$BusinesssTableFilterComposer get tenantid {
    final $$BusinesssTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenantid,
      referencedTable: $db.businesss,
      getReferencedColumn: (t) => t.idbusiness,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BusinesssTableFilterComposer(
            $db: $db,
            $table: $db.businesss,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direccion => $composableBuilder(
    column: $table.direccion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pais => $composableBuilder(
    column: $table.pais,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ciudad => $composableBuilder(
    column: $table.ciudad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get celular => $composableBuilder(
    column: $table.celular,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get idbusiness => $composableBuilder(
    column: $table.idbusiness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idrol => $composableBuilder(
    column: $table.idrol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isGuest => $composableBuilder(
    column: $table.isGuest,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnOrderings(column),
  );

  $$BusinesssTableOrderingComposer get tenantid {
    final $$BusinesssTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenantid,
      referencedTable: $db.businesss,
      getReferencedColumn: (t) => t.idbusiness,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BusinesssTableOrderingComposer(
            $db: $db,
            $table: $db.businesss,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get direccion =>
      $composableBuilder(column: $table.direccion, builder: (column) => column);

  GeneratedColumn<String> get pais =>
      $composableBuilder(column: $table.pais, builder: (column) => column);

  GeneratedColumn<String> get ciudad =>
      $composableBuilder(column: $table.ciudad, builder: (column) => column);

  GeneratedColumn<String> get celular =>
      $composableBuilder(column: $table.celular, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get idbusiness => $composableBuilder(
    column: $table.idbusiness,
    builder: (column) => column,
  );

  GeneratedColumn<int> get idrol =>
      $composableBuilder(column: $table.idrol, builder: (column) => column);

  GeneratedColumn<bool> get isGuest =>
      $composableBuilder(column: $table.isGuest, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  $$BusinesssTableAnnotationComposer get tenantid {
    final $$BusinesssTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tenantid,
      referencedTable: $db.businesss,
      getReferencedColumn: (t) => t.idbusiness,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BusinesssTableAnnotationComposer(
            $db: $db,
            $table: $db.businesss,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          UsersEntity,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (UsersEntity, $$UsersTableReferences),
          UsersEntity,
          PrefetchHooks Function({bool tenantid})
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> tenantid = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> direccion = const Value.absent(),
                Value<String?> pais = const Value.absent(),
                Value<String?> ciudad = const Value.absent(),
                Value<String?> celular = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<String?> username = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> idbusiness = const Value.absent(),
                Value<int?> idrol = const Value.absent(),
                Value<bool?> isGuest = const Value.absent(),
                Value<String?> deviceId = const Value.absent(),
                Value<String?> platform = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                tenantid: tenantid,
                name: name,
                email: email,
                direccion: direccion,
                pais: pais,
                ciudad: ciudad,
                celular: celular,
                createdAt: createdAt,
                username: username,
                phone: phone,
                idbusiness: idbusiness,
                idrol: idrol,
                isGuest: isGuest,
                deviceId: deviceId,
                platform: platform,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String tenantid,
                Value<String?> name = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> direccion = const Value.absent(),
                Value<String?> pais = const Value.absent(),
                Value<String?> ciudad = const Value.absent(),
                Value<String?> celular = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<String?> username = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> idbusiness = const Value.absent(),
                Value<int?> idrol = const Value.absent(),
                Value<bool?> isGuest = const Value.absent(),
                Value<String?> deviceId = const Value.absent(),
                Value<String?> platform = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                tenantid: tenantid,
                name: name,
                email: email,
                direccion: direccion,
                pais: pais,
                ciudad: ciudad,
                celular: celular,
                createdAt: createdAt,
                username: username,
                phone: phone,
                idbusiness: idbusiness,
                idrol: idrol,
                isGuest: isGuest,
                deviceId: deviceId,
                platform: platform,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UsersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({tenantid = false}) {
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
                    if (tenantid) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tenantid,
                                referencedTable: $$UsersTableReferences
                                    ._tenantidTable(db),
                                referencedColumn: $$UsersTableReferences
                                    ._tenantidTable(db)
                                    .idbusiness,
                              )
                              as T;
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

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      UsersEntity,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (UsersEntity, $$UsersTableReferences),
      UsersEntity,
      PrefetchHooks Function({bool tenantid})
    >;
typedef $$ClientAttributesTableCreateCompanionBuilder =
    ClientAttributesCompanion Function({
      Value<int> id,
      Value<String?> uuid,
      required String clientType,
      required String fieldName,
      required String fieldType,
      Value<bool> isRequired,
      Value<int?> displayOrder,
    });
typedef $$ClientAttributesTableUpdateCompanionBuilder =
    ClientAttributesCompanion Function({
      Value<int> id,
      Value<String?> uuid,
      Value<String> clientType,
      Value<String> fieldName,
      Value<String> fieldType,
      Value<bool> isRequired,
      Value<int?> displayOrder,
    });

class $$ClientAttributesTableFilterComposer
    extends Composer<_$AppDatabase, $ClientAttributesTable> {
  $$ClientAttributesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clientType => $composableBuilder(
    column: $table.clientType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldName => $composableBuilder(
    column: $table.fieldName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldType => $composableBuilder(
    column: $table.fieldType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ClientAttributesTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientAttributesTable> {
  $$ClientAttributesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clientType => $composableBuilder(
    column: $table.clientType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldName => $composableBuilder(
    column: $table.fieldName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldType => $composableBuilder(
    column: $table.fieldType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClientAttributesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientAttributesTable> {
  $$ClientAttributesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get clientType => $composableBuilder(
    column: $table.clientType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fieldName =>
      $composableBuilder(column: $table.fieldName, builder: (column) => column);

  GeneratedColumn<String> get fieldType =>
      $composableBuilder(column: $table.fieldType, builder: (column) => column);

  GeneratedColumn<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => column,
  );

  GeneratedColumn<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => column,
  );
}

class $$ClientAttributesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientAttributesTable,
          ClientAttributesEntity,
          $$ClientAttributesTableFilterComposer,
          $$ClientAttributesTableOrderingComposer,
          $$ClientAttributesTableAnnotationComposer,
          $$ClientAttributesTableCreateCompanionBuilder,
          $$ClientAttributesTableUpdateCompanionBuilder,
          (
            ClientAttributesEntity,
            BaseReferences<
              _$AppDatabase,
              $ClientAttributesTable,
              ClientAttributesEntity
            >,
          ),
          ClientAttributesEntity,
          PrefetchHooks Function()
        > {
  $$ClientAttributesTableTableManager(
    _$AppDatabase db,
    $ClientAttributesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientAttributesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientAttributesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientAttributesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> uuid = const Value.absent(),
                Value<String> clientType = const Value.absent(),
                Value<String> fieldName = const Value.absent(),
                Value<String> fieldType = const Value.absent(),
                Value<bool> isRequired = const Value.absent(),
                Value<int?> displayOrder = const Value.absent(),
              }) => ClientAttributesCompanion(
                id: id,
                uuid: uuid,
                clientType: clientType,
                fieldName: fieldName,
                fieldType: fieldType,
                isRequired: isRequired,
                displayOrder: displayOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> uuid = const Value.absent(),
                required String clientType,
                required String fieldName,
                required String fieldType,
                Value<bool> isRequired = const Value.absent(),
                Value<int?> displayOrder = const Value.absent(),
              }) => ClientAttributesCompanion.insert(
                id: id,
                uuid: uuid,
                clientType: clientType,
                fieldName: fieldName,
                fieldType: fieldType,
                isRequired: isRequired,
                displayOrder: displayOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ClientAttributesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientAttributesTable,
      ClientAttributesEntity,
      $$ClientAttributesTableFilterComposer,
      $$ClientAttributesTableOrderingComposer,
      $$ClientAttributesTableAnnotationComposer,
      $$ClientAttributesTableCreateCompanionBuilder,
      $$ClientAttributesTableUpdateCompanionBuilder,
      (
        ClientAttributesEntity,
        BaseReferences<
          _$AppDatabase,
          $ClientAttributesTable,
          ClientAttributesEntity
        >,
      ),
      ClientAttributesEntity,
      PrefetchHooks Function()
    >;
typedef $$ProductAttributesTableCreateCompanionBuilder =
    ProductAttributesCompanion Function({
      Value<String> id,
      required String productId,
      required String fieldName,
      required String fieldType,
      required String fieldValue,
      Value<bool> isRequired,
      Value<int> rowid,
    });
typedef $$ProductAttributesTableUpdateCompanionBuilder =
    ProductAttributesCompanion Function({
      Value<String> id,
      Value<String> productId,
      Value<String> fieldName,
      Value<String> fieldType,
      Value<String> fieldValue,
      Value<bool> isRequired,
      Value<int> rowid,
    });

final class $$ProductAttributesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ProductAttributesTable,
          ProductAttributeEntity
        > {
  $$ProductAttributesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias(
        $_aliasNameGenerator(db.productAttributes.productId, db.products.id),
      );

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProductAttributesTableFilterComposer
    extends Composer<_$AppDatabase, $ProductAttributesTable> {
  $$ProductAttributesTableFilterComposer({
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

  ColumnFilters<String> get fieldName => $composableBuilder(
    column: $table.fieldName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldType => $composableBuilder(
    column: $table.fieldType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldValue => $composableBuilder(
    column: $table.fieldValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductAttributesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductAttributesTable> {
  $$ProductAttributesTableOrderingComposer({
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

  ColumnOrderings<String> get fieldName => $composableBuilder(
    column: $table.fieldName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldType => $composableBuilder(
    column: $table.fieldType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldValue => $composableBuilder(
    column: $table.fieldValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductAttributesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductAttributesTable> {
  $$ProductAttributesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fieldName =>
      $composableBuilder(column: $table.fieldName, builder: (column) => column);

  GeneratedColumn<String> get fieldType =>
      $composableBuilder(column: $table.fieldType, builder: (column) => column);

  GeneratedColumn<String> get fieldValue => $composableBuilder(
    column: $table.fieldValue,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isRequired => $composableBuilder(
    column: $table.isRequired,
    builder: (column) => column,
  );

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductAttributesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductAttributesTable,
          ProductAttributeEntity,
          $$ProductAttributesTableFilterComposer,
          $$ProductAttributesTableOrderingComposer,
          $$ProductAttributesTableAnnotationComposer,
          $$ProductAttributesTableCreateCompanionBuilder,
          $$ProductAttributesTableUpdateCompanionBuilder,
          (ProductAttributeEntity, $$ProductAttributesTableReferences),
          ProductAttributeEntity,
          PrefetchHooks Function({bool productId})
        > {
  $$ProductAttributesTableTableManager(
    _$AppDatabase db,
    $ProductAttributesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductAttributesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductAttributesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductAttributesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String> fieldName = const Value.absent(),
                Value<String> fieldType = const Value.absent(),
                Value<String> fieldValue = const Value.absent(),
                Value<bool> isRequired = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductAttributesCompanion(
                id: id,
                productId: productId,
                fieldName: fieldName,
                fieldType: fieldType,
                fieldValue: fieldValue,
                isRequired: isRequired,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String productId,
                required String fieldName,
                required String fieldType,
                required String fieldValue,
                Value<bool> isRequired = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductAttributesCompanion.insert(
                id: id,
                productId: productId,
                fieldName: fieldName,
                fieldType: fieldType,
                fieldValue: fieldValue,
                isRequired: isRequired,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProductAttributesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productId = false}) {
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
                    if (productId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.productId,
                                referencedTable:
                                    $$ProductAttributesTableReferences
                                        ._productIdTable(db),
                                referencedColumn:
                                    $$ProductAttributesTableReferences
                                        ._productIdTable(db)
                                        .id,
                              )
                              as T;
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

typedef $$ProductAttributesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductAttributesTable,
      ProductAttributeEntity,
      $$ProductAttributesTableFilterComposer,
      $$ProductAttributesTableOrderingComposer,
      $$ProductAttributesTableAnnotationComposer,
      $$ProductAttributesTableCreateCompanionBuilder,
      $$ProductAttributesTableUpdateCompanionBuilder,
      (ProductAttributeEntity, $$ProductAttributesTableReferences),
      ProductAttributeEntity,
      PrefetchHooks Function({bool productId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$CartGroupsTableTableManager get cartGroups =>
      $$CartGroupsTableTableManager(_db, _db.cartGroups);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$BusinesssTableTableManager get businesss =>
      $$BusinesssTableTableManager(_db, _db.businesss);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$ClientAttributesTableTableManager get clientAttributes =>
      $$ClientAttributesTableTableManager(_db, _db.clientAttributes);
  $$ProductAttributesTableTableManager get productAttributes =>
      $$ProductAttributesTableTableManager(_db, _db.productAttributes);
}
