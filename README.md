#◆README

####以下、課題で使用する3テーブルです。
最終的にはuser、task、labelの3つを使用します。

| *users* |  |
|:--|:--|
| **id** | string |
| **name** | string |
| **email** | string |
| **password** | string |

| *tasks* |  |
|:--|:--|
| **user_id** | string |
| **title** | string |
| **content** | text |
| **deadline** | date |
| **priority** | string |
| **status** | string |

| *labels* |  |
|:--|:--|
| **user_id** | string |
| **title** | string |
| **content** | text |



## herokuデプロイのやり方

### 1:カレントブランチのファイルをステージング領域へ

### 2:作業内容のメッセージを記載してコミット

### 3:herokuにログイン

### 4:heroku上にアプリを作成

### 5:herokuにデプロイする

### 6:herokuのデータベース実行

### 7:urlを確認し、アクセス

## heroku自動デプロイ設定手順

### 1:ダッシュボードから対象アプリを開く  

### 2:メニューの中のdeployへ進む

### 3:DeploymentMethodでGithubへ変更

### 4:App connected to Githubの項目で対象のリポジトリを選択し、masterブランチを選択

### 5:Automatic Deployをenableへ変更
