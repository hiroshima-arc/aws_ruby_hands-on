namespace :sam do
  namespace :app do
    APP_DIR = "#{WORK}/dev/sam-app".freeze

    namespace :local do
      desc 'ローカルサーバー実行'
      task :api do
        cd APP_DIR do
          sh 'sam local start-api --host 0.0.0.0'
        end
      end

      desc 'ローカル実行'
      task invoke: %i[hellow_world:hello fizz_buzz:generate fizz_buzz:iterate]
      namespace :hellow_world do
        task :hello do
          cd APP_DIR do
            sh 'sam local invoke HelloWorldFunction --event tests/hello_world/event_file.json'
          end
        end
      end

      namespace :fizz_buzz do
        task :generate do
          cd APP_DIR do
            sh 'sam local invoke FizzBuzzGenerateFunction --event tests/fizz_buzz/event_file.json'
          end
        end

        task :iterate do
          cd APP_DIR do
            sh 'sam local invoke FizzBuzzIterateFunction --event tests/fizz_buzz/event_file.json'
          end
        end
      end
    end

    desc 'チェック'
    task :validate do
      cd APP_DIR do
        sh 'sam validate'
      end
    end

    desc 'アプリケーションパッケージバンドル'
    task :vendor do
      cd APP_DIR do
        FileUtils.rm_rf('hello_world/vendor/')
        FileUtils.rm_rf('fizz_buzz/vendor/')
        sh 'bundle install'
        sh 'bundle install --deployment --path hello_world/vendor/bundle'
        sh 'bundle install --deployment --path fizz_buzz/vendor/bundle'
      end
    end

    desc 'パッケージ'
    task :package do
      cd APP_DIR do
        sh 'sam package --template-file template.yaml --s3-bucket ruby-hands-on --output-template-file packaged.yaml'
      end
    end

    desc 'デプロイ'
    task :deploy do
      cd APP_DIR do
        sh 'sam deploy --template-file packaged.yaml --stack-name ruby-hands-on-development --capabilities CAPABILITY_IAM'
      end
    end

    desc '確認'
    task :check do
      cd APP_DIR do
        sh "aws cloudformation describe-stacks --stack-name ruby-hands-on-development --query 'Stacks[].Outputs[1]'"
      end
    end

    desc 'リリース'
    task release: %i[vendor validate package deploy check]
  end

  namespace :client do
    CLI_DIR = "#{WORK}/dev/sam-client".freeze

    namespace :local do
      desc 'ローカルサーバー実行'
      task :api do
        cd CLI_DIR do
          sh 'sam local start-api --host 0.0.0.0'
        end
      end

      desc 'ローカル実行'
      task invoke: %i[hellow_world:hello]
      namespace :hellow_world do
        task :hello do
          cd CLI_DIR do
            sh 'sam local invoke HelloWorldFunction --event services/tests/hello_world/event_file.json'
          end
        end
      end
    end

    desc 'チェック'
    task :validate do
      cd CLI_DIR do
        sh 'sam validate'
      end
    end

    desc 'アプリケーションパッケージバンドル'
    task :vendor do
      cd CLI_DIR do
        FileUtils.rm_rf('vendor/')
        sh 'bundle install'
        sh 'bundle install --deployment'
        FileUtils.rm_rf('services/hello_world/vendor/')
        sh 'cd services ; bundle install'
        sh 'cd services ; bundle install --deployment --path hello_world/vendor/bundle'
      end
    end

    desc 'パッケージ'
    task :package do
      cd CLI_DIR do
        sh 'sam package --template-file template.yaml --s3-bucket ruby-hands-on --output-template-file packaged.yaml'
      end
    end

    desc 'デプロイ'
    task :deploy do
      cd CLI_DIR do
        sh 'sam deploy --template-file packaged.yaml --stack-name ruby-hands-on-development --capabilities CAPABILITY_IAM'
      end
    end

    desc '確認'
    task :check do
      cd CLI_DIR do
        sh "aws cloudformation describe-stacks --stack-name ruby-hands-on-development --query 'Stacks[].Outputs[1]'"
      end
    end

    desc 'リリース'
    task release: %i[vendor validate package deploy check]
  end
end
