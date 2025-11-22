# 🍺 Beer App

![iOS](https://img.shields.io/badge/iOS-18.0%2B-blue)
![Swift](https://img.shields.io/badge/Swift-5.9-orange)
![Architecture](https://img.shields.io/badge/Architecture-VIP-purple)
![License](https://img.shields.io/badge/License-MIT-green)

Aplicação nativa iOS desenvolvida como desafio técnico. O projeto consome a **openbrewerydb** para listar, filtrar e exibir detalhes de cervejas, permitindo também o gerenciamento de favoritos offline.

---

## ✨ Funcionalidades

* **Listagem Infinita:** Paginação automática (Infinite Scroll).
* **Busca:** Filtro de cervejas por nome com *Debounce*.
* **Favoritos Offline:** Persistência local utilizando **Core Data**.
* **Tratamento de Erros:** Feedbacks visuais amigáveis para falhas de conexão e listas vazias.

---

## 🛠 Tecnologias e Arquitetura

O projeto foi construído sem o uso de bibliotecas de terceiros para as dependências principais, demonstrando domínio da plataforma nativa.

* **Arquitetura:** VIP (View-Interactor-Presenter) + Coordinator Pattern.
* **UI:** UIKit Programático (ViewCode) com Auto Layout.
* **Gerenciamento de Dependência:** Swift Package Manager (SPM).
* **Modularização:** Módulo isolado `ThemeKit` para Design System (Cores e Fontes).
* **Persistência:** Core Data com stack manual.
* **Networking:** URLSession nativo com camada de abstração.
* **Testes:** XCTest (Unit Tests para Interactors, Presenters e Workers).

### Estrutura de Pastas
O projeto segue uma estrutura semântica clara para facilitar a navegação e manutenção:

```bash
Beer
├── Application    # AppDelegates, Coordinators e Configurações
├── Common         # Extensions e Utilitários (Debouncer, ImageProvider)
├── Domain         # Modelos de Domínio e Contratos
├── Infrastructure # Networking e Persistence (Core Data Stack)
├── Scenes         # Telas organizadas em VIP (View, Interactor, Presenter
```

## 🚀 Como Rodar

1. Clone o repositório:
   ```bash
   git clone [https://github.com/milenaalcantara/BeerTT.git](https://github.com/milenaalcantara/BeerTT.git)
   ```
2. Abra o arquivo Beer.xcodeproj no Xcode.

3. Aguarde o carregamento do pacote SPM local (ThemeKit).

4. Selecione um simulador (iOS 18+) e execute (Cmd + R).
