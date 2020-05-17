import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
class DatabaseConnection{
  setDatabase() async{
    var directory=await getApplicationDocumentsDirectory();
    var path=join(directory.path,'db_eltodo');
    var database=await openDatabase(path,version:1,onCreate:_onCreatingDatabase);
    return database;
  }
  _onCreatingDatabase(Database db,int version) async{
    String category_Table = 'categories';
    String category_id  = 'id';
    String category_name = 'name';
    String description  = 'description ';
    await db.execute(
      'CREATE TABLE $category_Table($category_id INTEGER PRIMARY KEY UNIQUE  , $category_name TEXT, '
                '$description TEXT)');
        print('category created!');
  }
}