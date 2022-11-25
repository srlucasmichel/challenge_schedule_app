import '../../domain/entities/user.dart';

class UserAdapter {
  static const String tableName = 'tb_user';
  static const String columnId = 'id';
  static const String columnFirstName = 'firstName';
  static const String columnLastName = 'lastName';
  static const String columnDocumentNumber = 'documentNumber';
  static const String columnEmail = 'email';
  static const String columnPhoto = 'photo';
  static const String columnCellPhoneNumber = 'cellPhoneNumber';
  static const String columnWorkPhoneNumber = 'workPhoneNumber';
  static const String columnHomePhoneNumber = 'homePhoneNumber';

  Map<String, dynamic> toJson(final User user) => {
        columnId: user.id,
        columnFirstName: user.firstName,
        columnLastName: user.lastName,
        columnDocumentNumber: user.documentNumber,
        columnEmail: user.email,
        columnPhoto: user.photo,
        columnCellPhoneNumber: user.cellPhoneNumber,
        columnWorkPhoneNumber: user.workPhoneNumber,
        columnHomePhoneNumber: user.homePhoneNumber
      };

  static List<User> fromJsonList(final List<dynamic> json) =>
      json.map((i) => fromJson(i)).toList();

  static User fromJson(final Map<String, dynamic> json) {
    return User(
        id: json[columnId],
        documentNumber: json[columnDocumentNumber],
        firstName: json[columnFirstName],
        lastName: json[columnLastName],
        email: json[columnEmail],
        photo: json[columnPhoto],
        cellPhoneNumber: json[columnCellPhoneNumber],
        workPhoneNumber: json[columnWorkPhoneNumber],
        homePhoneNumber: json[columnHomePhoneNumber]);
  }

  static User fromExternalJson(
      final Map<String, dynamic> json, final String cpf) {
    return User(
        id: json["id"] as int,
        documentNumber: cpf,
        firstName: json["username"] as String,
        lastName: json["name"] as String,
        email: json["email"] as String,
        photo: json["profileUrl"],
        cellPhoneNumber: json["phone"] as String,
        workPhoneNumber: json["phoneWork"],
        homePhoneNumber: json["phoneHome"]);
  }

  static User createNewUser(final User user, final int newId) {
    return User(
        id: newId,
        documentNumber: user.documentNumber,
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        photo: user.photo,
        cellPhoneNumber: user.cellPhoneNumber,
        workPhoneNumber: user.workPhoneNumber,
        homePhoneNumber: user.homePhoneNumber);
  }

  static String createTableQuery() {
    return "CREATE TABLE $tableName (" +
        "$columnId INTEGER PRIMARY KEY," +
        " $columnFirstName TEXT," +
        " $columnLastName TEXT," +
        " $columnDocumentNumber TEXT," +
        " $columnEmail TEXT," +
        " $columnPhoto TEXT," +
        " $columnCellPhoneNumber TEXT," +
        " $columnWorkPhoneNumber TEXT," +
        " $columnHomePhoneNumber TEXT" +
        ")";
  }
}
