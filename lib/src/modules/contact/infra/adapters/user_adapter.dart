

import '../../domain/entities/user.dart';

class UserAdapter {
  static const String tableName = 'user';
  static const String columnId = '_id';
  static const String columnFirstName = 'firstName';
  static const String columnLastName = 'lastName';
  static const String columnDocumentNumber = 'documentNumber';
  static const String columnEmail = 'email';
  static const String columnPhoto = 'photo';
  static const String columnCelPhoneNumber = 'celPhoneNumber';
  static const String columnWorkPhoneNumber = 'workPhoneNumber';
  static const String columnHomePhoneNumber = 'homePhoneNumber';

  Map<String, dynamic> toJson(User user) => {
        columnId: user.id,
        columnFirstName: user.firstName,
        columnLastName: user.lastName,
        columnDocumentNumber: user.documentNumber,
        columnEmail: user.email,
        columnPhoto: user.photo,
        columnCelPhoneNumber: user.celPhoneNumber,
        columnWorkPhoneNumber: user.workPhoneNumber,
        columnHomePhoneNumber: user.homePhoneNumber
      };

  static List<User> fromJsonList(List<dynamic> json) =>
      json.map((i) => fromJson(i)).toList();

  static User fromJson(Map<String, dynamic> json) {
    return User(
        id: json[columnId],
        documentNumber: json[columnDocumentNumber],
        firstName: json[columnFirstName],
        lastName: json[columnLastName],
        email: json[columnEmail],
        photo: json[columnPhoto],
        celPhoneNumber: json[columnCelPhoneNumber],
        workPhoneNumber: json[columnWorkPhoneNumber],
        homePhoneNumber: json[columnHomePhoneNumber]);
  }

  static String createTableQuery() {
    return "CREATE TABLE $tableName (" +
        "$columnId INTEGER PRIMARY KEY " +
        "$columnFirstName TEXT" +
        "$columnLastName TEXT" +
        "$columnDocumentNumber TEXT" +
        "$columnEmail TEXT" +
        "$columnPhoto TEXT" +
        "$columnCelPhoneNumber TEXT" +
        "$columnWorkPhoneNumber TEXT" +
        "$columnHomePhoneNumber TEXT" +
        ")";
  }
}
