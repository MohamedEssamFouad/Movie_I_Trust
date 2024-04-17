import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:typed_data';
import 'dart:io';

class MovieDB {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDB();
    }
    return _db;
  }

  Future<Database> initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'Movie.db');
    return await openDatabase(path,
        version: 3,
        onCreate: (Database db, int version) async {
          await db.execute('''
          CREATE TABLE Usermovie (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId TEXT
         
          )
          ''');
          await db.execute('''
CREATE TABLE MovieTrust (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  img BLOB, 
  movieName TEXT,
  movieGenre TEXT,
  note TEXT
)
''');


        });
  }

  Future<void> insertMovieWithImage(String imagePath, Map<String, dynamic> movie) async {
    final dbClient = await db;
    // Load the image file
    File imageFile = File(imagePath);
    Uint8List imageBytes = await imageFile.readAsBytes();
    // Add the image bytes to the map
    movie['img'] = imageBytes;
    await dbClient?.insert('MovieTrust', movie);
  }
  Future<Uint8List?> getMovieImage(int movieId) async {
    final dbClient = await db;
    final List<Map<String, dynamic>> result = await dbClient!.query(
      'MovieTrust',
      columns: ['img'],
      where: 'id = ?',
      whereArgs: [movieId],
    );
    if (result.isNotEmpty && result.first['img'] != null) {
      return result.first['img'] as Uint8List;
    }
    return null;
  }
  Future<List<Map<String, dynamic>>> getAllMovies() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> movies = await dbClient!.query('MovieTrust');
    return movies;
  }
  Future<void>deleteMovie(int id)async{
    final dbClient=await db;
    await dbClient!.delete(
      'MovieTrust',
      where: 'id = ?' ,
      whereArgs: [id],
    );
    print("movie with id $id deleted");
  }


}
