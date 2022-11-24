class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String documentNumber;
  final String? email;
  final String? photo;
  final String? celPhoneNumber;
  final String? workPhoneNumber;
  final String? homePhoneNumber;

  User(
      {required this.id,
      this.firstName,
      this.lastName,
      required this.documentNumber,
      this.email,
      this.photo,
      this.celPhoneNumber,
      this.workPhoneNumber,
      this.homePhoneNumber});

  @override
  String toString() {
    return 'User{id: $id, firstName: $firstName, lastName: $lastName, documentNumber: $documentNumber, email: $email, photo: $photo, celPhoneNumber: $celPhoneNumber, workPhoneNumber: $workPhoneNumber, homePhoneNumber: $homePhoneNumber}';
  }
}
