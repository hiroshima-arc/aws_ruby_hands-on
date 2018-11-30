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

**[⬆ back to top](#構成)**

## 配置

**[⬆ back to top](#構成)**

## 運用

**[⬆ back to top](#構成)**

## 開発

**[⬆ back to top](#構成)**

# 参照

- [SAM CLI (Beta)](https://github.com/awslabs/aws-sam-cli)
- [Groom your app’s Ruby environment with rbenv.](https://github.com/rbenv/rbenv)
