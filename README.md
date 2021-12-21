# Test Commit2

# iOS Template
SwiftUI+Combineのテンプレートプロジェクト

## 環境
- Xcode 14
- Swift 5.3

### 依存ツールの導入
#### Homebrew
SwiftLintとLicense-plistの管理にHomebrewを利用しています。環境構築の前にHomebrewを利用できるようにしてください。

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### プロジェクト構築
プロジェクトの生成とライブラリのダウンロードをする

```
$ make bootstrap 
```

## Sample
ソースコード上のSampleがprefixのコードが該当します。
設計を元に作ってみたSampleになります。
AppCoordinator.swiftのCoordinatorは変更して、確認。

### Sample
あらゆるInputを埋め込んでいます。

### Sample Github
GitHub APIを叩いて、ユーザー一覧を表示する

![test](https://user-images.githubusercontent.com/47435749/129501182-ad74fd61-5d5e-492e-b460-9973e4f4e6cf.gif)

## 設計
SwiftUI + MVVM + Clean Architectureで作成されています。以下詳細。

- Datasource
  - APIs
    - リクエスト、レスポンスの構造体
    - 通信基盤はMoya(Alamofire)
    - Combine
  - Entities
    - サーバーないしはローカルDBなど扱う構造体
    - Decodable(サーバー) or Realm(ローカルDB)
  - Gateways
    - サーバーないしはローカルDBなど、アクセスクラス
    - Combine
- Repositories
    - Domain LayerとのI/F
    - Datasource層(Gateway)から受け取ったEntityをUseCaseへ渡す
    - Combine
- Domains
  - UseCases
    - 各種ユースケース
    - 必要に応じてRepositoryへデータ取得を要求
    - 必要に応じてTranslatorでデータをレイヤー加工
  - Translators
    - Data Layerで扱うデータ形式であるEntityを，Presentation Layerで扱うデータ形式であるDomain Modelへと(相互)変換する
  - Models
    - Domain Model構造体
- Application
  - Presenters
    - ViewModel
      - Domain LayerとのI/F
      - 各種UIイベント等に対し，binding
      - 必要に応じてUseCaseを実行する
    - Coordinator
      - DI
    - Presenter
      - 遷移や画面間の管理
      - 画面上のイベントDelegate制御
    - View
      - SwiftUI