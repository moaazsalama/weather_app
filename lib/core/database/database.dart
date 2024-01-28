import 'dart:typed_data';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:weather_app/core/encrypt/encrypt.dart';

class WeatherDatabase {
  late Database _database;
  final String _weatherTableName = 'weather_cache';
  final String _allDayTableName = 'all_day_cache';
  final String _dbName = 'weather_database.db';
  final EncryptionService _encryptionService;

  WeatherDatabase(this._encryptionService);

  Future<void> open() async {
    final appDirectory = await getApplicationDocumentsDirectory();
    final dbPath = p.join(appDirectory.path, _dbName);

    // Open the database
    _database = await openDatabase(dbPath, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create the weather cache table
    await db.execute('''
      CREATE TABLE $_weatherTableName (
        id INTEGER PRIMARY KEY,
        city TEXT NOT NULL,
        encrypted_data TEXT NOT NULL
      )
    ''');
    //create all day table
    await db.execute('''
      CREATE TABLE $_allDayTableName (
        id INTEGER PRIMARY KEY,
        city TEXT NOT NULL,
        encrypted_data TEXT NOT NULL
      )
    ''');
  }

  Future<void> cacheWeather(String city, String jsonWeather) async {
    // Encrypt the data before storing
    final encryptedData = _encryptionService.encrypt(jsonWeather);

    await _database.insert(
      _weatherTableName,
      {'city': city, 'encrypted_data': encryptedData},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getCachedWeather(String city) async {
    final List<Map<String, dynamic>> results = await _database.query(
      _weatherTableName,
      where: 'city = ?',
      whereArgs: [city],
    );

    if (results.isNotEmpty) {
      // Decrypt the stored data
      final encryptedData = results.first['encrypted_data'] as String;
      return _encryptionService.decrypt(encryptedData);
    }

    return null;
  }

  //get all day
  Future<void> cacheAllDayWeather(String city, String jsonWeather) async {
    // Encrypt the data before storing
    final encryptedData = _encryptionService.encrypt(jsonWeather);

    await _database.insert(
      _allDayTableName,
      {'city': city, 'encrypted_data': encryptedData},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //get all day
  Future<String?> getCachedAllDayWeather(String city) async {
    final List<Map<String, dynamic>> results = await _database.query(
      _allDayTableName,
      where: 'city = ?',
      whereArgs: [city],
    );

    if (results.isNotEmpty) {
      // Decrypt the stored data
      final encryptedData = results.first['encrypted_data'] as String;
      return _encryptionService.decrypt(encryptedData);
    }

    return null;
  }

  //get last cahce weather
  Future<String?> getLastCachedWeather() async {
    final List<Map<String, dynamic>> results = await _database.query(
      _weatherTableName,
      orderBy: 'id DESC',
      limit: 1,
    );

    if (results.isNotEmpty) {
      // Decrypt the stored data
      final encryptedData = results.first['encrypted_data'] as String;
      return _encryptionService.decrypt(encryptedData);
    }

    return null;
  }

  //get last cahce all day weather
  Future<String?> getLastCachedAllDayWeather() async {
    final List<Map<String, dynamic>> results = await _database.query(
      _allDayTableName,
      orderBy: 'id DESC',
      limit: 1,
    );

    if (results.isNotEmpty) {
      // Decrypt the stored data
      final encryptedData = results.first['encrypted_data'] as String;
      return _encryptionService.decrypt(encryptedData);
    }

    return null;
  }
}
