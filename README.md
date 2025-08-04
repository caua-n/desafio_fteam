# Rick and Morty Explorer

Este projeto é um aplicativo Flutter que consome a API oficial do Rick and Morty ([https://rickandmortyapi.com/api](https://rickandmortyapi.com/api)) para exibir informações de personagens, episódios e localizações do universo da série.

## 🚀 Funcionalidades

* **Lista de Personagens**: exibição em scroll vertical com carregamento infinito (pagination).
* **Listas Horizontais**: exibição de episódios e localizações em listas horizontais acima da lista de personagens, também com paginação.
* **Detalhes de Personagem**: ao tocar em um personagem, navegar para tela de detalhes com informações como nome, espécie, status, gênero e última localização.
* **Navegação**: rotas estruturadas com go\_router.
* **Gerenciamento de Estado**: usando Provider para viewmodels (ChangeNotifiers).
* **Injeção de Dependência**: usando get\_it para registrar e obter instâncias de datasources, repositórios e use cases.
* **Carregamento de Configurações**: variáveis de ambiente via flutter\_dotenv.

## 🛠 Tecnologias e Dependências

* **Linguagem**: Dart
* **Framework**: Flutter

Dependências principais:

```yaml
go_router: ^16.0.0
dio: ^5.8.0+1
flutter_dotenv: ^5.2.1
get_it: ^8.2.0
provider: ^6.1.5
```

## 🏗 Arquitetura do Projeto

```
lib/
├── main.dart                # Entry point do app
├── core/
│   ├── di/                  # Configuração de injeção de dependência (get_it)
│   ├── network/             # Cliente HTTP (Dio)
│   └── routes/              # Definição das rotas (go_router)
├── data/
│   ├── datasources/         # RamRemoteDatasource (implementação do acesso à API)
│   ├── models/              # Classes de modelo (serialização JSON)
│   └── repositories/        # RamRepositoryImpl (contrato de dados)
├── domain/
│   ├── entities/            # Entidades do domínio (Character, Episode, Location)
│   ├── repositories/        # Interfaces de repositório
│   └── usecases/            # Casos de uso (GetCharacters, GetEpisodes, etc.)
├── presentation/
│   ├── views/               # Telas e widgets
│   └── viewmodels/          # ChangeNotifier para cada feature

```
## Demonstração


https://github.com/user-attachments/assets/a76b47f3-f9ec-4b49-82a1-4deba46f3469




## 💻 Instalação e Execução

1. Clone este repositório:

   ```bash
   ```

git clone [https://github.com/caua-n/rick-and-morty-explorer.git](https://github.com/seu-usuario/rick-and-morty-explorer.git)
cd rick-and-morty-explorer

````

2. Instale as dependências:
   ```bash
flutter pub get
````

API\_BASE\_URL=[https://rickandmortyapi.com/api](https://rickandmortyapi.com/api)

````

3. Execute o app em um dispositivo ou emulador:
   ```bash
flutter run
````

## 🌟 Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues e pull requests.

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

Desenvolvido por Cauã Leite Guimarães. Qualquer dúvida ou sugestão, abra uma issue ou entre em contato.
