import 'dart:io';
import 'package:cofredesenha/models/cliente.dart';
import 'package:cofredesenha/models/password/BankModel.dart';
import 'package:cofredesenha/models/password/SaveAccaunt.dart';
import 'package:cofredesenha/models/password/socialModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


//USER
const String tableUser = 'User';
const String columnId = 'id';
const String columnName = 'nome';
const String columnSenha = 'senha';
const String columnEmail = 'email';



const String tableAccount = 'Account';
// const String columnIdAccount = 'idAccount';
const String columnLocal = 'local';
const String columnAccauntId = 'id';
const String columnPassword = 'password';
const String columnObservation = 'observation';

const String tableBank = 'Bank';
const String columnBanktId = 'id';
const String columnbank = 'bank';
const String columnagency = 'agencyAccount';
const String columnaccaunt = 'account';
const String columnpasswordBank = 'bankpassword';
const String columntypeBank = 'type';

const String tableSocial = 'Social';
const String columnSocialtId = 'id';
const String columnname = 'name';
const String columnpassword = 'password';
const String columntype = 'type';
const String columnpasswordSocial = 'passwordSocial';
const String columnObservationSocial = 'ob';



class DatabaseProvider {

  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // // if _database is null we instantiate it
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "database.db");

    // await deleteDatabase(path);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
    create table $tableUser (
    $columnId integer primary key autoincrement,
    $columnName text,
    $columnSenha text,
    $columnEmail text 
    
    )''');

    await db.execute('''
    create table $tableAccount (
    $columnAccauntId integer primary key autoincrement,
    $columnLocal text not null,
    $columnPassword text not null,
    $columnObservation text not null
    )''');

    await db.execute('''
    create table $tableBank (
    $columnBanktId integer primary key autoincrement,
    $columnbank text,
    $columnagency text,
    $columnaccaunt text,
    $columnpasswordBank text,
    $columntypeBank text
    )''');

    await db.execute('''
    create table $tableSocial (
    $columnSocialtId integer primary key autoincrement,
    $columnname text,
    $columnpasswordSocial text,
    $columntype text,
    $columnObservationSocial text 
    )''');

  }
  Future<int> editCliente(Cliente saveAccountModel) async {
    final db = await database;
    // var cpf = await getCustomer();
    var res = await db.update(
      tableUser,
      saveAccountModel.toJson(),
      where: "id = ?",
      whereArgs: [saveAccountModel.id],
    );
    // var res = await db.(tableAccount, {
    //   // columnAccauntId: saveAccountModel.id,
    //   columnLocal: saveAccountModel.local ?? "",
    //   columnPassword: saveAccountModel.password ?? "",
    //   columnObservation: saveAccountModel.observation ?? "",
    //
    // });

    return res;
  }
  Future<int> saveBank(BankModel saveAccountModel) async {
    final db = await database;
    // var cpf = await getCustomer();
    var res = await db.insert(tableBank, {
      columnbank: saveAccountModel.bank ?? "",
      columnagency: saveAccountModel.agency ?? "",
      columnaccaunt: saveAccountModel.account ?? "",
      columnpasswordBank: saveAccountModel.password ?? "",
      columntypeBank: saveAccountModel.type ?? "",

    });

    return res;
  }
  Future<int> editBank(BankModel saveAccountModel) async {
    final db = await database;
    // var cpf = await getCustomer();
    var res = await db.update(
      tableBank,
      saveAccountModel.toJson(),
      where: "id = ?",
      whereArgs: [saveAccountModel.id],
    );
    // var res = await db.(tableAccount, {
    //   // columnAccauntId: saveAccountModel.id,
    //   columnLocal: saveAccountModel.local ?? "",
    //   columnPassword: saveAccountModel.password ?? "",
    //   columnObservation: saveAccountModel.observation ?? "",
    //
    // });

    return res;
  }
  Future<List<BankModel>> getBank() async {
    final db = await database;
    var res = await db.query(tableBank);
    List<BankModel> list = res.isNotEmpty
        ? res.map((c) => BankModel.fromJson(c)).toList()
        : [];
    return list;
  }

  Future<int> deleteBank(BankModel saveAccountModel) async {
    final db = await database;
    var res = await db.delete(tableBank,where: "id = ?", whereArgs: [saveAccountModel.id]);
    return res;
  }

  Future<List<SocialModel>> getSocial() async {
    final db = await database;
    var res = await db.query(tableSocial);
    List<SocialModel> list = res.isNotEmpty
        ? res.map((c) => SocialModel.fromJson(c)).toList()
        : [];
    return list;
  }
  Future<int> saveSocial(SocialModel saveAccountModel) async {
    final db = await database;
    // var cpf = await getCustomer();
    var res = await db.insert(tableSocial, {
      columnname: saveAccountModel.name ?? "",
      columnpasswordSocial: saveAccountModel.password ?? "",
      columntype: saveAccountModel.type?? "",
      // columnObservationSocial: saveAccountModel.ob?? "",

    });

    return res;
  }
  Future<int> editSocial(SocialModel saveAccountModel) async {
    final db = await database;
    // var cpf = await getCustomer();
    var res = await db.update(
      tableSocial,
      saveAccountModel.toJson(),
      where: "id = ?",
      whereArgs: [saveAccountModel.id],
    );
    // var res = await db.(tableAccount, {
    //   // columnAccauntId: saveAccountModel.id,
    //   columnLocal: saveAccountModel.local ?? "",
    //   columnPassword: saveAccountModel.password ?? "",
    //   columnObservation: saveAccountModel.observation ?? "",
    //
    // });

    return res;
  }

  Future<int> deleteSocial(SocialModel saveAccountModel) async {
    final db = await database;
    var res = await db.delete(tableSocial,where: "id = ?", whereArgs: [saveAccountModel.id]);
    return res;
  }



  Future<int> saveCustomer(Cliente responseModel,) async {
    final db = await database;
    var res = await db.insert(tableUser, {
      columnName: responseModel.nome ?? "",
      columnSenha: responseModel.senha ?? "",
      columnEmail: responseModel.email ?? "",
    });

    return res;
  }

  Future<int> deleteCustomer() async {
    final db = await database;
    var res = await db.delete(tableUser);
    return res;
  }

  Future<Cliente> getCustomer() async {
    final db = await database;
    var res = await db.query(tableUser);

    List<Cliente> list = res.isNotEmpty
        ? res.map((c) => Cliente.fromJson(c)).toList()
        : [];
    return list.first;
  }


  Future<int> saveAccount(SaveAccountModel saveAccountModel) async {
    final db = await database;
    // var cpf = await getCustomer();
    var res = await db.insert(tableAccount, {
      columnLocal: saveAccountModel.local ?? "",
      columnPassword: saveAccountModel.password ?? "",
      columnObservation: saveAccountModel.observation ?? "",
    });

    return res;
  }
  Future<int> editAccount(SaveAccountModel saveAccountModel) async {
    final db = await database;
    // var cpf = await getCustomer();
    var res = await db.update(
      tableAccount,
      saveAccountModel.toJson(),
      where: "id = ?",
      whereArgs: [saveAccountModel.id],
    );
    // var res = await db.(tableAccount, {
    //   // columnAccauntId: saveAccountModel.id,
    //   columnLocal: saveAccountModel.local ?? "",
    //   columnPassword: saveAccountModel.password ?? "",
    //   columnObservation: saveAccountModel.observation ?? "",
    //
    // });

    return res;
  }

  Future<int> deleteAccount(SaveAccountModel saveAccountModel) async {
    final db = await database;
    var res = await db.delete(tableAccount,where: "id = ?", whereArgs: [saveAccountModel.id]);
    return res;
  }

  Future<List<SaveAccountModel>> getAccount() async {
    final db = await database;
    var res = await db.query(tableAccount);
    List<SaveAccountModel> list = res.isNotEmpty
        ? res.map((c) => SaveAccountModel.fromJson(c)).toList()
        : [];
    return list;
  }
}
