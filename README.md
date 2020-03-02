#◆README

####以下、課題で使用する3テーブルです。
user、task、labelの3つを使用します。

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
| **deadline** | string |
| **priority** | string |

| *labels* |  |
|:--|:--|
| **user_id** | string |
| **title** | string |
| **content** | text |



## herokuデプロイのやり方

### カレントブランチのファイルをステージング領域へ
1.git add -A

### 作業内容のメッセージを記載してコミット
2.git commit -m "〇〇"

### herokuにログイン
3.heroku login
※パスワード入力する

### heroku上にアプリを作成
4.heroku create

### herokuにデプロイする
5.git push heroku master

### herokuのデータベース実行
6.heroku run rails db:migrate

### urlを確認し、アクセス
7.heroku open

### heroku自動デプロイ設定手順
8.ダッシュボードから対象アプリを開く  
9.メニューの中のdeployへ  
10.DeploymentMethodでGithubへ変更  
11.App connected to Githubの項目で対象のリポジトリを選択し、masterブランチを選択  
12.Automatic Deployをenableへ変更
