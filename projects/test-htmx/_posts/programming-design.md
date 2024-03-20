# プログラミング設計

みなさんこんにちは、かじりです。プログラミングの設計のことを勉強しようと思って色々書き込んでいます。とりあえず公開しています。

https://github.com/rmanguinho/clean-react
https://github.com/rmanguinho/clean-ts-api
Java言語で学ぶデザインパターン入門

- デザインパターンを勉強すれば、実装速度が上がるのではないか？という期待を持って勉強しようとする。
- ただ、その度に思うのは、何か実装して、その時に発生した課題を解決していけばデザインパターンはいらないのでは？という疑問
- その時、その時にできるだけのことを。できるだけのことをやっていれば実装する力、programming designの力は向上していくと思う

## 原則
### Single Responsibility Principle (SRP)
### Open Closed Principle (OCP)
### Liskov Substitution Principle (LSP)
### Interface Segregation Principle (ISP)
### Dependency Inversion Principle (DIP)
### Separation of Concerns (SOC)
### Don't Repeat Yourself (DRY)
### You Aren't Gonna Need It (YAGNI)
### Keep It Simple, Silly (KISS)
### Composition Over Inheritance
### Small Commits

## デザインパターン
### Factory
2022/01/22
これReactのhooksにどうやって役立てるん？

### Adapter
#### 2022/01/22
##### https://refactoring.guru/design-patterns/adapter/typescript/example
- 間に何かを噛ませる。
- 利用 | adapter | 実態
- 実態の変更をadapterに吸収させることによって、利用側の負担を減らす
##### Java言語で学ぶデザインパターン入門
- 実態をadapterから呼び出し利用するパターンがあり得ると思った

### Composite
### Decorator
### Dependency Injection
### Composition Root
### Builder
### Proxy
### Iterator
#### 2022/01/22
##### Java言語で学ぶデザインパターン入門

- ページネーションを実行するクラスを作成するときに使えそう。
- next, previrousを管理
- hasNextでnextページを持っているかを管理。falseならdisabled。
- hasPrevirousでprevirousページを持っているかを管理。falseならdisabled。

## Methodologies and Designs
### TDD
### Clean Architecture
### DDD
### Reactive Programming
### Responsive Layout
### Conventional Commits
### GitFlow
### Modular Design
### Dependency Diagrams
### Use Cases
### Continuous Integration
### Continuous Delivery
### Continuous Deployment

## Libraries and Tools
### Typescript
### React
### Recoil
### React Testing Library
### React Router DOM
### Cypress
### Jest
### Axios
### Git
### Webpack
### SASS + Animations
### NPM
### Travis CI
### Faker
### Coveralls
### Husky
### Lint Staged
### Eslint
### Standard Javascript Style
### React Flip Move

## React Features
### Functional Components
### UseState
### UseContext
### UseEffect
### UseHistory
### UseRef
### UseParams
### Custom Hooks
### UseRecoilState
### UseResetRecoilState
### UseRecoilValue
### UseRecoilSetState
### Atom
### Router
### Memo

## Git Features
### Alias
### Custom Logging
### Branch
### Reset
### Amend
### Tag
### Tag Annotated
### Stash
### Rebase
### Merge
### Add
### Commit
### Push
### Pull
### Shortlog
### Status

## Typescript Features 
### Advanced POO
### Interface
### Type Alias
### Namespace
### Module
### Utility Types
### Path Modularization
### Build
### Deploy
### Generics

##  Testes Features
### Unit Tests
### Integration Tests
### e2e tests
### Test Coverage
### Test Doubles
### Mocks
### Stubs
### Spies
### Fakes
### Dummies

https://msakamaki.github.io/clean-code-typescript/
https://www.kabuku.co.jp/developers/good-bye-typescript-enum