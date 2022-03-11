import 'package:smart_vendor/entities/categorias.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();

  static Database? _database;

  Future<Database> get database async => _database ??= await initDB();

  static String dbName = "smartVendor";

  static int version = 1;

  initDB() async {
    return await openDatabase(dbName, version: version, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      createDatabase(db);
    });
  }

  //, onUpgrade: (Database db, int oldVersion, int newVersion) {
  //       _onUpgrade(db, oldVersion, newVersion);
  //     }

  static Future deleteDB() async {
    Database db = await DatabaseProvider.db.database;
    db.close();
    deleteDatabase(DatabaseProvider.dbName);
    _database = null;
    return;
  }

  // void _onUpgrade(Database db, int oldVersion, int newVersion) {
  //   if (oldVersion == 8 && newVersion == 9) {
  //     db.execute("ALTER TABLE doccapa ADD COLUMN de_formato_entrega TEXT;");
  //   }
  //
  //   if (oldVersion == 9 && newVersion == 10) {
  //     db.execute(createTableAgentesEnderecos);
  //     db.execute(
  //         "ALTER TABLE doccapa ADD COLUMN nu_sequencia_endereco_agente_selecionado TEXT;");
  //   }
  // }

  Future<void> createDatabase(Database db) async {
    var batch = db.batch();
    batch.execute(createTableCategorias);
    await batch.commit(noResult: true);
    return;
  }
}
