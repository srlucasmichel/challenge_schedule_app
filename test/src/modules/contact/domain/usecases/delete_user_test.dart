import 'package:challenge_schedule_app/src/modules/contact/domain/usecases/delete_user.dart';
import 'package:challenge_schedule_app/src/modules/contact/domain/repositories/user_repository.dart';
import 'package:challenge_schedule_app/src/modules/contact/domain/errors/errors.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class UserRepositoryMock extends Mock implements IUserRepository {}

void main() {
  final repository = UserRepositoryMock();
  final usecase = DeleteUser(repository);

  test('deve retornar o id do contato apagado', () async {
    when(() => repository.deleteUser(userId: 1))
        .thenAnswer((_) async => right(0));

    final result = await usecase(userId: 1);

    expect(result.fold(id, id), isA<int>());
  });

  test('deve retornar um ArgumentsException se o id for inválido', () async {
    final result = await usecase(userId: 0);

    expect(result.fold(id, id), isA<ArgumentsException>());
  });
}
