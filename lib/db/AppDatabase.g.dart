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
            'CREATE TABLE IF NOT EXISTS `TextElement` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `text` TEXT NOT NULL, `alignment` INTEGER NOT NULL, `fontSize` INTEGER NOT NULL, `perLineSpac` INTEGER NOT NULL, `autoEnter` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DrawElementDao get drawElementDao {
    return _drawElementDaoInstance ??=
        _$DrawElementDao(database, changeListener);
  }
}

class _$DrawElementDao extends DrawElementDao {
  _$DrawElementDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _textElementInsertionAdapter = InsertionAdapter(
            database,
            'TextElement',
            (TextElement item) => <String, Object?>{
                  'id': item.id,
                  'text': item.text,
                  'alignment': item.alignment,
                  'fontSize': item.fontSize,
                  'perLineSpac': item.perLineSpac,
                  'autoEnter': item.autoEnter ? 1 : 0
                }),
        _textElementUpdateAdapter = UpdateAdapter(
            database,
            'TextElement',
            ['id'],
            (TextElement item) => <String, Object?>{
                  'id': item.id,
                  'text': item.text,
                  'alignment': item.alignment,
                  'fontSize': item.fontSize,
                  'perLineSpac': item.perLineSpac,
                  'autoEnter': item.autoEnter ? 1 : 0
                }),
        _textElementDeletionAdapter = DeletionAdapter(
            database,
            'TextElement',
            ['id'],
            (TextElement item) => <String, Object?>{
                  'id': item.id,
                  'text': item.text,
                  'alignment': item.alignment,
                  'fontSize': item.fontSize,
                  'perLineSpac': item.perLineSpac,
                  'autoEnter': item.autoEnter ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TextElement> _textElementInsertionAdapter;

  final UpdateAdapter<TextElement> _textElementUpdateAdapter;

  final DeletionAdapter<TextElement> _textElementDeletionAdapter;

  @override
  Future<List<TextElement>> queryAllElement() async {
    return _queryAdapter.queryList('Select * from TextElement',
        mapper: (Map<String, Object?> row) => TextElement(
            id: row['id'] as int?,
            text: row['text'] as String,
            alignment: row['alignment'] as int,
            fontSize: row['fontSize'] as int,
            autoEnter: (row['autoEnter'] as int) != 0,
            perLineSpac: row['perLineSpac'] as int));
  }

  @override
  Future<void> insertElement(TextElement element) async {
    await _textElementInsertionAdapter.insert(
        element, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateElement(TextElement element) async {
    await _textElementUpdateAdapter.update(element, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteElement(TextElement element) async {
    await _textElementDeletionAdapter.delete(element);
  }
}
