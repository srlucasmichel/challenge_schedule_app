import 'package:challenge_schedule_app/src/modules/contact/domain/entities/user.dart';
import 'package:challenge_schedule_app/src/modules/contact/domain/repositories/user_repository.dart';
import 'package:challenge_schedule_app/src/modules/contact/domain/errors/errors.dart';
import 'package:challenge_schedule_app/src/modules/contact/domain/usecases/update_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class UserRepositoryMock extends Mock implements IUserRepository {}

void main() {
  final repository = UserRepositoryMock();
  final usecase = UpdateUser(repository);

  test('deve retornar o id do contato alterado', () async {
    final user = User(id: 1, documentNumber: '89034044084', firstName: 'João');
    when(() => repository.updateUser(user)).thenAnswer((_) async => right(0));

    final result = await usecase(user);

    expect(result.fold(id, id), isA<int>());
  });

  test('deve retornar um ArgumentsException se o id for nulo', () async {
    final result =
        await usecase(User(documentNumber: '89034044084', firstName: 'João'));

    expect(result.fold(id, id), isA<ArgumentsException>());
  });

  test('deve retornar um ArgumentsException se o id for inválido', () async {
    final result = await usecase(
        User(id: 0, documentNumber: '89034044084', firstName: 'João'));

    expect(result.fold(id, id), isA<ArgumentsException>());
  });

  test('deve retornar um ArgumentsException se o cpf for vazio', () async {
    final result =
        await usecase(User(id: 1, documentNumber: '', firstName: 'João'));

    expect(result.fold(id, id), isA<ArgumentsException>());
  });

  test('deve retornar um ArgumentsException se o cpf for inválido', () async {
    final result = await usecase(
        User(id: 1, documentNumber: '89034044080', firstName: 'João'));

    expect(result.fold(id, id), isA<ArgumentsException>());
  });

  test('deve retornar um ArgumentsException se o firstName for nulo', () async {
    final result = await usecase(User(id: 1, documentNumber: '89034044084'));

    expect(result.fold(id, id), isA<ArgumentsException>());
  });

  test('deve retornar um ArgumentsException se o firstName for vazio',
      () async {
    final result = await usecase(
        User(id: 1, documentNumber: '89034044084', firstName: ''));

    expect(result.fold(id, id), isA<ArgumentsException>());
  });
}
