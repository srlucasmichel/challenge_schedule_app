import 'package:challenge_schedule_app/src/modules/contact/domain/entities/user.dart';
import 'package:challenge_schedule_app/src/modules/contact/domain/usecases/insert_user.dart';
import 'package:challenge_schedule_app/src/modules/contact/domain/repositories/user_repository.dart';
import 'package:challenge_schedule_app/src/modules/contact/domain/errors/errors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class UserRepositoryMock extends Mock implements IUserRepository {}

void main() {
  final repository = UserRepositoryMock();
  final usecase = InsertUser(repository);

  test('deve retornar o id do contato inserido', () async {
    final user = User(documentNumber: '89034044084', firstName: 'João');
    when(() => repository.insertUser(user)).thenAnswer((_) async => right(0));

    final result = await usecase(user);

    expect(result.fold(id, id), isA<int>());
  });

  test('deve retornar um ArgumentsException se o cpf for vazio', () async {
    final result = await usecase(User(documentNumber: '', firstName: 'João'));

    expect(result.fold(id, id), isA<ArgumentsException>());
  });

  test('deve retornar um ArgumentsException se o cpf for inválido', () async {
    final result =
        await usecase(User(documentNumber: '89034044088', firstName: 'João'));

    expect(result.fold(id, id), isA<ArgumentsException>());
  });

  test('deve retornar um ArgumentsException se o firstName for nulo', () async {
    final result = await usecase(User(documentNumber: '89034044084'));

    expect(result.fold(id, id), isA<ArgumentsException>());
  });

  test('deve retornar um ArgumentsException se o firstName for vazio',
      () async {
    final result =
        await usecase(User(documentNumber: '89034044084', firstName: ''));

    expect(result.fold(id, id), isA<ArgumentsException>());
  });
}
