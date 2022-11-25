import 'package:challenge_schedule_app/src/modules/contact/domain/entities/user.dart';
import 'package:challenge_schedule_app/src/modules/contact/domain/repositories/user_repository.dart';
import 'package:challenge_schedule_app/src/modules/contact/domain/errors/errors.dart';
import 'package:challenge_schedule_app/src/modules/contact/domain/usecases/insert_users.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class UserRepositoryMock extends Mock implements IUserRepository {}

void main() {
  final repository = UserRepositoryMock();
  final usecase = InsertUsers(repository);

  test('deve retornar a quantidade de contatos inseridos', () async {
    final usersMock = [
      User(documentNumber: '89034044084'),
      User(documentNumber: '89034044084'),
      User(documentNumber: '89034044084'),
    ];
    when(() => repository.insertUsers(usersMock))
        .thenAnswer((_) async => right(0));

    final result = await usecase(usersMock);

    expect(result.fold(id, id), isA<int>());
  });
  test('deve retornar um ArgumentsException se a lista for vazia', () async {
    final result = await usecase([]);

    expect(result.fold(id, id), isA<ArgumentsException>());
  });
}
