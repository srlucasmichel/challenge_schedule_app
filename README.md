# App de Contatos

<img src="https://img.shields.io/static/v1?label=Flutter&message=3.0.5&color=45d1fd&style=flat&logo=flutter"/>

## Objetivo
Faça um aplicativo em Flutter de agenda eletrônica. Deverá fazer as ações básicas: criar, exibir, editar e deletar.

Dados do contato a serem salvos na agenda:
- Nome;
- Sobrenome;
- CPF (obrigatório);
- Email;
- Foto (utilizar a camera do celular);
- Telefones (múltiplos telefones são permitidos) e seus respectivos tipos (trabalho, celular, residencial);

Requisitos:
- utilizar banco de dados local;
- os campos de CPF e telefone devem possuir máscaras;
- o campo de CPF deve ser validado;
- ao tocar no número do telefone, no modo de exibição do contato, uma ligação telefonica deve ser iniciada;
- o endpoint https://jsonplaceholder.typicode.com/users contém 10 usuários. Na primeira inicialização do app, esses usuários deverão ser inseridos no banco. Como o CPF é obrigatório, utilize o endpoint https://www.4devs.com.br/ferramentas_online.php com parâmetro acao=gerar_cpf para utilizar esse CPF, abaixo segue o curl:

curl -X POST "https://www.4devs.com.br/ferramentas_online.php" -H "Content-Type: application/x-www-form-urlencoded" -d "acao=gerar_cpf"

## Telas desenvolvidas
<p width="100%">
  <img src="https://user-images.githubusercontent.com/80552835/204004509-a25bb268-54d0-423a-aeaa-f378621f2084.jpg" height="350" width="160">
  <img src="https://user-images.githubusercontent.com/80552835/204004497-70659b2f-6e52-4820-9b9f-9f46bc3931d7.jpg" height="350" width="160">
  <img src="https://user-images.githubusercontent.com/80552835/204004518-7e8aadb8-b1ff-407d-8c33-1880901fe706.jpg" height="350" width="160">
</p>

## Status do App
<p align="left">🚧 🚀 Em aprimoramento...  🚧</p>

<h4 align="left">Testes</h4>

- [x] Usecase
- [ ] Repository
- [ ] Integration

<h4 align="left">Próximas Features</h4>

- [ ] Select image from gallery
- [ ] Add contact to favorites
- [ ] Search contact
- [ ] Share contact
- [ ] Add contact to groups
- [ ] New user informations (nickname, address, notes, website)
- [ ] Link to WhatsApp chat (when available for the number)

## Autor

[<img src="https://avatars.githubusercontent.com/u/80552835?v=4" width="115"><br><sub>Lucas Michel</sub>](https://github.com/srlucasmichel)
