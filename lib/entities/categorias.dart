import 'package:flutter/material.dart';
import 'package:smart_vendor/provider/database_provider.dart';
import 'package:sqflite/sqflite.dart';

const tableCategorias = "categorias";
const colIdCategoria = "id_categoria";
const colDeCategoria = "de_categoria";
const colIdCategoriaPai = "id_categoria_pai";
const colFlCategoriaMestre = "fl_categoria_pai";

const createTableCategorias = 'CREATE TABLE people ('
    'id_categoria INTEGER PRIMARY KEY,'
    'de_categoria TEXT NOT NULL,'
    'id_categoria_pai INTEGER,'
    'fl_categoria_pai INTEGER'
    ');';

class Categorias {
  int idCategoria = 0;
  String deCategoria = "";
  int idCategoriaPai = 0;
  int flCategoriaMestre = 1;

  Categorias(this.idCategoria, this.deCategoria, this.idCategoriaPai,
      this.flCategoriaMestre);

  Categorias.empty();

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id_categoria'] = idCategoria;
    map['de_categoria'] = deCategoria;
    map['id_categoria_pai'] = idCategoriaPai;
    map['fl_categoria_mestre'] = flCategoriaMestre;
    return map;
  }

  factory Categorias.fromMapObject(Map<String, dynamic> map) {
    return Categorias((map['id_categoria'] ?? ""), (map['de_categoria'] ?? ""),
        (map['id_categoria_pai'] ?? ""), (map['fl_categoria_mestre'] ?? ""));
  }
}

class CategoriasProvider {
  Future<Categorias> insert(Categorias categoria) async {
    Database db = await DatabaseProvider.db.database;
    await db.rawInsert(
        " INSERT OR IGNORE INTO $tableCategorias( "
        " $colIdCategoria, "
        " $colDeCategoria, "
        " $colIdCategoriaPai, "
        " $colFlCategoriaMestre "
        ") values (?,?,?,?) ",
        [
          categoria.idCategoria,
          categoria.deCategoria,
          categoria.idCategoriaPai,
          categoria.flCategoriaMestre,
        ]);

    await update(categoria);
    return categoria;
  }

  Future<Categorias> update(Categorias categorias) async {
    Database db = await DatabaseProvider.db.database;
    await db.rawUpdate(
        " UPDATE $tableCategorias SET"
        //" $colId = ?, "
        " $colDeCategoria = ?, "
        " $colIdCategoriaPai = ?,"
        " $colFlCategoriaMestre = ?"
        " WHERE $colIdCategoria = ? ",
        [
          // categorias.id,
          categorias.deCategoria,
          categorias.idCategoriaPai,
          categorias.flCategoriaMestre,
          categorias.idCategoria
        ]);
    return categorias;
  }

  Future<int> delete(int id) async {
    Database db = await DatabaseProvider.db.database;
    return await db
        .delete(tableCategorias, where: '$colIdCategoria = ?', whereArgs: [id]);
  }

  Future<void> deleteFrom() async {
    Database db = await DatabaseProvider.db.database;
    return await db.execute("DELETE FROM $tableCategorias");
  }

  Future<List<Categorias>> getCategoriasMapList() async {
    Database db = await DatabaseProvider.db.database;

    List<Categorias> listaRetorno = List.empty(growable: true);
    List<Map<String, dynamic>> listaMap = await db.query(tableCategorias,
        orderBy: '$colIdCategoria ASC');
    listaRetorno = List<Categorias>.from(
        listaMap.map((e) => Categorias.fromMapObject(e)));
    return listaRetorno;
  }
}
