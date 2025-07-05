Aluno: Josiel Jordão
Email: josiel-junior2@hotmail.com

# Notes

Este é um projeto desenvolvido como parte do curso de Ruby on Rails. O objetivo é aplicar os conceitos aprendidos em aula para criar uma aplicação web funcional, bem estruturada e com boas práticas de desenvolvimento.

## 📦 Tecnologias Utilizadas

- [Ruby](https://www.ruby-lang.org/pt/) 3.4.2
- [Ruby on Rails](https://rubyonrails.org/) 8.0.2
- [SQLite](https://www.sqlite.org/)


## 🚀 Como rodar o projeto localmente

```bash
# Clone o repositório
git clone https://github.com/josieljunior/notes.git
cd notes

# abra o VSCode
# Inicie o projeto dentro do dev container

# Inicie o servidor
bin/dev

# Acessar http://localhost:3000/
```

## ✅ Funcionalidades implementadas

- CRUD de memos/notas com título e conteúdo
- Sistema de tags para organização das notas
- Sistema de busca por palavra-chave nas notas
- Funcionalidade de arquivar/desarquivar memos
- Filtros por tags e status (ativo/arquivado)
- Paginação de resultados

## 🧠 Conceitos aplicados

Abaixo estão os conceitos aprendidos em aula e aplicados neste projeto, junto com a justificativa de sua utilização:

### 1. **Service Objects**

Utilizados para encapsular regras de negócio complexas fora dos models e controllers, mantendo o código mais limpo e testável. Podemos observar no projeto as classes `MemoCreator` e `MemoSearch` que centralizam a lógica de criação e busca de memos, evitando Fat Controllers e promovendo reutilização de código.

### 2. **Active Record Scopes**

Implementados no model `Memo` para criar consultas reutilizáveis e expressivas como `active`, `archived`, `tagged_with` e `search_by_keyword`. Essa abordagem mantém a lógica de query organizada no model e facilita a composição de filtros complexos.

### 3. **Padrão Observer**

Aplicado através da classe `MemoObserver` que monitora eventos das Notas, especificamente o `after_create` para registrar logs. Isso mantém o isolamento entre a model e a lógica de logging.

### 4. **Concerns**

O módulo `Pagination` encapsula a funcionalidade de paginação de forma reutilizável, permitindo que qualquer service possa incluí-lo. Isso promove DRY (Don't Repeat Yourself) e organização do código.

### 5. **Performance de Queries (Evitando N+1)**

Implementado o uso de `includes(:tags)` no controller para carregar as associações de forma eficiente, evitando o problema N+1. Para detectar e monitorar esses problemas de performance, utilizei a gem `bullet` que identifica automaticamente queries N+1 no ambiente de desenvolvimento.

### 6. **Result Object Pattern**

A classe `Result` padroniza o retorno de operações que podem falhar, encapsulando tanto o sucesso quanto os erros de forma consistente. Isso melhora o tratamento de erros nos controllers.

### 7. **Evitando Dependência Excessiva de Gems (Anti-pattern)**

Ao invés de usar gems para paginação, implementei uma solução customizada com `PaginationService` e `Pagination`. Essa decisão evita dependências desnecessárias e mantém controle total sobre a funcionalidade. A implementação própria oferece exatamente o que preciso sem recursos extras não utilizados.

### 8. **Active Record Validations**

Implementadas validações nos models `Memo` e `Tag` para garantir integridade dos dados, como `presence: true` para campos obrigatórios e `uniqueness` para evitar tags duplicadas. Isso assegura que apenas dados válidos sejam persistidos no banco.

### 9. **Rotas Customizadas com Member Actions**

Configuradas rotas customizadas para as ações `archive` e `unarchive` usando `member do`, permitindo operações específicas em recursos individuais. Isso mantém as rotas organizadas e RESTful.
