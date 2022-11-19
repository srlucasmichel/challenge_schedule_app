

import '../../domain/entities/user.dart';

class UserAdapter {
  static final String tableName = 'user';
  static final String columnId = '_id';
  static final String columnFirstName = 'firstName';
  static final String columnLastName = 'lastName';
  static final String columnDocumentNumber = 'documentNumber';
  static final String columnEmail = 'email';
  static final String columnPhoto = 'photo';
  static final String columnCelPhoneNumber = 'celPhoneNumber';
  static final String columnWorkPhoneNumber = 'workPhoneNumber';
  static final String columnHomePhoneNumber = 'homePhoneNumber';

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
        "$tableName INTEGER PRIMARY KEY " +
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
