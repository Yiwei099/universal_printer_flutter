// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_data_base.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  DaoBitmapOption? _daoBitmapOptionInstance;

  DrawElementDao? _drawElementDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `BitmapOption` (`maxWidth` INTEGER NOT NULL, `maxHeight` INTEGER NOT NULL, `topIndentation` REAL NOT NULL, `startIndentation` REAL NOT NULL, `endIndentation` REAL NOT NULL, `bottomBlankHeight` REAL NOT NULL, `antiAlias` INTEGER NOT NULL, `gravity` INTEGER NOT NULL, `followEffectItem` INTEGER NOT NULL, `bitmapType` INTEGER NOT NULL, PRIMARY KEY (`bitmapType`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DrawElement` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `sortNum` INTEGER, `elementType` INTEGER NOT NULL, `perLineSpac` INTEGER NOT NULL, `text` TEXT NOT NULL, `alignment` INTEGER NOT NULL, `fontSize` INTEGER NOT NULL, `autoEnter` INTEGER NOT NULL, `weight` REAL NOT NULL, `typeFace` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DaoBitmapOption get daoBitmapOption {
    return _daoBitmapOptionInstance ??=
        _$DaoBitmapOption(database, changeListener);
  }

  @override
  DrawElementDao get drawElementDao {
    return _drawElementDaoInstance ??=
        _$DrawElementDao(database, changeListener);
  }
}

class _$DaoBitmapOption extends DaoBitmapOption {
  _$DaoBitmapOption(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _bitmapOptionInsertionAdapter = InsertionAdapter(
            database,
            'BitmapOption',
            (BitmapOption item) => <String, Object?>{
                  'maxWidth': item.maxWidth,
                  'maxHeight': item.maxHeight,
                  'topIndentation': item.topIndentation,
                  'startIndentation': item.startIndentation,
                  'endIndentation': item.endIndentation,
                  'bottomBlankHeight': item.bottomBlankHeight,
                  'antiAlias': item.antiAlias ? 1 : 0,
                  'gravity': item.gravity,
                  'followEffectItem': item.followEffectItem ? 1 : 0,
                  'bitmapType': item.bitmapType
                }),
        _bitmapOptionUpdateAdapter = UpdateAdapter(
            database,
            'BitmapOption',
            ['bitmapType'],
            (BitmapOption item) => <String, Object?>{
                  'maxWidth': item.maxWidth,
                  'maxHeight': item.maxHeight,
                  'topIndentation': item.topIndentation,
                  'startIndentation': item.startIndentation,
                  'endIndentation': item.endIndentation,
                  'bottomBlankHeight': item.bottomBlankHeight,
                  'antiAlias': item.antiAlias ? 1 : 0,
                  'gravity': item.gravity,
                  'followEffectItem': item.followEffectItem ? 1 : 0,
                  'bitmapType': item.bitmapType
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BitmapOption> _bitmapOptionInsertionAdapter;

  final UpdateAdapter<BitmapOption> _bitmapOptionUpdateAdapter;

  @override
  Future<List<BitmapOption>> queryBitmapOption() async {
    return _queryAdapter.queryList('Select * from BitmapOption',
        mapper: (Map<String, Object?> row) => BitmapOption(
            maxWidth: row['maxWidth'] as int,
            maxHeight: row['maxHeight'] as int,
            topIndentation: row['topIndentation'] as double,
            startIndentation: row['startIndentation'] as double,
            endIndentation: row['endIndentation'] as double,
            bottomBlankHeight: row['bottomBlankHeight'] as double,
            antiAlias: (row['antiAlias'] as int) != 0,
            gravity: row['gravity'] as int,
            followEffectItem: (row['followEffectItem'] as int) != 0,
            bitmapType: row['bitmapType'] as int));
  }

  @override
  Future<BitmapOption?> queryBitmapOptionByType(int type) async {
    return _queryAdapter.query(
        'Select * from BitmapOption where bitmapType = ?1',
        mapper: (Map<String, Object?> row) => BitmapOption(
            maxWidth: row['maxWidth'] as int,
            maxHeight: row['maxHeight'] as int,
            topIndentation: row['topIndentation'] as double,
            startIndentation: row['startIndentation'] as double,
            endIndentation: row['endIndentation'] as double,
            bottomBlankHeight: row['bottomBlankHeight'] as double,
            antiAlias: (row['antiAlias'] as int) != 0,
            gravity: row['gravity'] as int,
            followEffectItem: (row['followEffectItem'] as int) != 0,
            bitmapType: row['bitmapType'] as int),
        arguments: [type]);
  }

  @override
  Future<void> insertBitmapOption(BitmapOption bitmapOption) async {
    await _bitmapOptionInsertionAdapter.insert(
        bitmapOption, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateBitmapOption(BitmapOption bitmapOption) async {
    await _bitmapOptionUpdateAdapter.update(
        bitmapOption, OnConflictStrategy.abort);
  }
}

class _$DrawElementDao extends DrawElementDao {
  _$DrawElementDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _drawElementInsertionAdapter = InsertionAdapter(
            database,
            'DrawElement',
            (DrawElement item) => <String, Object?>{
                  'id': item.id,
                  'sortNum': item.sortNum,
                  'elementType': item.elementType,
                  'perLineSpac': item.perLineSpac,
                  'text': item.text,
                  'alignment': item.alignment,
                  'fontSize': item.fontSize,
                  'autoEnter': item.autoEnter ? 1 : 0,
                  'weight': item.weight,
                  'typeFace': item.typeFace
                }),
        _drawElementUpdateAdapter = UpdateAdapter(
            database,
            'DrawElement',
            ['id'],
            (DrawElement item) => <String, Object?>{
                  'id': item.id,
                  'sortNum': item.sortNum,
                  'elementType': item.elementType,
                  'perLineSpac': item.perLineSpac,
                  'text': item.text,
                  'alignment': item.alignment,
                  'fontSize': item.fontSize,
                  'autoEnter': item.autoEnter ? 1 : 0,
                  'weight': item.weight,
                  'typeFace': item.typeFace
                }),
        _drawElementDeletionAdapter = DeletionAdapter(
            database,
            'DrawElement',
            ['id'],
            (DrawElement item) => <String, Object?>{
                  'id': item.id,
                  'sortNum': item.sortNum,
                  'elementType': item.elementType,
                  'perLineSpac': item.perLineSpac,
                  'text': item.text,
                  'alignment': item.alignment,
                  'fontSize': item.fontSize,
                  'autoEnter': item.autoEnter ? 1 : 0,
                  'weight': item.weight,
                  'typeFace': item.typeFace
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DrawElement> _drawElementInsertionAdapter;

  final UpdateAdapter<DrawElement> _drawElementUpdateAdapter;

  final DeletionAdapter<DrawElement> _drawElementDeletionAdapter;

  @override
  Future<List<DrawElement>> queryAllElement() async {
    return _queryAdapter.queryList(
        'Select * from DrawElement order by sortNum desc',
        mapper: (Map<String, Object?> row) => DrawElement(
            id: row['id'] as int?,
            elementType: row['elementType'] as int,
            perLineSpac: row['perLineSpac'] as int,
            text: row['text'] as String,
            alignment: row['alignment'] as int,
            fontSize: row['fontSize'] as int,
            autoEnter: (row['autoEnter'] as int) != 0,
            weight: row['weight'] as double,
            typeFace: row['typeFace'] as int,
            sortNum: row['sortNum'] as int?));
  }

  @override
  Future<void> insertElement(DrawElement element) async {
    await _drawElementInsertionAdapter.insert(
        element, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateElement(DrawElement element) async {
    await _drawElementUpdateAdapter.update(element, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteElement(DrawElement element) async {
    await _drawElementDeletionAdapter.delete(element);
  }
}
