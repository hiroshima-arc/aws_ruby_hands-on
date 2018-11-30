# AWS SAM Ruby Hands-on

# 目的

AWS サーバーレスアプリケーションモデル (AWS SAM) ハンズオン(Ruby)

# 前提

| ソフトウェア   | バージョン | 備考 |
| :------------- | :--------- | :--- |
| ruby           | 2.5.3      |      |
| aws-sam-cli    | 0.8.0      |      |
| docker         | 17.06.2    |      |
| docker-compose | 1.21.0     |      |
| vagrant        | 2.0.3      |      |

# 構成

1. [構築](#構築)
1. [配置](#配置)
1. [運用](#運用)
1. [開発](#開発)

## 構築

### 開発用仮想マシンの起動・プロビジョニング

- Docker のインストール
- docker-compose のインストール
- pip のインストール

```bash
vagrant up
vagrant ssh
```

### 開発パッケージのインストール

- aws-sam-cli のインストール
- ruby のインストール

```bash
pip install --user aws-sam-cli==0.8.0
sudo yum install -y openssl-devel readline-devel
export RUBY_VER=2.5.3
git clone https://github.com/sstephenson/rbenv $HOME/.rbenv
git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
sudo $HOME/.rbenv/plugins/ruby-build/install.sh
echo 'export PATH="/$HOME/.rbenv/bin:$PATH"' >> $HOME/.bash_profile
echo 'eval "$(rbenv init -)"' >> $HOME/.bash_profile
source  $HOME/.bash_profile
rbenv install $RUBY_VER
rbenv global $RUBY_VER
gem install bundler rake
```

### ドキュメント環境のセットアップ

```bash
cd /vagrant
curl -s api.sdkman.io | bash
source "/home/vagrant/.sdkman/bin/sdkman-init.sh"
sdk list maven
sdk use maven 3.5.4
sdk list java
sdk use java 8.0.192-zulu
sdk list gradle
sdk use gradle 4.9
```

ドキュメントのセットアップ

```
cd /vagrant/
touch build.gradle
```

`build.gradle`を作成して以下のコマンドを実行

```
gradle build
```

ドキュメントの生成

```bash
gradle asciidoctor
gradle livereload
```

[http://192.168.33.10:35729/](http://192.168.33.10:35729/)に接続して確認する

### AWS 認証のセットアップ

```bash
cd /vagrant/sam-app
cat <<EOF > .env
#!/usr/bin/env bash
export AWS_ACCESS_KEY_ID=xxxxxxxxxxxx
export AWS_SECRET_ACCESS_KEY=xxxxxxxxxx
export AWS_DEFAULT_REGION=us-east-1
EOF
```

アクセスキーを設定したら以下の操作をする

```bash
source .env
aws ec2 describe-regions
```

### パイプラインのセットアップ

```
cd /vagrant/ops/aws/code_pipline
./create_stack.sh
```

### git-secrets のセットアップ

インストール

```bash
cd /home/vagrant
git clone https://github.com/awslabs/git-secrets.git
cd git-secrets/
sudo make install
cd ..
rm -rf git-secrets/
```

既存プロジェクトにフックを設定

```bash
cd /vagrant
git secrets --install
```

拒否条件を設定

```bash
git secrets --register-aws --global
```

レポジトリをスキャンする

```bash
cd /vagrant
git secrets --scan -r
```

許可ルールを追加する

```bash
git config --add secrets.allowed docs/spec/hello_world.html
git config --add secrets.allowed sam-app/tests/hello_world/event_file.json
git config --add secrets.allowed sam-app/tests/unit/test_handler.rb
```

**[⬆ back to top](#構成)**

## 配置

### アプリケーションのデプロイ

デプロイ用の S3 バケットを用意する

```bash
aws s3 mb s3://ruby-hands-on
```

デプロイを実行する

```bash
cd /vagrant/dev/sam-app
sam validate
sam package --template-file template.yaml --s3-bucket ruby-hands-on --output-template-file packaged.yaml
sam deploy --template-file packaged.yaml --stack-name ruby-hands-on-development --capabilities CAPABILITY_IAM
```

デプロイが成功したら動作を確認する

```bash
aws cloudformation describe-stacks --stack-name ruby-hands-on-development --query 'Stacks[].Outputs[1]'
```

**[⬆ back to top](#構成)**

## 運用

### スタックの削除

```bash
aws cloudformation delete-stack --stack-name ruby-handson-development
aws cloudformation delete-stack --stack-name ruby-handson-production
aws cloudformation delete-stack --stack-name ruby-handson-pipline
```

### S ３バケットの削除

```bash
aws s3 rb s3://ruby-handson --force
```

### タスク

```bash
rake -T
```

**[⬆ back to top](#構成)**

## 開発

### アプリケーションの作成

```bash
mkdir /vagrant/dev
cd /vagrant/dev
sam init --runtime ruby2.5
cd sam-app
```

### ローカルでテスト

```bash
cd /vagrant
bundle init
```

`Gemfile`

```
group :development, :test do
  gem 'mocha'
end
```

```bash
cd /vagrant/
bundle install
ruby sam-app/tests/unit/test_handler.rb
cd /vagrant/dev/sam-app
bundle install
bundle install --deployment --path hello_world/vendor/bundle
mkdir tests/hello_world
sam local generate-event apigateway aws-proxy > tests/hello_world/event_file.json
sam local invoke HelloWorldFunction --event tests/hello_world/event_file.json
sam local start-api --host 0.0.0.0
```

[http://192.168.33.10:3000/hello](http://192.168.33.10:3000/hello)に接続して確認する

### コードカバレッジのセットアップ

`Gemfile`

```
group :development, :test do
  gem 'mocha'
  gem "simplecov"
end
```

`/vagrant/dev/samp-app/tests/unit/test_handler`

```
・・・
require 'simplecov'
SimpleCov.start
・・・
```

```bash
cd /vagrant
bundle install
ruby dev/sam-app/tests/unit/test_handler.rb
```

### コードチェッカのセットアップ

`Gemfile`

```
group :development, :test do
  gem 'mocha'
  gem "simplecov"
  gem 'rubocop', require: false
end
```

```bash
cd /vagrant
bundle install
rubocop -a dev/sam-app/hello_world/app.rb
rubocop -a dev/sam-app/tests/unit/test_handler.rb
```

**[⬆ back to top](#構成)**

# 参照

- [SAM CLI (Beta)](https://github.com/awslabs/aws-sam-cli)
- [Groom your app’s Ruby environment with rbenv.](https://github.com/rbenv/rbenv)
- [SimpleCov](https://github.com/colszowka/simplecov)
- [RuboCop](https://github.com/rubocop-hq/rubocop)
