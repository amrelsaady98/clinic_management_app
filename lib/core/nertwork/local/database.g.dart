// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
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

  PatientDao? _patientDaoInstance;

  ScanDao? _scanDaoInstance;

  ApplicatorDao? _applicatorDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `patients` (`id` INTEGER, `name` TEXT NOT NULL, `age` INTEGER NOT NULL, `gender` TEXT NOT NULL, `phoneNumber` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `scanCataloge` (`id` INTEGER NOT NULL, `type` INTEGER NOT NULL, `area` TEXT NOT NULL, `subArea` TEXT, `price` REAL, `estimatedTime` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `applicators` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `scan` (`id` INTEGER NOT NULL, `reservationId` INTEGER NOT NULL, `applicatorId` INTEGER NOT NULL, `scanCatalogeId` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PatientDao get patientDao {
    return _patientDaoInstance ??= _$PatientDao(database, changeListener);
  }

  @override
  ScanDao get scanDao {
    return _scanDaoInstance ??= _$ScanDao(database, changeListener);
  }

  @override
  ApplicatorDao get applicatorDao {
    return _applicatorDaoInstance ??= _$ApplicatorDao(database, changeListener);
  }
}

class _$PatientDao extends PatientDao {
  _$PatientDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _patientModelInsertionAdapter = InsertionAdapter(
            database,
            'patients',
            (PatientModel item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'age': item.age,
                  'gender': item.gender,
                  'phoneNumber': item.phoneNumber
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PatientModel> _patientModelInsertionAdapter;

  @override
  Future<void> deletePatient(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM patients WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<PatientModel?> getPatientById(int id) async {
    return _queryAdapter.query('SELECT * FROM patients WHERE id = ?1',
        mapper: (Map<String, Object?> row) => PatientModel(
            id: row['id'] as int?,
            name: row['name'] as String,
            age: row['age'] as int,
            gender: row['gender'] as String,
            phoneNumber: row['phoneNumber'] as String?),
        arguments: [id]);
  }

  @override
  Future<List<PatientModel>?> getAllPatient() async {
    return _queryAdapter.queryList('SELECT * FROM  patients',
        mapper: (Map<String, Object?> row) => PatientModel(
            id: row['id'] as int?,
            name: row['name'] as String,
            age: row['age'] as int,
            gender: row['gender'] as String,
            phoneNumber: row['phoneNumber'] as String?));
  }

  @override
  Future<List<PatientModel>?> getAllPatientsFilter(
    String name,
    String phoneNumber,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM patients WHERE name LIKE ?1 AND (phoneNumber LIKE ?2 OR phoneNumber  ISNULL) ORDER BY phoneNumber DESC, id ASC',
        mapper: (Map<String, Object?> row) => PatientModel(id: row['id'] as int?, name: row['name'] as String, age: row['age'] as int, gender: row['gender'] as String, phoneNumber: row['phoneNumber'] as String?),
        arguments: [name, phoneNumber]);
  }

  @override
  Future<void> insertPatient(PatientModel patient) async {
    await _patientModelInsertionAdapter.insert(
        patient, OnConflictStrategy.abort);
  }
}

class _$ScanDao extends ScanDao {
  _$ScanDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _scanCatalogeModelInsertionAdapter = InsertionAdapter(
            database,
            'scanCataloge',
            (ScanCatalogeModel item) => <String, Object?>{
                  'id': item.id,
                  'type': item.type.index,
                  'area': item.area,
                  'subArea': item.subArea,
                  'price': item.price,
                  'estimatedTime': item.estimatedTime
                }),
        _scanModelInsertionAdapter = InsertionAdapter(
            database,
            'scan',
            (ScanModel item) => <String, Object?>{
                  'id': item.id,
                  'reservationId': item.reservationId,
                  'applicatorId': item.applicatorId,
                  'scanCatalogeId': item.scanCatalogeId
                }),
        _scanCatalogeModelUpdateAdapter = UpdateAdapter(
            database,
            'scanCataloge',
            ['id'],
            (ScanCatalogeModel item) => <String, Object?>{
                  'id': item.id,
                  'type': item.type.index,
                  'area': item.area,
                  'subArea': item.subArea,
                  'price': item.price,
                  'estimatedTime': item.estimatedTime
                }),
        _scanCatalogeModelDeletionAdapter = DeletionAdapter(
            database,
            'scanCataloge',
            ['id'],
            (ScanCatalogeModel item) => <String, Object?>{
                  'id': item.id,
                  'type': item.type.index,
                  'area': item.area,
                  'subArea': item.subArea,
                  'price': item.price,
                  'estimatedTime': item.estimatedTime
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ScanCatalogeModel> _scanCatalogeModelInsertionAdapter;

  final InsertionAdapter<ScanModel> _scanModelInsertionAdapter;

  final UpdateAdapter<ScanCatalogeModel> _scanCatalogeModelUpdateAdapter;

  final DeletionAdapter<ScanCatalogeModel> _scanCatalogeModelDeletionAdapter;

  @override
  Future<List<ScanCatalogeModel>?> getAllScanCataloge() async {
    return _queryAdapter.queryList('SELECT * FROM scan_cataloge',
        mapper: (Map<String, Object?> row) => ScanCatalogeModel(
            id: row['id'] as int,
            type: ScanType.values[row['type'] as int],
            area: row['area'] as String,
            subArea: row['subArea'] as String?,
            price: row['price'] as double?,
            estimatedTime: row['estimatedTime'] as int?));
  }

  @override
  Future<ScanCatalogeModel?> getScanCatalogeById(int id) async {
    return _queryAdapter.query('SELECT * FROM scan_cataloge WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ScanCatalogeModel(
            id: row['id'] as int,
            type: ScanType.values[row['type'] as int],
            area: row['area'] as String,
            subArea: row['subArea'] as String?,
            price: row['price'] as double?,
            estimatedTime: row['estimatedTime'] as int?),
        arguments: [id]);
  }

  @override
  Future<List<ScanModel>?> getAllScanByResevation(int reservationId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM scan WHERE reservationId = ?1',
        mapper: (Map<String, Object?> row) => ScanModel(
            id: row['id'] as int,
            reservationId: row['reservationId'] as int,
            applicatorId: row['applicatorId'] as int,
            scanCatalogeId: row['scanCatalogeId'] as int),
        arguments: [reservationId]);
  }

  @override
  Future<List<ScanModel>?> getAllScanByApplicator(int applicatorId) async {
    return _queryAdapter.queryList('SELECT * FROM scan WHERE applicatorId = ?1',
        mapper: (Map<String, Object?> row) => ScanModel(
            id: row['id'] as int,
            reservationId: row['reservationId'] as int,
            applicatorId: row['applicatorId'] as int,
            scanCatalogeId: row['scanCatalogeId'] as int),
        arguments: [applicatorId]);
  }

  @override
  Future<void> insertScanCataloge(ScanCatalogeModel scanCataloge) async {
    await _scanCatalogeModelInsertionAdapter.insert(
        scanCataloge, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertScan(ScanModel scan) async {
    await _scanModelInsertionAdapter.insert(scan, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateScanCataloge(ScanCatalogeModel scanCatalogeModel) async {
    await _scanCatalogeModelUpdateAdapter.update(
        scanCatalogeModel, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteScanCataloge(ScanCatalogeModel scanCataloge) async {
    await _scanCatalogeModelDeletionAdapter.delete(scanCataloge);
  }
}

class _$ApplicatorDao extends ApplicatorDao {
  _$ApplicatorDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _applicatorModelInsertionAdapter = InsertionAdapter(
            database,
            'applicators',
            (ApplicatorModel item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ApplicatorModel> _applicatorModelInsertionAdapter;

  @override
  Future<List<ApplicatorModel>?> getAllApplicators() async {
    return _queryAdapter.queryList('SELECT * FROM applicators',
        mapper: (Map<String, Object?> row) =>
            ApplicatorModel(id: row['id'] as int, name: row['name'] as String));
  }

  @override
  Future<ApplicatorModel?> getApplicatorById(int id) async {
    return _queryAdapter.query('SELECT * FROM applicators WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            ApplicatorModel(id: row['id'] as int, name: row['name'] as String),
        arguments: [id]);
  }

  @override
  Future<void> deleteApplicator(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM applicators WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertApplicator(ApplicatorModel applicatorModel) async {
    await _applicatorModelInsertionAdapter.insert(
        applicatorModel, OnConflictStrategy.abort);
  }
}
