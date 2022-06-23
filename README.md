# Password Manager

Password Manager foi desenvolvido com Flutter que é uma tecnologia Multiplataforma, podendo
assim ser rodado tanto no Android como no IOS, fazendo uso da linguagem de programação Dart.

Versões: 
Flutter - 3.0.0 e
Dart - 2.17.0

## Equipe desenvolvedora

```
Gabriel Doratiotto Menoi - Dessenvolvedor Mobile
Gabriel Soares Mielo - PO e UX/UI 
Tiago Santos - UX/UI e testes de software

```

## Link do protótipo

```
https://www.figma.com/file/h3eSYzVsJRb04acbqjOMzf/SENHA
```

## Inicializando

**Passo 1:**

Baixe ou clone esse repositório usando o link abaixo:  

```
https://github.com/gabrielmenoi0/cofre-de-senha/tree/dev
```

**Passo 2:**

Na raiz do projeto execute o seguinte comando para pegar todas as dependências:

```
flutter pub get
```

**Passo 3:**

Para rodar o projeto execute o comando:

```
flutter run lib/main.dart
```

### Estrutura de arquivos

Essa é a estrutura de arquivos do projeto, maioria é gerada pelo próprio flutter.

```
flutter-app/
|- android/
|- assets/
|- build/
|- ios/
|- lib/
|- test/
```

Essa é a estrutura de pastas usada pelo projeto.

```
lib/
|- data/
|- models/
|- src/
|- utils/
|- main.dart
```

Agora, o que cada um dessas pastas e arquivos fazem:

```
1- data - Contém os arquivos de com a arquitetura do banco de dados(tabelas e funções de (INSERT, DELETE e ALTER).
2- models - Contém classes de models de Json utilizados no aplicativo.
3- src - Contém os arquivos de interface do sistema.
4- utils — Contém utilitários e métodos comuns para serem utilizados.
5- main.dart - Esse é o inicializador do projeto.
```

