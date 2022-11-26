# Contatos

<p width="100%">
  <img src="https://img.shields.io/static/v1?label=Flutter&message=v3.0.5&color=02569B&style=flat&logo=flutter"/>

  <img src="http://img.shields.io/static/v1?label=Status&message=Em%20desenvolvimento&color=GREEN&style=flat&logo=Codeforces&logoColor=white"/>
<p>

Um aplicativo para gerenciar contatos

## :dart: Objetivo
Faça um aplicativo em Flutter de agenda eletrônica. Deverá fazer as ações básicas: criar, exibir, editar e deletar.

Dados do contato a serem salvos na agenda:
- Nome, sobrenome, CPF (obrigatório), email;
- Foto (utilizar a camera do celular);
- Telefones (múltiplos telefones são permitidos) e seus respectivos tipos (trabalho, celular, residencial);

Requisitos:
- utilizar banco de dados local;
- os campos de CPF e telefone devem possuir máscaras;
- o campo de CPF deve ser validado;
- ao tocar no número do telefone, no modo de exibição do contato, uma ligação telefonica deve ser iniciada;
- o endpoint https://jsonplaceholder.typicode.com/users contém 10 usuários. Na primeira inicialização do app, esses usuários deverão ser inseridos no banco. Como o CPF é obrigatório, utilize o endpoint: curl -X POST "https://www.4devs.com.br/ferramentas_online.php" -H "Content-Type: application/x-www-form-urlencoded" -d "acao=gerar_cpf"

## :iphone: Telas desenvolvidas
<p width="100%">
  <img src="https://user-images.githubusercontent.com/80552835/204004509-a25bb268-54d0-423a-aeaa-f378621f2084.jpg" height="350" width="160">
  <img src="https://user-images.githubusercontent.com/80552835/204004497-70659b2f-6e52-4820-9b9f-9f46bc3931d7.jpg" height="350" width="160">
  <img src="https://user-images.githubusercontent.com/80552835/204004518-7e8aadb8-b1ff-407d-8c33-1880901fe706.jpg" height="350" width="160">
</p>

## :blue_book: Técnicas e tecnologias utilizadas
- ``Clean architecture``
- ``Injeção de dependência e gestão de rotas com Modular``
- ``Retorno de exceções com either (fpdart)``
- ``Componentização de widgets``
- ``Testes unitários com mocktail``

## :cd: Inicialização

```bash
# Clone este repositório
$ git clone https://github.com/srlucasmichel/challenge_schedule_app.git

# Acesse a pasta do projeto no terminal/cmd
$ cd challenge_schedule_app

# Instale as dependências
$ flutter pub get

# Execute o aplicativo
$ flutter run
```

## :round_pushpin: Status do App
<p align="left">🚧 Em aprimoramento...  🚧</p>

## :rocket: Implementações futuras
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
- [ ] Custom ordenation
- [ ] Link to WhatsApp chat (when available for the number)
- [ ] Dark mode

## :paperclip: Autor

<img style="border-radius: 50%;" src="https://avatars.githubusercontent.com/u/80552835?v=4" width="115px;"/>
Feito com :heart: por Lucas Michel :wave: Entre em contato!
<br /><br />
<a href="https://www.linkedin.com/in/srlucasmichel/"><img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white"></a>
<a href="https://www.behance.net/srlucasmichel/"><img src="https://img.shields.io/badge/-Behance-blue?style=for-the-badge&logo=behance&logoColor=white"></a>
<a href="mailto:lucasmichel_tcx@hotmail.com"><img src="https://img.shields.io/badge/Microsoft_Outlook-0078D4?style=for-the-badge&logo=microsoft-outlook&logoColor=white"></a>
